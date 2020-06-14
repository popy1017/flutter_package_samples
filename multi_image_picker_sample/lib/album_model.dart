import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_sample/db_helper.dart';

class AlbumModel extends ChangeNotifier {
  AlbumModel() {
    loadAssetsFromDB();
  }

  final DBHelper _dbHelper = DBHelper();
  List<Asset> _photos = <Asset>[];

  List<Asset> get photos => _photos;

  Future<void> loadAssetsFromDB() async {
    _photos = await _dbHelper.assets();
    notifyListeners();
  }

  Future<void> loadAssets() async {
    List<Asset> _resultList;

    try {
      _resultList = await MultiImagePicker.pickImages(
        maxImages: 50,
        enableCamera: true,
        cupertinoOptions: const CupertinoOptions(
          selectionFillColor: '#ff11ab',
          selectionTextColor: '#ffffff',
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: '#abcdef',
          actionBarTitle: 'Example App',
          allViewTitle: 'All Photos',
          useDetailsView: true,
          selectCircleStrokeColor: '#000000',
        ),
      );
    } on NoImagesSelectedException catch (e) {
      print(e);
      return;
    } on Exception catch (e) {
      print(e);
    }

    for (final Asset asset in _resultList) {
      await _dbHelper.insertAsset(asset);
    }

    loadAssetsFromDB();
  }
}
