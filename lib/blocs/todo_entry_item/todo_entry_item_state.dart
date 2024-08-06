part of 'todo_entry_item_bloc.dart';

enum TodoEntryItemStatus { initial, loading, loaded, error }

class TodoEntryItemState extends Equatable {
  final TodoEntry todoEntry;
  final TodoEntryItemStatus todoEntryItemStatus;
  const TodoEntryItemState({
    required this.todoEntry,
    required this.todoEntryItemStatus,
  });

  factory TodoEntryItemState.intial() {
    return TodoEntryItemState(
        todoEntry: TodoEntry.initial(),
        todoEntryItemStatus: TodoEntryItemStatus.initial);
  }

  @override
  List<Object> get props => [todoEntry, todoEntryItemStatus];

  @override
  String toString() =>
      'TodoEntryItemState(todoEntry: $todoEntry, todoEntryItemStatus: $todoEntryItemStatus)';

  TodoEntryItemState copyWith({
    TodoEntry? todoEntry,
    TodoEntryItemStatus? todoEntryItemStatus,
  }) {
    return TodoEntryItemState(
      todoEntry: todoEntry ?? this.todoEntry,
      todoEntryItemStatus: todoEntryItemStatus ?? this.todoEntryItemStatus,
    );
  }
}
