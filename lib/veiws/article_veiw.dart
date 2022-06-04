import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleVeiw extends StatefulWidget {
  final  blogUrl;
  ArticleVeiw({this.blogUrl});
  @override
  _ArticleVeiwState createState() => _ArticleVeiwState();
}

class _ArticleVeiwState extends State<ArticleVeiw> {
final Completer<WebViewController>_completer=Completer<WebViewController>();
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
    body:Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: WebView(
        initialUrl: widget.blogUrl,
        onWebViewCreated: ((WebViewController webViewController){
          _completer.complete(webViewController);
        }),
      ),

    ));
  }
}

