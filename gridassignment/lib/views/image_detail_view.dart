import 'package:flutter/material.dart';
import 'package:gridassignment/models/newsModel.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageDetailView extends StatefulWidget {
  ImageDetailView({super.key, this.title, this.news});
  String? title;
  NewsModel? news;

  @override
  State<ImageDetailView> createState() => _ImageDetailViewState();
}

class _ImageDetailViewState extends State<ImageDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title!),
      ),
      body: PinchZoomReleaseUnzoomWidget(
        child: CachedNetworkImage(
                            imageUrl: widget.news!.imageURL,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            cacheManager: CacheManager(Config("imagecache",
                              stalePeriod: const Duration(days: 1),
                            )),
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                          ),
      ),
    );
  }
}
