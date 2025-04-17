import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/auth/auth_repository.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../auth/login/domain/entities/user_entity.dart';
import '../../config/home_data_config.dart';
import '../bloc/home_data_bloc.dart';
import '../bloc/home_data_event.dart';
import 'configurable_home_data_table_widget.dart';

class HomeDataComponent extends StatefulWidget {
  final UserEntity user;
  final HomeDataConfig config;
  final HomeDataBloc? bloc;
  
  const HomeDataComponent({
    super.key,
    required this.user,
    required this.config,
    this.bloc,
  });

  @override
  State<HomeDataComponent> createState() => _HomeDataComponentState();
}

class _HomeDataComponentState extends State<HomeDataComponent> {
  late final TextEditingController _searchController;
  late final HomeDataBloc _bloc;
  
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _bloc = widget.bloc ?? context.read<HomeDataBloc>();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      di.sl<AuthRepository>().debugTokenStateAsync().then((_) {
        if (mounted) {
          _bloc.loadData();
        }
      });
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    if (widget.bloc == null) {
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 8),
        Expanded(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ConfigurableHomeDataTable(
                user: widget.user,
                config: widget.config,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              _bloc.add(const SearchHomeDataEvent(query: ''));
              FocusScope.of(context).unfocus();
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14
          ),
        ),
        onChanged: (value) {
          _bloc.add(SearchHomeDataEvent(query: value));
        },
      ),
    );
  }
}