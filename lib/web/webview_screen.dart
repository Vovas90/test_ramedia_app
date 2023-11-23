import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({super.key});

  final CookieManager cookieManager = CookieManager();
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Web View'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _goBack,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _goForward,
            ),
          ],
        ),
        body: WebView(
          initialUrl: 'https://www.youtube.com',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _controller = webViewController;
            // var cookies = await loadCookies(_controller);
            // setCookies(_controller);
          },
          onPageFinished: (String url) async {
            // final cookies = await _controller
            //     .runJavascriptReturningResult('document.cookie');
            // final gotCookies = getCookies(cookies);
            // saveCookies(gotCookies);
          },
        ),
      ),
    );
  }

  List<Cookie> getCookies(String? cookies) {
    return parseCookies(cookies ?? "");
  }

  List<Cookie> parseCookies(String cookieString) {
    var cookies = <Cookie>[];
    if (cookieString.isNotEmpty) {
      var pairs = cookieString.split(';');
      for (var pair in pairs) {
        var split = pair.split('=');
        if (split.length == 2) {
          var key = split[0].trim();
          var value = split[1].trim();
          cookies.add(Cookie(key, value));
        }
      }
    }
    return cookies;
  }

  void setCookies(WebViewController controller) async {
    await cookieManager.setCookie(const WebViewCookie(
      name: 'cookie_name',
      value: 'cookie_value',
      domain: 'https://example.com',
    ));
  }

  Future<void> loadCookies(WebViewController controller) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (var key in keys) {
      if (key.startsWith('cookie_')) {
        final value = prefs.getString(key);
        final name = key.substring('cookie_'.length);
        controller.runJavascript(
            "document.cookie = '$name=$value; path=/; expires=Fri, 31 Dec 9999 23:59:59 GMT;'");
      }
    }
  }

  Future<void> saveCookies(List<Cookie> cookies) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var cookie in cookies) {
      await prefs.setString('cookie_${cookie.name}', cookie.value);
    }
  }

  Future<bool> _onWillPop() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _goBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
    }
  }

  void _goForward() async {
    if (await _controller.canGoForward()) {
      _controller.goForward();
    }
  }
}
