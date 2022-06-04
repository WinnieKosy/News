import 'dart:convert';
import 'package:flutter_blognews/models/article_model.dart';
import 'package:http/http.dart';

class News{
  List<ArticleModel> news=[];
String url =  'https://newsapi.org/v2/top-headlines?country=ng&category=business&apiKey=f238bf25a19f4628a6257c582f5d8994';

Future<void>getNews ()async{
  Response response = await get(Uri.parse(url));
  Map data = jsonDecode(response.body);
  if(data['status'] == 'ok'){
    data['articles'].forEach((element){
    if (element['urlToImage']!= null && element['description']!= null){
      ArticleModel instance = ArticleModel(
        title: element['title'],
        author: element['author'],
        description: element['description'],
        url: element['url'],
        urlToImage: element['urlToImage'],
        content: element['contents'],
        publishedAt: DateTime.parse(element["publishedAt"]),

      );
      news.add(instance);
    }
    });
  }
}
}
class CategoryNewsClass{
  List<ArticleModel> news=[];
  Future<void>getNews (String category)async{

    String url =  'https://newsapi.org/v2/top-headlines?country=ng&category=$category&apiKey=f238bf25a19f4628a6257c582f5d8994';

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    if(data['status'] == 'ok'){
      data['articles'].forEach((element){
        if (element['urlToImage']!= null && element['description']!= null){
          ArticleModel instance = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['contents'],
            publishedAt: DateTime.parse(element["publishedAt"]),

          );
          news.add(instance);
        }
      });
    }
  }
}