import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_clean_appp/application/core/page_config.dart';
import 'package:todo_clean_appp/application/pages/create_todo_collection/cubit/create_todo_collection_page_cubit.dart';
import 'package:todo_clean_appp/domain/entities/todo_color.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';
import 'package:todo_clean_appp/domain/use_cases/create_todo_collection.dart';

class CreateTodoCollectionPageProvider extends StatelessWidget {
  const CreateTodoCollectionPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTodoCollectionPageCubit(
          createTodoCollecion: CreateTodoCollecion(
              todoRepository: RepositoryProvider.of<TodoRepository>(context))),
      child: const CreateTodoCollectionPage(),
    );
  }
}

class CreateTodoCollectionPage extends StatefulWidget {
  const CreateTodoCollectionPage({super.key});

  static final pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
    child: const CreateTodoCollectionPageProvider(),
  );

  @override
  State<CreateTodoCollectionPage> createState() =>
      _CreateTodoCollectionPageState();
}

class _CreateTodoCollectionPageState extends State<CreateTodoCollectionPage> {
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
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) => context
                  .read<CreateTodoCollectionPageCubit>()
                  .titleChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Color'),
              onChanged: (value) => context
                  .read<CreateTodoCollectionPageCubit>()
                  .colorChanged(value),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final parsedColorIndex = int.tryParse(value);
                  if (parsedColorIndex == null ||
                      parsedColorIndex < 0 ||
                      parsedColorIndex > TodoColor.predefinedColors.length) {
                    return 'Only numbers between 0 and ${TodoColor.predefinedColors.length} are allowed';
                  }
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  final isValide = _formKey.currentState?.validate();
                  if (isValide == true) {
                    context.read<CreateTodoCollectionPageCubit>().submit();
                    context.pop();
                  }
                },
                child: const Text('Save Collection'))
          ],
        ),
      ),
    );
  }
}
