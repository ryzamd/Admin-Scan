import 'package:equatable/equatable.dart';

abstract class HomeDataEvent extends Equatable {
  const HomeDataEvent();

  @override
  List<Object> get props => [];
}

class GetHomeDataEvent extends HomeDataEvent {
  final String date;
  
  const GetHomeDataEvent({required this.date});
  
  @override
  List<Object> get props => [date];
}

class RefreshHomeDataEvent extends HomeDataEvent {
  final String date;
  
  const RefreshHomeDataEvent({required this.date});
  
  @override
  List<Object> get props => [date];
}

class SortHomeDataEvent extends HomeDataEvent {
  final String column;
  final bool ascending;

  const SortHomeDataEvent({
    required this.column,
    required this.ascending,
  });

  @override
  List<Object> get props => [column, ascending];
}

class SearchHomeDataEvent extends HomeDataEvent {
  final String query;

  const SearchHomeDataEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SelectDateEvent extends HomeDataEvent {
  final DateTime selectedDate;
  
  const SelectDateEvent({required this.selectedDate});
  
  @override
  List<Object> get props => [selectedDate];
}

class GetHomeDataItemsEvent extends HomeDataEvent {
  final String date;
  
  const GetHomeDataItemsEvent({required this.date});
  
  @override
  List<Object> get props => [date];
}