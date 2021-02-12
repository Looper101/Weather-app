part of 'song_search_bloc.dart';

@immutable
abstract class SongSearchEvent {}

class TextChanged extends SongSearchEvent {
  final String query;
  TextChanged({
    this.query,
  });
}
