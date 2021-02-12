import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:songlyrics/models/song.dart';

part 'song_search_event.dart';
part 'song_search_state.dart';

class SongSearchBloc extends Bloc<SongSearchEvent, SongSearchState> {
  SongSearchBloc() : super(SongSearchInitial());

  @override
  Stream<SongSearchState> mapEventToState(
    SongSearchEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
