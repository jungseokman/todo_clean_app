import 'package:flutter/material.dart';

class TodoOverviewError extends StatelessWidget {
  const TodoOverviewError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text('에러 발생, 다시 시도하세요.'),
    );
  }
}
