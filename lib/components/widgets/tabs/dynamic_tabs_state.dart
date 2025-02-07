import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DynamicTabEvent {}

class DynamicTabChanged extends DynamicTabEvent {
  final int newIndex;
  DynamicTabChanged(this.newIndex);
}

class DynamicTabState {
  final int selectedIndex;
  DynamicTabState(this.selectedIndex);
}

class DynamicTabBloc extends Bloc<DynamicTabEvent, DynamicTabState> {
  DynamicTabBloc() : super(DynamicTabState(0)) {
    on<DynamicTabChanged>((event, emit) {
      emit(DynamicTabState(event.newIndex));
    });
  }
}
