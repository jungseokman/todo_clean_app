import 'package:flutter/material.dart';

class TodoDetailError extends StatelessWidget {
  const TodoDetailError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('디테일 페이지 에러, 다시 시도하세요.'),
    );
  }
}
