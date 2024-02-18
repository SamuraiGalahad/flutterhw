import 'package:shared_preferences/shared_preferences.dart';
import './model/news_model.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:async';


class WebModule {
  final dio = Dio();

  int pageCount = 1;

  static SharedPreferences? prefs;

  Future<void> getNews() async {
    prefs = await SharedPreferences.getInstance();
    try {
      List<News> newsSF = <News>[];
      Response<String> response = await dio.get(
          'https://newsapi.org/v2/everything?q=Hacker&sortBy=publishedAt&page=$pageCount&apiKey=ecab7f53e60f4a9298e0ac68597540f9');

      String responseBodyRaw = response.data.toString();

      final body = json.decode(responseBodyRaw);

      if (body["status"] == "ok") {
        print(body["totalResults"]);
      }

      List<dynamic> newsRaw = body["articles"];

      String id,
          name,
          author,
          title,
          description,
          url,
          urlToImage,
          publishedAt,
          content;

      for (int i = 0; i < newsRaw.length; i++) {
        try {
          id = newsRaw[i]["source"]["id"];
        } catch (error) {
          id = "";
        }

        try {
          name = newsRaw[i]["source"]["name"];
        } catch (error) {
          name = "";
        }

        try {
          author = newsRaw[i]["author"];
        } catch (error) {
          author = "";
        }

        try {
          title = newsRaw[i]["title"];
        } catch (error) {
          title = "";
        }

        try {
          description = newsRaw[i]["description"];
        } catch (error) {
          description = "";
        }

        try {
          url = newsRaw[i]["url"];
        } catch (error) {
          url = "";
        }

        try {
          urlToImage = newsRaw[i]["urlToImage"];
        } catch (error) {
          urlToImage = "";
        }

        try {
          publishedAt = newsRaw[i]["publishedAt"];
        } catch (error) {
          publishedAt = "";
        }

        try {
          content = newsRaw[i]["content"];
        } catch (error) {
          content = "";
        }

        newsSF.add(News(
            id: id,
            name: name,
            author: author,
            publishedAt: publishedAt,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            content: content));

      }

      pageCount++;

      //List<News> prev =  await readNewsFromPrefs() as List<News>;
      //prev.addAll(newsSF);

      List<Map<String, dynamic>> newsData = newsSF.map((news) => news.toJson()).toList();

      String newsJson = jsonEncode(newsData);

      print(newsJson);

      await prefs!.remove("newsData");

      await prefs!.setString('newsData', newsJson);

      //print(body);
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  Future<List<News>> readNewsFromPrefs() async {
    prefs = await SharedPreferences.getInstance();
    try {
      String? newsJson = prefs?.getString('newsData');
      if (newsJson != null) {
        List<dynamic> newsData = jsonDecode(newsJson);
        List<News> newsList = newsData.map((data) => News.fromJson(data)).toList();
        return newsList;
      }
    } catch (error) {
      print('Error getting news from SharedPreferences: $error');
      return [];
    }
    return [];
  }


}
