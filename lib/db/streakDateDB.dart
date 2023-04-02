import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:reposer/entities/compareDay.dart';

// Schema
// 'date': string, stores date

const String tableDate = 'date';

class DateFields {
  static const String id = 'id';
  static const String date = 'date';
  static const String streak = 'streak';
}

class Date {
  int? id;
  late String _date;
  late int _streak;

  Date({
    this.id,
    required date,
    streak,
  }) {
    this._date = date;
    this._streak = streak ?? 1;
  }

  Map<String, Object?> toJson() {
    return {
      DateFields.id: id,
      DateFields.date: _date,
      DateFields.streak: _streak,
    };
  }

  static Date fromJson(Map<String, Object?> json) {
    return Date(
      id: json[DateFields.id] as int,
      date: json[DateFields.date] as String,
      streak: json[DateFields.streak] as int,
    );
  }

  // Implement toString to make it easier to see information about
  // each song when using the print statement.
  @override
  String toString() {
    return 'Date{id: $id, date: $_date, streak: $_streak}';
  }

  // int calculateStreak(DateTime date) {
  //   this
  // }

  //Setters

  void setDate({required DateTime date}) {
    this._date = DateUtils.dateOnly(date).toString();
  }

  //Getters

  DateTime getDate() {
    return DateTime.parse(_date);
  }

  int getStreak() {
    return _streak;
  }
}

class DateDatabase {
  //Private Constructor
  DateDatabase._init();

  static Database? _database;

  static final DateDatabase instance = DateDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('date.db');
    return _database!;
  }

  //filePath = 'song_database.db'
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Define type
    const String idType = 'INTEGER PRIMARY KEY';
    const String textType = 'TEXT NOT NULL';
    const String intType = 'INTEGER NOT NULL';

    // Create database table
    await db.execute('''
CREATE TABLE $tableDate (
  ${DateFields.id} $idType,
  ${DateFields.date} $textType,
  ${DateFields.streak} $intType
  )
''');
  }

  Future<int> insertDate(Date date) async {
    final db = await instance.database;

    return await db.insert(tableDate, date.toJson());
  }

  Future<int> updateDate(Date date) async {
    final db = await instance.database;

    return await db.update(
      tableDate,
      date.toJson(),
      where: '${DateFields.id} = ?',
      whereArgs: [date.id],
    );
  }

  Future<Date?> getCurrentDate() async {
    final db = await instance.database;
    final dateJson = await db.query(
      tableDate,
      orderBy: '${DateFields.date} DESC',
      limit: 1,
    );

    if (dateJson.isEmpty) {
      return null;
    } else {
      return Date.fromJson(dateJson.first);
    }
  }

  // Future<void> create(Date date) async {
  //   final db = await instance.database;
  //
  //   var queryResult = await db.query(
  //     tableDate,
  //     where: '${DateFields.date} = ?',
  //     whereArgs: [date.getDate()],
  //   );
  //
  //   // If there is already an song inserted, no need to add new one
  //   if (queryResult.isNotEmpty) {
  //     // print('there was song!');
  //     return;
  //   }
  //   // print('there was no song!');
  //   await db.insert(tableDate, date.toJson());
  //   // print('Song was added :)');
  // }
  //
  // Future<List<Date>> readDate() async {
  //   final db = await instance.database;
  //
  //   final result = await db.query(tableDate);
  //
  //   final r = result.map((json) => Date.fromJson(json)).toList();
  //   print(r);
  //   return r;
  //   // return result.map((json) => Date.fromJson(json)).toList();
  // }

  //Checks if the session was the first time in a day or not
  // Future<bool> isFirstTime() async {
  //   final fromDB = await readDate();
  //
  //   //If there is no record in database
  //   if (fromDB == []) {
  //     return true;
  //   }
  //
  //   if (differenceBetweenToday(fromDB[0].getDate()) < 1) {
  //     return false;
  //   }
  //
  //   return true;
  // }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
