import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blognews/data/news.dart';
import 'package:flutter_blognews/models/article_model.dart';
import 'package:flutter_blognews/models/category_models.dart';
import 'package:flutter_blognews/data/data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_blognews/veiws/article_veiw.dart';

import 'category_news.dart';


  class Home extends StatefulWidget {
    const Home({Key? key}) : super(key: key);
  
    @override
    _HomeState createState() => _HomeState();
  }
  
  class _HomeState extends State<Home> {
    List<CategoryModel>? categories = [];
    List<ArticleModel> articles = [];
    bool _loading = true;

    void setup() async{
 News instance= News();
      await instance.getNews();
      articles = instance.news;
      setState(() {
        _loading = false;
      });
    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  categories = getCategories();
  setup();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar:AppBar( backgroundColor: Colors.white,
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
          ),)
        ],),elevation: 0.0,
      ),
      body: _loading?  Center(
        child: Container(
          child: const CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(padding:const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // categories
                Container(
                  height: 60,
                  child: ListView.builder(
                    itemCount: categories?.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                      return CategoryTile(
                        imageUrl: categories?[index].imageUrl,
                        categoryName: categories?[index].categoryName,
                      );
                      })
                ),
                //blogs
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  itemCount:articles.length,
                  shrinkWrap: true,
                  physics:const ClampingScrollPhysics(),
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
            ) ,
        ),
      ),);
    }
  }
class CategoryTile extends StatelessWidget {

 final String? imageUrl, categoryName;
 CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CategoryNews(
          category: categoryName
        ) ));
      },
      child: Container(margin:const EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:imageUrl.toString(), width: 120, height: 60, fit: BoxFit.cover,)),
            Container(alignment: Alignment.center,
            width: 120, height: 60,
              decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6) ,
                color: Colors.black26
              ),
              child: Text(categoryName.toString(), style:const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
            )

          ],
        ),
      ),
    );
  }
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
        margin:const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl.toString())),
            Text(title.toString(),
            style:const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),),
           const SizedBox(height: 8,),
            Text(description.toString(),
            style: const TextStyle(
              color: Colors.black54,
            ),)
          ],
        ),
      ),
    );
  }
}


  
