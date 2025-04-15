import 'package:equatable/equatable.dart';
import '../../domain/entities/home_data_entity.dart';

abstract class HomeDataState extends Equatable {
  const HomeDataState();

  @override
  List<Object> get props => [];
}

class HomeDataInitial extends HomeDataState {}

class HomeDataLoading extends HomeDataState {}

class HomeDataRefreshing extends HomeDataState {
  final List<HomeDataEntity> items;

  const HomeDataRefreshing({required this.items});

  @override
  List<Object> get props => [items];
}

class HomeDataLoaded extends HomeDataState {
  final List<HomeDataEntity> items;
  final List<HomeDataEntity> filteredItems;
  final String sortColumn;
  final bool ascending;
  final String searchQuery;

  const HomeDataLoaded({
    required this.items,
    required this.filteredItems,
    required this.sortColumn,
    required this.ascending,
    this.searchQuery = '',
  });

  @override
  List<Object> get props => [
    items,
    filteredItems,
    sortColumn,
    ascending,
    searchQuery,
  ];

  HomeDataLoaded copyWith({
    List<HomeDataEntity>? items,
    List<HomeDataEntity>? filteredItems,
    String? sortColumn,
    bool? ascending,
    String? searchQuery,
  }) {
    return HomeDataLoaded(
      items: items ?? this.items,
      filteredItems: filteredItems ?? this.filteredItems,
      sortColumn: sortColumn ?? this.sortColumn,
      ascending: ascending ?? this.ascending,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeDataError extends HomeDataState {
  final String message;

  const HomeDataError({required this.message});

  @override
  List<Object> get props => [message];
}