part of 'create_todo_collection_page_cubit.dart';

class CreateTodoCollectionPageState extends Equatable {
  const CreateTodoCollectionPageState({
    this.title,
    this.color,
  });

  final String? title;
  final String? color;

  @override
  List<Object?> get props => [title, color];

  CreateTodoCollectionPageState copyWith({
    String? title,
    String? color,
  }) {
    return CreateTodoCollectionPageState(
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }
}
