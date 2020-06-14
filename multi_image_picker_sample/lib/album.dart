import 'dart:math';

import 'package:flutter/material.dart';

class Album extends StatelessWidget {
  final List<Widget> _photos = getPhotos(20);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: _photos.length,
        itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(1),
              child: _photos[index],
            ));
  }
}

final List<String> _photoList = <String>[
  'https://cdn.pixabay.com/photo/2015/03/26/09/47/sky-690293__340.jpg',
  'https://cdn.pixabay.com/photo/2015/09/09/16/05/forest-931706__340.jpg',
  'https://cdn.pixabay.com/photo/2016/03/09/09/22/workplace-1245776__340.jpg',
  'https://cdn.pixabay.com/photo/2016/02/19/11/19/office-1209640__340.jpg',
  'https://cdn.pixabay.com/photo/2014/12/15/17/16/pier-569314__340.jpg'
];

List<Widget> getPhotos(int count) {
  final Random _rnd = Random();
  return List<Widget>.generate(count, (int index) {
    final int _id = _rnd.nextInt(_photoList.length - 1);
    return Image.network(
      _photoList[_id],
      fit: BoxFit.cover,
    );
  });
}
