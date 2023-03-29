/*
* What is this class for?
* Create instance for each songs that contains information including:
*     title of the song
*     asset url to the song
*     whether the song got liked by the user
*     genre of the song
*     Length of the song (?)
*
* What member function should this class have
*     Constructor
*       Creates the instance
*     Getters for each information
*     Setters to change if the song is liked or not
*/

import 'dart:ffi';

const String tableSongs = 'songs';

class SongFields {
  static const String title = 'title';
  static const String srcUrl = 'srcUrl';
  static const String genre = 'genre';
  static const String liked = 'liked';
  static const String lengthInSec = 'lengthInSec';
}

class Song {
  late String _title;
  late String _srcUrl;
  late String _genre;
  late bool _liked;
  late int _lengthInSec;

  Song({
    required title,
    required srcUrl,
    required genre,
    required liked,
    required lengthInSec,
  }) {
    this._title = title;
    this._srcUrl = srcUrl;
    this._genre = genre;
    this._liked = liked;
    this._lengthInSec = lengthInSec;
  }

  // Save song information to DB
  Map<String, Object?> toJson() {
    return {
      SongFields.title: _title,
      SongFields.srcUrl: _srcUrl,
      SongFields.genre: _genre,
      SongFields.liked: _liked ? 1 : 0,
      SongFields.lengthInSec: _lengthInSec,
    };
  }

  static Song fromJson(Map<String, Object?> json) {
    return Song(
      title: json[SongFields.title] as String,
      srcUrl: json[SongFields.srcUrl] as String,
      genre: json[SongFields.genre] as String,
      liked: json[SongFields.liked] == 1,
      lengthInSec: json[SongFields.lengthInSec] as Int,
    );
    // SongFields.title: _title,
    // SongFields.srcUrl: _srcUrl,
    // SongFields.genre: _genre,
    // SongFields.liked: _liked ? 1 : 0,
    // SongFields.lengthInSec: _lengthInSec,
  }

  // Implement toString to make it easier to see information about
  // each song when using the print statement.
  @override
  String toString() {
    return 'Song{title: $_title, srcUrl: $_srcUrl, genre: $_genre, liked: $_liked, lengthInSec: $_lengthInSec}';
  }

  //Setters

  void setIsLiked({required like}) {
    this._liked = like;
  }

  //Getters

  bool getIsLiked() {
    return _liked;
  }

  String getSongTitle() {
    return _title;
  }

  String getSongGenre() {
    return _genre;
  }

  String getSongUrl() {
    return _srcUrl;
  }

  int getSongLengthInSec() {
    return _lengthInSec;
  }
}
