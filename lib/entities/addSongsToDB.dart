// import '../db/songDB.dart';
// import '../class/song.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';

void addSongsToDB() async {
  final manifestJson = await rootBundle.loadString('AssetManifest.json');
  final manifest = json.decode(manifestJson);

  final assetPaths =
      manifest.keys.where((String key) => key.startsWith('assets/sounds/'));

  for (final assetPath in assetPaths) {
    print('Genre is: ${assetPath.split('/')[2]}');
    print(assetPath);
    print('Song name is: ${assetPath.split('/')[3]}');
  }
}
