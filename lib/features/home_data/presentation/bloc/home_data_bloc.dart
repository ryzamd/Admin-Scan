import 'dart:async';

import 'package:admin_scan/features/auth/login/domain/entities/user_entity.dart';
import 'package:admin_scan/features/home_data/domain/usecases/get_home_data.dart';
import 'package:admin_scan/features/home_data/presentation/bloc/helper.dart';
import 'package:admin_scan/features/home_data/presentation/bloc/home_data_event.dart';
import 'package:admin_scan/features/home_data/presentation/bloc/home_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/home_data_entity.dart';


class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  UserEntity user;
  GetHomeData getHomeData;
  
  HomeDataBloc({required this.getHomeData, required this.user}) : super(HomeDataInitial()) {
    on<GetHomeDataEvent>(_onGetHomeDataAsync);
    on<RefreshHomeDataEvent>(_onRefreshHomeDataAsync);
    on<SortHomeDataEvent>(_onSortHomeDataAsync);
    on<SearchHomeDataEvent>(_onSearchHomeDataAsync);
    on<SelectDateEvent>(_onSelectDate);
  }

  FutureOr<void> _onGetHomeDataAsync(GetHomeDataEvent event, Emitter<HomeDataState> emit) async {
    try {
      emit(HomeDataLoading());

      final result = await getHomeData(HomeDataParams(date: event.date));

      await result.fold(
        (failure) async => emit(HomeDataError(message: failure.message)),
        (items) async {
          
          final sortedItems = List<HomeDataEntity>.from(items);
          await HomeDataHelper.sortItemsByDateAsync(sortedItems, false);

          emit(HomeDataLoaded(
            items: items,
            filteredItems: items,
            sortColumn: 'date',
            ascending: false,
            selectedDate: DateTime.now(),
          ));
        },
      );

    } catch (e) {
       emit(HomeDataError(message: 'Error loading data: ${e.toString()}'));
    }
  }

  FutureOr<void> _onRefreshHomeDataAsync(RefreshHomeDataEvent event, Emitter<HomeDataState> emit) async {
    final currentState = state;

    if (currentState is HomeDataLoaded) {
      final existingItems = List<HomeDataEntity>.from(currentState.items);

      emit(HomeDataRefreshing(items: existingItems));

      try {
        final result = await getHomeData(HomeDataParams(date: event.date));

       await result.fold(
          (failure) async {
            emit(
              HomeDataLoaded(
                items: existingItems,
                filteredItems: await HomeDataHelper.filterItemsAsync(
                  existingItems,
                  currentState.searchQuery,
                ),
                sortColumn: currentState.sortColumn,
                ascending: currentState.ascending,
                searchQuery: currentState.searchQuery,
                selectedDate: DateTime.now(),
              ),
            );

            emit(HomeDataError(message: failure.message));
          },

          (items) async {
            final filteredItems = await HomeDataHelper.filterItemsAsync(
              items,
              currentState.searchQuery,
            );
            await HomeDataHelper.sortItemsAsync(
              filteredItems,
              currentState.sortColumn,
              currentState.ascending,
            );

            emit(
              HomeDataLoaded(
                items: items,
                filteredItems: filteredItems,
                sortColumn: currentState.sortColumn,
                ascending: currentState.ascending,
                searchQuery: currentState.searchQuery,
                selectedDate: DateTime.now(),
              ),
            );
          },
        );
      } catch (e) {
        emit(
          HomeDataLoaded(
            items: existingItems,
            filteredItems: await HomeDataHelper.filterItemsAsync(
              existingItems,
              currentState.searchQuery,
            ),
            sortColumn: currentState.sortColumn,
            ascending: currentState.ascending,
            searchQuery: currentState.searchQuery,
            selectedDate: DateTime.now(),
          ),
        );

        emit(
          HomeDataError(message: 'Error refreshing data: ${e.toString()}'),
        );
      }
    } else {
      add(GetHomeDataEvent(date: event.date));
    }
  }

  FutureOr<void> _onSortHomeDataAsync(SortHomeDataEvent event, Emitter<HomeDataState> emit) async {
    final currentState = state;

    if (currentState is HomeDataLoaded) {

      final sortedItems = List<HomeDataEntity>.from(currentState.filteredItems);

      final sortColumn = event.column;
      final ascending = sortColumn == currentState.sortColumn ? currentState.ascending : !event.ascending;

      await HomeDataHelper.sortItemsAsync(sortedItems, sortColumn, ascending);

      emit(currentState.copyWith(filteredItems: sortedItems, sortColumn: sortColumn, ascending: ascending,),);
    }
  }

  FutureOr<void> _onSearchHomeDataAsync(SearchHomeDataEvent event, Emitter<HomeDataState> emit) async {
    final currentState = state;

    if (currentState is HomeDataLoaded) {
      final filteredItems = await HomeDataHelper.filterItemsAsync(currentState.items, event.query);

      await HomeDataHelper.sortItemsAsync(filteredItems, currentState.sortColumn, currentState.ascending);

      emit(currentState.copyWith(filteredItems: filteredItems, searchQuery: event.query,),);
    }
  }

  Future<void> _onSelectDate(SelectDateEvent event, Emitter<HomeDataState> emit) async {
    final currentState = state;
    
    if (currentState is HomeDataLoaded) {
      emit(currentState.copyWith(selectedDate: event.selectedDate));

      add(RefreshHomeDataEvent(date: formatDateTime(event.selectedDate)));

    } else {
      add(GetHomeDataItemsEvent(date: formatDateTime(event.selectedDate)));
      
    }
  }

  String formatDateTime(DateTime formattedDate){
    return "${formattedDate.year}-${formattedDate.month.toString().padLeft(2, '0')}-${formattedDate.day.toString().padLeft(2, '0')}";
  }
  
  void loadData() {
    final now = DateTime.now();
    add(GetHomeDataEvent(date: formatDateTime(now)));
  }

  void refreshData() {
    final now = DateTime.now();
    add(RefreshHomeDataEvent(date: formatDateTime(now)));
  }
}

