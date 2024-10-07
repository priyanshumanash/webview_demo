import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter WebView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewDemo(),
    );
  }
}

class WebViewDemo extends StatefulWidget {
  @override
  _WebViewDemoState createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            //Check if the URL uses 'http://' and replace it with 'https://'
            if (request.url.startsWith('http://')) {
              // Replace 'http://' with 'https://'
              final updatedUrl = request.url.replaceAll('http://', 'https://');
              // Load the updated URL in the WebView
              controller.loadRequest(Uri.parse(updatedUrl));
              // Prevent the WebView from loading the original URL
              return NavigationDecision.prevent;
            } else if (request.url.contains("https://checkout.webplat.in/pgresponse/")) {
              // Get.back(result: true);
              return NavigationDecision.prevent;
            }
            // Allow navigation for other URLs
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://Payg.in/ProcessPayment/payment/SeamlessPaymentProcess?ordekeyId=86571860240926M21764UPAYINORDER1214'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter WebView check'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
