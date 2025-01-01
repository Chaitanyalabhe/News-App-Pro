import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormEvent {}

class SubmitFormEvent extends FormEvent {
  final Map<String, String> formData;

  SubmitFormEvent(this.formData);
}

abstract class FormState {}

class FormInitialState extends FormState {}

class FormSubmittingState extends FormState {}

class FormSubmittedState extends FormState {}

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormInitialState()) {
    on<SubmitFormEvent>((event, emit) async {

      emit(FormSubmittingState());


      await Future.delayed(const Duration(seconds: 2));


      emit(FormSubmittedState());
    });
  }
}