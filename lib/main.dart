import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatelessWidget {
  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView Flutter Example"),
      ),
      body: Center(
          child: Column(
        children: [
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Open pub.dev",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(
                  context, "https://pub.dev", "pub.dev");
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: Text(
              "Open Medium.com",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(
                  context, "https://medium.com", "Medium.com");
            },
          ),
        ],
      )),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  WebViewPageState createState() =>
      WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
                  initialUrl: this.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  debuggingEnabled: true,
              )
          )
        ])
    );
  }
}
