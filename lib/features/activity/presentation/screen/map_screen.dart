import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import '../../../../core/helper/lanucher_helper.dart';

class MapArgs {
  String subActivityName;
  String subActivityAddress;
  String subActivityImage;
  double lat, lon;

  MapArgs(
      {required this.subActivityName,
      required this.subActivityAddress,
      required this.subActivityImage,
      required this.lat,
      required this.lon});
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.args});

  final MapArgs args;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final Completer<GoogleMapController> _controller;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initMap();
  }

  void initMap() {
    _controller = Completer<GoogleMapController>();
    markers.add(Marker(
        onTap: () {
          UrlLauncherHelper.openGoogleMap(
              lat: widget.args.lat,
              lon: widget.args.lon,
              activityName: widget.args.subActivityName,
              image: widget.args.subActivityImage);
        },
        markerId: MarkerId(widget.args.subActivityName),
        position: LatLng(widget.args.lat, widget.args.lon),
        infoWindow: InfoWindow(
            snippet: widget.args.subActivityAddress,
            title: widget.args.subActivityName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: AppText(
          text: widget.args.subActivityName,
          fontWeight: FontWeight.w600,
          fontSize: AppFontSize.sp15,
          fontColor: AppColor.black,
        ),
      ),
      body: SizedBox(
        width: AppWidthSize.w100,
        height: AppHeightSize.h100,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.args.lat, widget.args.lon), zoom: 16),
          markers: markers,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
