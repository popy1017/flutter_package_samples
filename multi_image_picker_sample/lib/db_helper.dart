import 'dart:async';
import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

extension on Asset {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identifier': identifier,
      'name': name,
      'originalWidth': originalWidth,
      'originalHeight': originalHeight
    };
  }
}

class DBHelper {
  static const String tableName = 'MultiImagePickerSample';
  Database _db;

  Future<Database> get database async {
    if (_db == null) {
      final Directory documentDirectory =
          await getApplicationDocumentsDirectory();
      final String path = join(documentDirectory.path, 'multi_photo_sample.db');

      _db = await openDatabase(path, version: 2,
          onCreate: (Database newDb, int version) {
        newDb.execute('''
          CREATE TABLE $tableName
            (
              identifier TEXT PRIMARY KEY,
              name TEXT,
              originalWidth INTEGER,
              originalHeight INTEGER
            )
        ''');
      });
    }
    return _db;
  }

  Future<void> insertAsset(Asset asset) async {
    final Database db = await database;
    await db.insert(
      tableName,
      asset.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Asset>> assets() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List<Asset>.generate(maps.length, (int i) {
      final String identifier = maps[i]['identifier'] as String;
      final String name = maps[i]['name'] as String;
      final int originalWidth = maps[i]['originalWidth'] as int;
      final int originalHeight = maps[i]['originalHeight'] as int;

      return Asset(identifier, name, originalWidth, originalHeight);
    });
  }

  Future<void> close() async => _db.close();
}
