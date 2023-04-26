part of 'card_quotes_bloc.dart';

abstract class CardQuotesEvent extends Equatable {
  const CardQuotesEvent();

  @override
  List<Object> get props => [];
}

class GetListQuotes extends CardQuotesEvent {
  final String tag;
  const GetListQuotes({this.tag = ""});

  @override
  List<Object> get props => [tag];
}
