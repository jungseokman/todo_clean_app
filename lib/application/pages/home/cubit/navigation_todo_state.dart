part of 'navigation_todo_cubit.dart';

class NavigationTodoState extends Equatable {
  const NavigationTodoState({
    this.selectedCollectionId,
    this.secondBodyIsDisplayed,
  });

  final CollectionId? selectedCollectionId;
  final bool? secondBodyIsDisplayed;

  @override
  List<Object?> get props => [selectedCollectionId, secondBodyIsDisplayed];
}
