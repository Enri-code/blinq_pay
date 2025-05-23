import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({super.key, required this.url, required this.tag});

  final String url;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(url),
        heroAttributes: PhotoViewHeroAttributes(tag: tag),
      ),
    );
  }
}
