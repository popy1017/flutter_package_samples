import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_sample/album_model.dart';
import 'package:provider/provider.dart';

class Album extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Asset> _photos =
        context.select((AlbumModel model) => model.photos);

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: _photos.length,
        itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(1),
              child: AssetThumb(
                key: Key(_photos[index].identifier),
                asset: _photos[index],
                width: _photos[index].originalWidth,
                height: _photos[index].originalHeight,
              ),
            ));
  }
}
