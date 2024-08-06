import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:todo_clean_appp/blocs/todo_entry_item/todo_entry_item_bloc.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';
import 'package:todo_clean_appp/domain/use_cases/load_todo_entry.dart';
import 'package:todo_clean_appp/domain/use_cases/update_todo_entry.dart';

class TodoEntryItemProvider extends StatelessWidget {
  const TodoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoEntryItemBloc>(
      create: (context) => TodoEntryItemBloc()
        ..add(
          ReadTodoEntryItemEvent(
            entryId: entryId,
            collectionId: collectionId,
            loadTodoEntry: LoadTodoEntry(
              todoRepository: RepositoryProvider.of<TodoRepository>(context),
            ),
          ),
        ),
      child: TodoEntryItem(
        collectionId: collectionId,
        entryId: entryId,
      ),
    );
  }
}

class TodoEntryItem extends StatelessWidget {
  const TodoEntryItem({
    Key? key,
    required this.collectionId,
    required this.entryId,
  }) : super(key: key);

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return Center(child: BlocBuilder<TodoEntryItemBloc, TodoEntryItemState>(
      builder: (context, state) {
        if (state.todoEntryItemStatus == TodoEntryItemStatus.loading) {
          return ListTile(
            title: Shimmer(
              color: Theme.of(context).colorScheme.onBackground,
              child: const Text('Loading'),
            ),
          );
        }

        if (state.todoEntryItemStatus == TodoEntryItemStatus.error) {
          return const ListTile(
            onTap: null,
            leading: Icon(Icons.warning_rounded),
            title: Text('아이템을 가져올 수 없습니다.'),
          );
        }

        return CheckboxListTile(
          value: state.todoEntry.isDone,
          onChanged: (value) {
            context.read<TodoEntryItemBloc>().add(UpdateTodoEntryItemEvent(
                entryId: entryId,
                collectionId: collectionId,
                updateTodoEntry: UpdateTodoEntry(
                    todoRepository:
                        RepositoryProvider.of<TodoRepository>(context))));
            print(state.todoEntry);
          },
          title: Text(state.todoEntry.desc),
        );
      },
    ));
  }
}
