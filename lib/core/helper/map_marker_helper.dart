import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class MapMarkerHelper {
  static Future<BitmapDescriptor> getMapMarkerFrom(
      {required String path}) async {
    return BitmapDescriptor.fromBytes(await getCustomMarkerFromSvg(path));
  }

  static Future<Uint8List> getCustomMarkerFromSvg(String svgAssetPath) async {
    ByteData data = await rootBundle.load(svgAssetPath);

    // For SVG files, use the Flutter_svg package
    final svgString = await rootBundle.loadString(svgAssetPath);
    final picture = SvgPicture.string(svgString, width: 100.0);
    // Convert the SVG picture to a PNG byte list
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    // picture.paint(canvas, Rect.zero);
    final img = await recorder.endRecording().toImage(100, 100);
    final ByteData? byteData =
        await img.toByteData(format: ui.ImageByteFormat.png);

    // Return the PNG byte list
    return byteData!.buffer.asUint8List();
  }
}
