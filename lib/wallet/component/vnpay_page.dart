import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayPage extends StatefulWidget {
  final String urlVNPay;
  const VnPayPage({Key? key, required this.urlVNPay}) : super(key: key);

  @override
  State<VnPayPage> createState() => _VnPayPageState();
}

class _VnPayPageState extends State<VnPayPage> {
  final String successURL = "https://parkzserver-001-site1.btempurl.com/api/VNPayDeposit";

  @override
  Widget build(BuildContext context) {

    final WebViewController webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          debugPrint('url change 2: ${url}');
          if (url.contains(successURL)) {
            debugPrint('url change: ${url}');
            Navigator.pop(context, true);
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.urlVNPay));

    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: webViewController),
      ),
    );
  }
}
