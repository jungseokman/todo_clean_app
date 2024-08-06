part of 'create_todo_entry_cubit.dart';

class CreateTodoEntryState extends Equatable {
  const CreateTodoEntryState({
    this.description,
  });

  final FormValue<String?>? description;

  @override
  List<Object?> get props => [description];

  CreateTodoEntryState copyWith({
    FormValue<String?>? description,
  }) {
    return CreateTodoEntryState(
      description: description ?? this.description,
    );
  }
}
