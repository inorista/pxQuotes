// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pxquote/models/quote_model.dart';
import 'package:pxquote/utils/method_utils.dart';
import 'package:screenshot/screenshot.dart';

part 'share_scan_result_event.dart';
part 'share_scan_result_state.dart';

class ShareScanResultBloc extends Bloc<ShareScanResultEvent, ShareScanResultState> {
  QuoteModel currentModel = QuoteModel();
  final channel = const MethodChannel('pxQuotes/share');
  final controller = ScreenshotController();
  ShareScanResultBloc() : super(ShareScanResultInitial()) {
    on<ShareScanResultEvent>((event, emit) {});

    on<ShareScanResult>((event, emit) async {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/${event.fileName}').create(recursive: true);
      await controller.capture().then((value) {
        if (value != null) {
          file.writeAsBytesSync(value);
        }
      });

      final color1 =
          "#${(MethodUtils().darken(currentModel.color1!, amount: 0.05).toString().split('(0x')[1].split(')')[0]).toLowerCase()}";
      final color2 =
          "#${(MethodUtils().darken(currentModel.color2!, amount: 0.05).toString().split('(0x')[1].split(')')[0]).toLowerCase()}";

      final Map<String, dynamic> data = {
        "imagePath": event.fileName,
        "topColor": color1.replaceAll("#ff", "#"),
        "bottomColor": color2.replaceAll("#ff", "#"),
      };
      log(data.toString());
      channel.invokeMethod('shareFile', data);
    });

    on<ChangeIndex>((event, emit) async {
      currentModel = event.model;
    });
  }
}
