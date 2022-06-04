import 'package:flutter/material.dart';
import 'package:flutter_blognews/data/news.dart';

import '../models/article_model.dart';
import 'article_veiw.dart';
import 'home.dart';
class CategoryNews extends StatefulWidget {
final  category;
CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}


class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  void getCategoryNews() async{
    CategoryNewsClass instance= CategoryNewsClass();
    await instance.getNews(widget.category);
    articles = instance.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar( backgroundColor: Colors.grey[200],
        title:Row(mainAxisAlignment: MainAxisAlignment.center,
        children: const [
        Text(
        'GET',
        style: TextStyle(
        color: Colors.black
    )
    ),
    Text('News',
    style: TextStyle(
    color:  Colors.blue
    ),),
    SizedBox(width: 60,)
    ],),elevation: 0.0,
    ),
    body: _loading?  Center(
      child: Container(
        child: const CircularProgressIndicator(),
      ),
    ) :SingleChildScrollView(
      child: Container(padding:const EdgeInsets.symmetric(horizontal: 16,),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                itemCount:articles.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index){
                  return BlogTile(
                    imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    description: articles[index].description,
                    url: articles[index].url,
                  );
                },
              ),
            )
          ],
        ),
      ),
    )
    );}
}
class BlogTile extends StatelessWidget {
  final String? imageUrl, title, description, url  ;
  BlogTile({@required this.imageUrl, @required this.title,@required this.description,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context,MaterialPageRoute(
          builder: (context) => ArticleVeiw(
              blogUrl: url
          )

      ));},
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl.toString())),
            Text(title.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),),
           const  SizedBox(height: 8,),
            Text(description.toString(),
              style:const TextStyle(
                color: Colors.black54,
              ),)
          ],
        ),
      ),
    );
  }
}
