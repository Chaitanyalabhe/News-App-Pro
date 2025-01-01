import 'package:flutter_bloc/flutter_bloc.dart';

// Define the events
abstract class FormEvent {}

class SubmitFormEvent extends FormEvent {
  final Map<String, String> formData;

  SubmitFormEvent(this.formData);
}

// Define the states
abstract class FormState {}

class FormInitialState extends FormState {}

class FormSubmittingState extends FormState {}

class FormSubmittedState extends FormState {}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormInitialState()) {
    on<SubmitFormEvent>((event, emit) async {
      // Emit FormSubmittingState to show loading state
      emit(FormSubmittingState());

      // Simulate form submission
      await Future.delayed(const Duration(seconds: 2));

      // Emit FormSubmittedState after submission
      emit(FormSubmittedState());
    });
  }
}