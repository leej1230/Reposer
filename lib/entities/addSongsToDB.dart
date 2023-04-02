// import '../db/songDB.dart';
// import '../class/song.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:reposer/class/song.dart';
import 'package:reposer/db/songDB.dart';

void addSongsToDB() async {
  final manifestJson = await rootBundle.loadString('AssetManifest.json');
  final manifest = json.decode(manifestJson);

  final assetPaths =
      manifest.keys.where((String key) => key.startsWith('assets/sounds/'));

  for (final assetPath in assetPaths) {
    // print('Genre is: ${assetPath.split('/')[2]}');
    // print(assetPath);
    // print('Song name is: ${assetPath.split('/')[3]}');

    var songInstance = Song(
      title: assetPath.split('/')[3],
      genre: assetPath.split('/')[2],
      liked: false,
      srcUrl: assetPath,
    );

    SongDatabase.instance.create(songInstance);
    // SongDatabase.instance.create(test);
  }
  print('Everything is up to date!');
  //
  // final l = await SongDatabase.instance.readAllSong();
  // for (final s in l) {
  //   print(s.toString());
  // }
}
