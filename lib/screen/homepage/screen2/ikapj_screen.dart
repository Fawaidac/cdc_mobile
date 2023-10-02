import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IkapjScreen extends StatelessWidget {
  const IkapjScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://alumni.polije.ac.id/"));
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          // the most important part of this example
          child: WebViewWidget(
            controller: _controller,
          )),
    );
  }
}
