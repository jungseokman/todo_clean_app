import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_clean_appp/application/core/form_value.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/use_cases/create_todo_entry.dart';

part 'create_todo_entry_state.dart';

class CreateTodoEntryCubit extends Cubit<CreateTodoEntryState> {
  CreateTodoEntryCubit({
    required this.collectionId,
    required this.addTodoEntry,
  }) : super(const CreateTodoEntryState());

  final CollectionId collectionId;
  final CreateTodoEntry addTodoEntry;

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;
    if (description == null || description.isEmpty) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }

    emit(state.copyWith(
        description:
            FormValue(value: description, validationStatus: currentStatus)));
  }

  void submit() {}
}
