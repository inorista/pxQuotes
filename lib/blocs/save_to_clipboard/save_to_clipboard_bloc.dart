import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'save_to_clipboard_event.dart';
part 'save_to_clipboard_state.dart';

class SaveToClipboardBloc extends Bloc<SaveToClipboardEvent, SaveToClipboardState> {
  SaveToClipboardBloc() : super(SaveToClipboardInitial()) {
    on<SaveToClipboardEvent>((event, emit) {});

    on<SaveToClipboard>((event, emit) async {
      try {
        await Clipboard.setData(ClipboardData(text: event.text));
        emit(SaveSuccess());
      } catch (e) {
        emit(SaveFailure());
      }
      emit(SaveToClipboardInitial());
    });
  }
}
