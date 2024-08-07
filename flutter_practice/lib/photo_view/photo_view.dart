import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class PhotoViewPage extends StatefulWidget {
  List<String> imagePaths;
  int currentIndex;

  PhotoViewPage({
    super.key,
    required this.imagePaths,
    required this.currentIndex,
  });

  @override
  State<PhotoViewPage> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoViewPage> {
  int currentPageIndex = 0;
  late PageController _controller;
  bool _isDownloading = false;

  @override
  void initState() {
    currentPageIndex = widget.currentIndex;
    _controller = PageController(initialPage: widget.currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void downloadImage(String imageUrl) async {
    setState(() {
      _isDownloading = true;
    });

    var response = await Dio()
        .get(imageUrl, options: Options(responseType: ResponseType.bytes));

    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

    if (result['isSuccess']) {
      print('다운로드가 완료되었습니다.');
    } else {
      print('다운로드의 오류가 발생했습니다.');
    }

    setState(() {
      _isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              pageController: _controller,
              itemCount: widget.imagePaths.length,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  maxScale: PhotoViewComputedScale.covered * 3,
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: NetworkImage(widget.imagePaths[index]),
                );
              },
              loadingBuilder: (context, event) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 25, top: 25),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Text(
                  '${currentPageIndex + 1} / ${widget.imagePaths.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 25, right: 25),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.download,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (!_isDownloading) {
                      downloadImage(widget.imagePaths[currentPageIndex]);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
