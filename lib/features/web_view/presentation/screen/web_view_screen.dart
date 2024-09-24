import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/features/web_view/presentation/widget/webview_status.dart';
import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_const.dart';
import '../../../../core/resource/app_icon.dart';

class WebViewArgs {
  String url;

  WebViewArgs({required this.url});
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, this.args});

  final WebViewArgs? args;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  int pageStatus = 0;

  double marginHeight = 0;

  // 0 for loading , 1 for successfully loaded , 2 for error loading

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        alignment: Alignment.centerLeft,
        child: FloatingActionButton(
          backgroundColor: AppColor.purple,
          child: SvgPicture.asset(
            AppIcon.backTo,
            colorFilter:
                const ColorFilter.mode(AppColor.white, BlendMode.srcIn),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: marginHeight),
            child: InAppWebView(
              onLoadStop: (controller, url) {
                setState(() {
                  pageStatus = 1;
                  marginHeight = AppHeightSize.h3;
                });
              },
              onLoadStart: (controller, url) {
                setState(() {
                  pageStatus = 0;
                });
              },
              onReceivedError: (controller, request, error) {
                setState(() {
                  pageStatus = 2;
                });
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async =>
                  ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED),
              initialUrlRequest: URLRequest(
                  url: WebUri.uri(
                      Uri.parse(widget.args?.url ?? AppConst.webSiteUrl))),
            ),
          ),
          WebViewStatus(pageStatus: pageStatus),
        ],
      ),
    );
  }
}
