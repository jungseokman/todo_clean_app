import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_appp/domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoState> {
  NavigationTodoCubit() : super(const NavigationTodoState());

  void selectedTodoCollectionChanged(CollectionId collectionId) {
    emit(NavigationTodoState(selectedCollectionId: collectionId));
  }

  void secondBodyHasChanged({required bool isSecondBodyDisplayed}) {
    if (state.secondBodyIsDisplayed != isSecondBodyDisplayed) {
      emit(NavigationTodoState(
          secondBodyIsDisplayed: isSecondBodyDisplayed,
          selectedCollectionId: state.selectedCollectionId));
    }
  }
}
