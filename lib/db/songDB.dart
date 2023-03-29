import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../class/song.dart';

// Schema
// 'title': string, song name
// 'srcUrl': string, path to song
// 'genre': string, genre of the song
// 'liked': bool, liked the song or not
// 'lengthInSec': int, length of the song in seconds

class SongDatabase {
  //Private Constructor
  SongDatabase._init();

  static Database? _database;

  static final SongDatabase instance = SongDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('songs.db');
    return _database!;
  }

  //filePath = 'song_database.db'
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // 'title': string, song name
// 'srcUrl': string, path to song
// 'genre': string, genre of the song
// 'liked': bool, liked the song or not
// 'lengthInSec': int, length of the song in seconds
  Future _createDB(Database db, int version) async {
    // Define type
    const String textType = 'TEXT NOT NULL';
    const String boolType = 'BOOLEAN NOT NULL';
    const String intType = 'INTEGER NOT NULL';

    // Create database table
    await db.execute('''
CREATE TABLE $tableSongs (
  ${SongFields.title} $textType,
  ${SongFields.srcUrl} $textType,
  ${SongFields.genre} $textType,
  ${SongFields.liked} $boolType,
  ${SongFields.lengthInSec} $intType,
  )
''');
  }

  Future<void> create(Song song) async {
    final db = await instance.database;

    await db.insert(tableSongs, song.toJson());
  }

  Future<List<Song>> readAllSong() async {
    final db = await instance.database;

    final result = await db.query(tableSongs);

    return result.map((json) => Song.fromJson(json)).toList();
  }

  Future<List<Song>> readLikedSong() async {
    final db = await instance.database;

    final result = await db
        .query(tableSongs, where: '${SongFields.liked} = ?', whereArgs: [1]);

    return result.map((json) => Song.fromJson(json)).toList();
  }

  Future<int> updateLike(Song song) async {
    final db = await instance.database;

    return db.update(tableSongs, song.toJson(),
        where: '${SongFields.title} = ?', whereArgs: [song.getSongTitle()]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
