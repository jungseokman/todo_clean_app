import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_clean_appp/application/core/form_value.dart';

import 'package:todo_clean_appp/application/core/page_config.dart';
import 'package:todo_clean_appp/application/pages/create_todo_entry/cubit/create_todo_entry_cubit.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';
import 'package:todo_clean_appp/domain/use_cases/create_todo_entry.dart';

class CreateTodoEntryPageProvider extends StatelessWidget {
  const CreateTodoEntryPageProvider({
    Key? key,
    required this.collectionId,
  }) : super(key: key);

  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoEntryCubit(
          collectionId: collectionId,
          addTodoEntry: CreateTodoEntry(
              todoRepository: RepositoryProvider.of<TodoRepository>(context))),
      child: const CreateTodoEntryPage(),
    );
  }
}

class CreateTodoEntryPage extends StatefulWidget {
  const CreateTodoEntryPage({super.key});

  static final pageConfig = PageConfig(
      icon: Icons.add_task_rounded,
      name: 'create_todo_entry',
      child: const Placeholder());

  @override
  State<CreateTodoEntryPage> createState() => _CreateTodoEntryPageState();
}

class _CreateTodoEntryPageState extends State<CreateTodoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'description'),
                onChanged: (value) {
                  context
                      .read<CreateTodoEntryCubit>()
                      .descriptionChanged(description: value);
                },
                validator: (value) {
                  final currentValidationState = context
                          .read<CreateTodoEntryCubit>()
                          .state
                          .description
                          ?.validationStatus ??
                      ValidationStatus.pending;
                  switch (currentValidationState) {
                    case ValidationStatus.success:
                      return '입력해주세요';
                    case ValidationStatus.pending:
                    case ValidationStatus.error:
                      return null;
                    default:
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid == true) {
                      context.read<CreateTodoEntryCubit>().submit();
                      context.pop();
                    }
                  },
                  child: const Text('save entry'))
            ],
          )),
    );
  }
}
