part of 'save_to_clipboard_bloc.dart';

abstract class SaveToClipboardState extends Equatable {
  const SaveToClipboardState();

  @override
  List<Object> get props => [];
}

class SaveToClipboardInitial extends SaveToClipboardState {}

class SaveSuccess extends SaveToClipboardState {}

class SaveFailure extends SaveToClipboardState {}
