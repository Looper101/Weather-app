part of 'song_search_bloc.dart';

@immutable
abstract class SongSearchState {}

class SongSearchInitial extends SongSearchState {}

class SongLoading extends SongSearchState {}

class SongLyricsLoaded extends SongSearchState {
  final List<Song> songs;
  SongLyricsLoaded({
    this.songs,
  });
}

class SongSearchError extends SongSearchState {}
