import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../views/news_article_page.dart';
import 'news_model.dart';
import 'package:http/http.dart' as http;


// Change the apiKey to get more Api calls since its been in use .
const String apiKey = "2c3e1343e7234f6b99576d22605f5be2";

class NewsNotifier extends ChangeNotifier {
  final Box box;
  List<Article> news = [];
  
  NewsNotifier({this.box});

  void addNewsFromJson(json) {
    news = [];
    if (json['status'] == "ok") {
      json["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }

  Future<void> getNews() async {
    if (box.isOpen && box.isNotEmpty) {
      final cachedData = box.get("news");
      addNewsFromJson(cachedData);
      notifyListeners();
    }
    final url =
        "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey";
    try {
      final response = await http.get(url);
      final jsonData = jsonDecode(response.body);
      box.put("news", jsonData);
      addNewsFromJson(jsonData);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl;

  NewsTile(
      {this.imgUrl,
      this.desc,
      this.title,
      this.content,
      @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                      postUrl: posturl,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
