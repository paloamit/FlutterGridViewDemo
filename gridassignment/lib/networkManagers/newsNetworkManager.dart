import 'package:http/http.dart' as http;
import '../../Constants.dart';
import '../../models/newsModel.dart';
import 'dart:async';
import 'dart:convert';

class NewsNetworkManager {
  static Future<List<NewsModel>> fetchNews(http.Client http) async {
    final response = await http.get(Uri.parse(APIConstants.getAllNewsURL)).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      final List newsList = body['data'] as List;
      List<NewsModel> news =
          newsList.map((e) => NewsModel.fromJson(e)).toList();
      print('Received News List ${news}');
      return news;
    } else {
      throw Exception('Unable to fetch news data');
    }
  }
}
