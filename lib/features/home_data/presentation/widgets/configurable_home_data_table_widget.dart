import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/get_translate_key.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../config/home_data_config.dart';
import '../../domain/entities/home_data_entity.dart';
import '../bloc/home_data_bloc.dart';
import '../bloc/home_data_event.dart';
import '../bloc/home_data_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfigurableHomeDataTable extends StatelessWidget {
  final UserEntity user;
  final HomeDataConfig config;
  
  const ConfigurableHomeDataTable({
    super.key,
    required this.user,
    required this.config,
  });

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

    final multiLanguage = AppLocalizations.of(context);

    return BlocBuilder<HomeDataBloc, HomeDataState>(
      builder: (context, state) {
        if (state is HomeDataInitial || state is HomeDataLoading) {
          return const Center(child: CircularProgressIndicator());

        } else if (state is HomeDataError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorDialog.showAsync(
              context,
              title: multiLanguage.errorUPCASE,
              message: TranslateKey.getStringKey(multiLanguage, state.message),
            );
          });

          return Center(child: Text(multiLanguage.errorLoadingDataMessage));

        } else if (state is HomeDataLoaded || state is HomeDataRefreshing) {

          final items = state is HomeDataLoaded ? state.filteredItems : (state as HomeDataRefreshing).items;

          final sortColumn = state is HomeDataLoaded ? state.sortColumn : config.defaultSortColumn;
          final ascending = state is HomeDataLoaded ? state.ascending : config.defaultSortAscending;
          final isRefreshing = state is HomeDataRefreshing;

          return Stack(
            children: [
              Column(
                children: [
                  _buildTableHeader(context, sortColumn, ascending),
                  Expanded(
                    child: items.isEmpty ? Center(child: Text(multiLanguage.noDataAvailableMessage)) : _buildTableBody(items),
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

        return Center(child: Text(multiLanguage.noDataMessage));
      },
    );
  }

  Widget _buildTableHeader(BuildContext context, String sortColumn, bool ascending) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF1d3557),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCommon.withValues(alpha: 0.2),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: config.displayColumns.map((column) {
          final title = config.columnTitles[column] ?? column;
          final flex = config.columnFlex[column] ?? 1;
          final isSort = sortColumn == column;
          
          return _buildHeaderCell(
            title,
            flex: flex,
            onTap: () => _onSortColumn(context, column),
            isSort: isSort,
            ascending: ascending && isSort,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1, VoidCallback? onTap, bool isSort = false, bool ascending = false}) {
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
                    color: AppColors.whiteCommon,
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
                    color: AppColors.whiteCommon,
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
          color: index % 2 == 0 ? const Color(0xFFFAF1E6) : const Color(0xFFF5E6CC),
          child: _buildDataRow(items[index], context),
        );
      },
    );
  }

  Widget _buildDataRow(HomeDataEntity item, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: config.displayColumns.map((column) {
        final flex = config.columnFlex[column] ?? 1;
        return Expanded(
          flex: flex,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Text(
              _getFieldValue(item, column, context),
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getFieldValue(HomeDataEntity item, String fieldName, BuildContext context) {
    final multiLanguage = AppLocalizations.of(context);

    switch (fieldName) {
      case HomeDataConfig.COL_NAME:
        return item.mName;
      case HomeDataConfig.COL_PROJECT_CODE:
        return item.mPrjcode;
      case HomeDataConfig.COL_QTY:
        return item.mQty.toString();
      case HomeDataConfig.COL_QC_QTY_IN:
        return item.qcQtyIn.toString();
      case HomeDataConfig.COL_QC_QTY_OUT:
        return item.qcQtyOut.toString();
      case HomeDataConfig.COL_WAREHOUSE_QTY_INT:
        return item.zcWarehouseQtyImport.toString();
      case HomeDataConfig.COL_WAREHOUSE_QTY_OUT:
        return item.zcWarehouseQtyExport.toString();
      case HomeDataConfig.COL_DATE:
        return _formatDate(item.mDate, context);
      case HomeDataConfig.COL_QTY_STATE:
        return item.qtyState;
      case HomeDataConfig.COL_UP_IN_QTY_TIME:
        return item.zcUpInQtyTime ?? multiLanguage.noDataMessage;
      case HomeDataConfig.COL_QC_UP_IN_QTY_TIME:
        return item.qcUpInQtyTime ?? multiLanguage.noDataMessage;
      case HomeDataConfig.COL_IN_QC_QTY_TIME:
        return item.zcInQcQtyTime ?? multiLanguage.noDataMessage;
      case HomeDataConfig.COL_ADMIN_ALL_DATA_TIME:
        return item.adminAllDataTime ?? multiLanguage.noDataMessage;
      default:
        return multiLanguage.noDataMessage;
    }
  }

  String _formatDate(String dateString, BuildContext context) {
    final multiLanguage = AppLocalizations.of(context);

    if (dateString.isEmpty) return multiLanguage.noDataMessage;
    
    if (dateString.contains('T')) {
      return dateString.split('T')[0];
    }
    
    return dateString;
  }
}