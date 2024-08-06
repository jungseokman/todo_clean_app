part of 'todo_overview_bloc.dart';

abstract class TodoOverviewEvent extends Equatable {
  const TodoOverviewEvent();

  @override
  List<Object> get props => [];
}

class ReadTodoOverviewEvent extends TodoOverviewEvent {}
