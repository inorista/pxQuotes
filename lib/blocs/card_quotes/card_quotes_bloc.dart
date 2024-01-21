import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pxquote/models/quote_model.dart';
import 'package:pxquote/resources/quotes_api.dart';

part 'card_quotes_event.dart';
part 'card_quotes_state.dart';

class CardQuotesBloc extends Bloc<CardQuotesEvent, CardQuotesState> {
  QuotesApi quotesApi = QuotesApi();
  CardQuotesBloc() : super(CardQuotesLoading()) {
    on<CardQuotesEvent>((event, emit) {});

    on<GetListQuotes>((event, emit) async {
      try {
        final result = await QuotesApi().getRandomQuote(limit: 200);
        log(result.toList().toString());
        final currentState = state;
        if (currentState is CardQuotesLoaded) {
          emit(CardQuotesLoaded(quotes: List.from(currentState.quotes)..addAll(result)));
        } else {
          emit(CardQuotesLoaded(quotes: result));
        }
      } catch (e) {
        emit(CardQuotesError());
      }
    });
  }
}
