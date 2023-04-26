part of 'save_to_clipboard_bloc.dart';

abstract class SaveToClipboardEvent extends Equatable {
  const SaveToClipboardEvent();

  @override
  List<Object> get props => [];
}

class SaveToClipboard extends SaveToClipboardEvent {
  final String text;
  const SaveToClipboard({required this.text});

  @override
  List<Object> get props => [text];
}
