import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_appp/application/app/main_page.dart';
import 'package:todo_clean_appp/data/repositories/todo_repository_mock.dart';
import 'package:todo_clean_appp/domain/repositories/todo_repository.dart';

void main() {
  runApp(RepositoryProvider<TodoRepository>(
    create: (context) => TodoRepositoryMock(),
    child: const MainPage(),
  ));
}
