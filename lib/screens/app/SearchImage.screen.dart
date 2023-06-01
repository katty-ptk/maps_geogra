import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchImagePage extends StatefulWidget {
  const SearchImagePage({super.key});

  @override
  State<SearchImagePage> createState() => _SearchImagePageState();
}

class _SearchImagePageState extends State<SearchImagePage> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
            print("opened page: $url");
          },

          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },

          onPageFinished: ((url) {
            setState(() {
              loadingPercentage = 100;
            });
          })
        )
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse('https://images.google.com'),
        // asia beautiful places
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller
        ),

        if ( loadingPercentage < 100 ) 
          LinearProgressIndicator(
            value: loadingPercentage / 100,
          ),

        Positioned(
          bottom: 10,
          left: 10,
          child: ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                )
              )
            ),
            child: Row(
              children: const [
                Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16,),
                Text(" back")
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: (){},
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                )
              )
            ),
            child: const Icon(Icons.copy, color: Colors.white,),
          ),
        ),
      ]
    );
  }
}