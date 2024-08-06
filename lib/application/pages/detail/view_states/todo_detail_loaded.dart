import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_clean_appp/application/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_clean_appp/application/pages/create_todo_entry/create_todo_entry_page.dart';

import 'package:todo_clean_appp/domain/entities/unique_id.dart';

class TodoDetailLoaded extends StatelessWidget {
  const TodoDetailLoaded({
    Key? key,
    required this.entryIds,
    required this.collectionId,
  }) : super(key: key);

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(9),
      child: Stack(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              return TodoEntryItemProvider(
                  collectionId: collectionId, entryId: entryIds[index]);
            },
            itemCount: entryIds.length,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-entry'),
              onPressed: () {
                context.pushNamed(CreateTodoEntryPage.pageConfig.name,
                    extra: collectionId);
              },
              child: const Icon(Icons.add_rounded),
            ),
          )
        ],
      ),
    ));
  }
}
