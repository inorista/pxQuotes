part of 'card_quotes_bloc.dart';

abstract class CardQuotesState extends Equatable {
  const CardQuotesState();

  @override
  List<Object> get props => [];
}

class CardQuotesLoading extends CardQuotesState {}

class CardQuotesLoaded extends CardQuotesState {
  final List<QuoteModel> quotes;
  const CardQuotesLoaded({this.quotes = const <QuoteModel>[]});
  @override
  List<Object> get props => [quotes];
}

class CardQuotesError extends CardQuotesState {}
