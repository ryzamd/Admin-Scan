import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/auth/auth_repository.dart';
import '../../../../core/di/dependencies.dart' as di;
import '../../../../core/widgets/scafford_custom.dart';
import '../../../auth/login/domain/entities/user_entity.dart';
import '../bloc/home_data_bloc.dart';
import '../bloc/home_data_event.dart';
import '../widgets/home_data_table_widget.dart';

class HomeDataPage extends StatefulWidget {
  final UserEntity user;
  
  const HomeDataPage({super.key, required this.user});

  @override
  State<HomeDataPage> createState() => _HomeDataPageState();
}

class _HomeDataPageState extends State<HomeDataPage> {
  late final TextEditingController _searchController;
  
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      di.sl<AuthRepository>().debugTokenStateAsync().then((_) {
        if (mounted) {
          context.read<HomeDataBloc>().loadData();
        }
      });
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'HOME DATA',
      user: widget.user,
      currentIndex: 0,
      showBackButton: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
                  child: HomeDataTableWidget(user: widget.user),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.white),
          onPressed: () {
            context.read<HomeDataBloc>().refreshData();
          },
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
              context.read<HomeDataBloc>().add(
                const SearchHomeDataEvent(query: ''),
              );
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
          context.read<HomeDataBloc>().add(
            SearchHomeDataEvent(query: value),
          );
        },
      ),
    );
  }
}