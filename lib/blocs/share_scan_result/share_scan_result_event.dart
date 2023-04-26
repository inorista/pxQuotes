part of 'share_scan_result_bloc.dart';

abstract class ShareScanResultEvent extends Equatable {
  const ShareScanResultEvent();

  @override
  List<Object> get props => [];
}

class ShareScanResult extends ShareScanResultEvent {
  final String fileName;
  const ShareScanResult({required this.fileName});

  @override
  List<Object> get props => [fileName];
}

class ChangeIndex extends ShareScanResultEvent {
  final QuoteModel model;
  const ChangeIndex({required this.model});
  @override
  List<Object> get props => [model];
}
