part of 'todo_detail_bloc.dart';

enum TodoDetailStatus {
  initial,
  loading,
  loaded,
  error,
}

class TodoDetailState extends Equatable {
  final TodoDetailStatus status;
  final List<EntryId> entryId;

  const TodoDetailState({
    required this.status,
    required this.entryId,
  });

  factory TodoDetailState.initial() {
    return const TodoDetailState(status: TodoDetailStatus.initial, entryId: []);
  }

  @override
  List<Object> get props => [status, entryId];

  @override
  String toString() => 'TodoDetailState(status: $status, entryId: $entryId)';

  TodoDetailState copyWith({
    TodoDetailStatus? status,
    List<EntryId>? entryId,
  }) {
    return TodoDetailState(
      status: status ?? this.status,
      entryId: entryId ?? this.entryId,
    );
  }
}
