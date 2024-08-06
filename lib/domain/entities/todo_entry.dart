import 'package:todo_clean_appp/domain/entities/unique_id.dart';

class TodoEntry {
  final String desc;
  final bool isDone;
  final EntryId id;
  TodoEntry({
    required this.desc,
    required this.isDone,
    required this.id,
  });

  factory TodoEntry.initial() {
    return TodoEntry(
      desc: '',
      isDone: false,
      id: EntryId(),
    );
  }

  TodoEntry copyWith({
    String? desc,
    bool? isDone,
    EntryId? id,
  }) {
    return TodoEntry(
      desc: desc ?? this.desc,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
    );
  }

  @override
  String toString() => 'TodoEntry(desc: $desc, isDone: $isDone, id: $id)';
}
