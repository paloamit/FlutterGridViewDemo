import 'package:flutter/material.dart';
import 'package:gridassignment/models/newsModel.dart';
import 'package:gridassignment/networkManagers/newsNetworkManager.dart';
import 'image_detail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

class ImageGalleryView extends StatefulWidget {
  const ImageGalleryView({super.key, required this.title});
  final String title;

  @override
  State<ImageGalleryView> createState() => _ImageGalleryViewState();
}

class _ImageGalleryViewState extends State<ImageGalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<NewsModel>>(
          future: NewsNetworkManager.fetchNews(http.Client()),
          builder:
              (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text(
                'Unable to fetch data.\nPlease try again later !!!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0),
              ));
            } else {
              return Scaffold(
                body: GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          _navigateToImageDetailScreen(
                              context, snapshot.data![index]);
                        },
                        child: Card(
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data![index].imageURL,
                            placeholder: (context, url) =>
                                const SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator()
                                    ), 
                                  width: 40.0, 
                                  height: 40.0,),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            cacheManager: CacheManager(Config("imagecache",
                              stalePeriod: const Duration(days: 1),
                            )),
                          ),
                        ));
                  },
                ),
              );
            }
          },
        ));
  }

  void _navigateToImageDetailScreen(BuildContext context, NewsModel news) {
    NewsModel newNewsModel = NewsModel(
        uuid: news.uuid,
        title: news.title,
        description: news.description,
        imageURL: news.imageURL);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ImageDetailView(
              title: "Detail Image Screen",
              news: newNewsModel,
            )));
  }
}
