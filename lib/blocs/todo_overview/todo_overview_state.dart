part of 'todo_overview_bloc.dart';

enum TodoOverViewStatus {
  initial,
  loading,
  loaded,
  error,
}

class TodoOverviewState extends Equatable {
  final TodoOverViewStatus todoOverViewStatus;
  final List<TodoCollection> collections;

  const TodoOverviewState({
    required this.todoOverViewStatus,
    required this.collections,
  });

  factory TodoOverviewState.initial() {
    return const TodoOverviewState(
        todoOverViewStatus: TodoOverViewStatus.initial, collections: []);
  }

  @override
  List<Object> get props => [todoOverViewStatus, collections];

  TodoOverviewState copyWith({
    TodoOverViewStatus? todoOverViewStatus,
    List<TodoCollection>? collections,
  }) {
    return TodoOverviewState(
      todoOverViewStatus: todoOverViewStatus ?? this.todoOverViewStatus,
      collections: collections ?? this.collections,
    );
  }

  @override
  String toString() =>
      'TodoOverviewState(todoOverViewStatus: $todoOverViewStatus, collections: $collections)';
}
