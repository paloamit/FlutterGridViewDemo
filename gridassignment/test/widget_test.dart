import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gridassignment/main.dart';
import 'package:gridassignment/models/newsModel.dart';
import 'package:gridassignment/networkManagers/newsNetworkManager.dart';
import 'package:gridassignment/views/image_detail_view.dart';
import 'package:gridassignment/views/image_galary_view.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  testWidgets('Load Image Gallery Screen with title (Image List Screen)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Image List Screen'), findsOneWidget);
  });

  testWidgets('Load Image Gallery Screen with title (Image Screen)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Image Screen'), findsNothing);
  });

  test('returns news data when http response is successful', () async {
    final mockHTTPClient = MockClient((request) async {
      final response = {
        "meta": {"found": 14557856, "returned": 3, "limit": 3, "page": 1},
        "data": [
          {
            "uuid": "5eda7f2e-54ec-49f4-979a-65af68aff031",
            "title":
                "(LEAD) Ex-DP chief wins sweeping victory in primary of party leadership on 1st day",
            "description":
                "(ATTN: CHANGES headline, lead; UPDATES with latest results in 3rd para) SEOUL, July 20 (...",
            "keywords": "",
            "snippet":
                "(ATTN: CHANGES headline, lead; UPDATES with latest results in 3rd para)\n\nSEOUL, July 20 (Yonhap) -- Rep. Lee Jae-myung, former leader of the main opposition Dem...",
            "url":
                "https://en.yna.co.kr/view/AEN20240720001751320?section=news&input=rss",
            "image_url":
                "https://img9.yna.co.kr/photo/yna/YH/2024/07/20/PYH2024072001350005600_P4.jpg",
            "language": "en",
            "published_at": "2024-07-20T18:54:45.000000Z",
            "source": "yna.co.kr",
            "categories": ["general"],
            "relevance_score": null
          }
        ]
      };
      return Response(jsonEncode(response), 200);
    });
    expect(await NewsNetworkManager.fetchNews(mockHTTPClient), isA<List<NewsModel>>());
  });   
}
