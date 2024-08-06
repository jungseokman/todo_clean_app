import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_appp/core/use_case.dart';
import 'package:todo_clean_appp/domain/entities/todo_collection.dart';
import 'package:todo_clean_appp/domain/entities/todo_color.dart';
import 'package:todo_clean_appp/domain/use_cases/create_todo_collection.dart';

part 'create_todo_collection_page_state.dart';

class CreateTodoCollectionPageCubit
    extends Cubit<CreateTodoCollectionPageState> {
  CreateTodoCollectionPageCubit({required this.createTodoCollecion})
      : super(const CreateTodoCollectionPageState());

  final CreateTodoCollecion createTodoCollecion;

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String color) {
    emit(state.copyWith(color: color));
  }

  Future<void> submit() async {
    final parsedColorIndex = int.tryParse(state.color ?? '0') ?? 0;
    await createTodoCollecion.call(TodoCollectionParams(
        collection: TodoCollection.initial().copyWith(
            title: state.title,
            color: TodoColor(colorIndex: parsedColorIndex))));
  }
}
