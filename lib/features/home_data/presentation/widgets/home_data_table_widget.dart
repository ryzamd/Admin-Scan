import 'package:admin_scan/core/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../domain/entities/home_data_entity.dart';
import '../bloc/home_data_bloc.dart';
import '../bloc/home_data_event.dart';
import '../bloc/home_data_state.dart';

class HomeDataTableWidget extends StatelessWidget {
  final UserEntity user;
  const HomeDataTableWidget({super.key, required this.user});

  void _onSortColumn(BuildContext context, String column) {
    context.read<HomeDataBloc>().add(
      SortHomeDataEvent(
        column: column,
        ascending: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDataBloc, HomeDataState>(
      builder: (context, state) {
        if (state is HomeDataInitial || state is HomeDataLoading) {
          return const Center(child: CircularProgressIndicator());

        } else if (state is HomeDataError) {
          ErrorDialog.showAsync(
            context,
            title: 'Error',
            message: state.message,
          );
          
        } else if (state is HomeDataLoaded || state is HomeDataRefreshing) {
          final items =
              state is HomeDataLoaded
                  ? state.filteredItems
                  : (state as HomeDataRefreshing).items;

          final sortColumn =
              state is HomeDataLoaded ? state.sortColumn : 'date';
          final ascending = state is HomeDataLoaded ? state.ascending : true;
          final isRefreshing = state is HomeDataRefreshing;

          return Stack(
            children: [
              Column(
                children: [
                  _buildTableHeader(context, sortColumn, ascending),
                  Expanded(
                    child:
                        items.isEmpty
                            ? const Center(child: Text('No data available'))
                            : _buildTableBody(items),
                  ),
                ],
              ),
              if (isRefreshing)
                const Positioned.fill(
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        }

        return const Center(child: Text('No data'));
      },
    );
  }

  Widget _buildTableHeader(BuildContext context, String sortColumn, bool ascending) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFF1d3557),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildHeaderCell('名稱', flex: 3),
          _buildHeaderCell('指令號', flex: 2),
          _buildHeaderCell('入庫數量', flex: 2),
          _buildHeaderCell('出庫數量', flex: 2),
          _buildHeaderCell('資材入庫', flex: 1),
          _buildHeaderCell('資材出庫', flex: 1),
          _buildHeaderCell('時間', flex: 2,
            onTap: () => _onSortColumn(context, 'date'),
            isSort: sortColumn == 'date',
            ascending: ascending
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 0, VoidCallback? onTap, bool isSort = false, bool ascending = false}) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (isSort)
                SizedBox(
                  width: 10,
                  height: 20,
                  child: Icon(
                    ascending ? Icons.arrow_downward : Icons.arrow_upward,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableBody(List<HomeDataEntity> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color:
              index % 2 == 0 ? const Color(0xFFFAF1E6) : const Color(0xFFF5E6CC),
          child: _buildDataRow(items[index]),
        );
      },
    );
  }

  Widget _buildDataRow(HomeDataEntity item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Text(
              item.mName,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Text(
              item.mPrjcode,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              item.qcQtyIn.toString(),
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              item.qcQtyOut.toString(),
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '${item.zcWarehouseQtyImport}',
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              '${item.zcWarehouseQtyExport}',
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Text(
              _formatDate(item.mDate),
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '';
    
    if (dateString.contains('T')) {
      return dateString.split('T')[0];
    }
    
    return dateString;
  }
}