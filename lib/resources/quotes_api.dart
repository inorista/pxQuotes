import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pxquotes/constants/gradient_color.dart';
import 'package:pxquotes/models/exception_model.dart';
import 'package:pxquotes/models/quote_model.dart';

class QuotesApi {
  final Dio dio = Dio();
  final random = Random();
  Future<List<QuoteModel>> getRandomQuote({String? tag, int? limit}) async {
    final Response response = await dio.get(
      "https://api.quotable.io/quotes/random",
      queryParameters: {
        "tags": tag,
        "limit": limit ?? 5,
        "maxLength": 200,
      },
    );
    if (response.statusCode == 200) {
      final temp = (response.data as List).map((e) => QuoteModel.fromJson(e)).toList();
      for (int i = 0; i < temp.length; i++) {
        temp[i].color1 = listColor[random.nextInt(listColor.length)];
        temp[i].color2 = listColor[random.nextInt(listColor.length)];
      }
      return temp;
    } else {
      throw ExceptionModel(response.statusMessage ?? "Lỗi xác thực");
    }
  }
}
