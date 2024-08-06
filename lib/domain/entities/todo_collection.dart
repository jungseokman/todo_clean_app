import 'package:todo_clean_appp/domain/entities/todo_color.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';

class TodoCollection {
  final String title;
  final TodoColor color;
  final CollectionId id;
  TodoCollection({
    required this.title,
    required this.color,
    required this.id,
  });

  factory TodoCollection.initial() {
    return TodoCollection(
      id: CollectionId(),
      title: '',
      color: TodoColor(
        colorIndex: 0,
      ),
    );
  }

  TodoCollection copyWith({
    String? title,
    TodoColor? color,
    CollectionId? id,
  }) {
    return TodoCollection(
      title: title ?? this.title,
      color: color ?? this.color,
      id: id ?? this.id,
    );
  }
}
