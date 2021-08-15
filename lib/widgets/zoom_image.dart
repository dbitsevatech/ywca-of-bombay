import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ZoomImageAsset extends StatelessWidget {
  final String text;
  ZoomImageAsset(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(0.00),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: AssetImage(text),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}

class ZoomImageNetwork extends StatelessWidget {
  final String text;
  ZoomImageNetwork(this.text);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(0.00),
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(text),
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
