import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoMetadata {
  String slateNumber = "1";

  // Production Information
  String productionTitle = "N/A";
  String director = "N/A";

  // Scene Information
  String scene = "1";
  String shot = "1";
  String take = "1";

  // Camera Info
  String cameraNumber = "1";
  String cameraMan = "N/A";

  String fps = "60.00";
  String width = "3840";
  String height = "2160";

  String isoSpeed = "-1";
  String focalLength = "80 mm";
  String lens = "N/A";

  VideoMetadata();

  VideoMetadata.fromData(
      int sn,
      this.productionTitle,
      this.director,
      this.scene,
      this.shot,
      this.take,
      this.cameraNumber,
      this.cameraMan,
      this.fps,
      this.width,
      this.height,
      this.isoSpeed,
      this.focalLength,
      this.lens);

  VideoMetadata.fromStorage(SharedPreferences prefs) {
    slateNumber = prefs.getString('slateNumber') ?? slateNumber;
    productionTitle = prefs.getString('productionTitle') ?? productionTitle;
    director = prefs.getString('director') ?? director;

    scene = prefs.getString('scene') ?? scene;
    shot = prefs.getString('shot') ?? shot;
    take = prefs.getString('take') ?? take;

    cameraNumber = prefs.getString('cameraNumber') ?? cameraNumber;
    cameraMan = prefs.getString('cameraMan') ?? cameraMan;

    fps = prefs.getString('fps') ?? fps;
    width = prefs.getString('width') ?? width;
    height = prefs.getString('height') ?? height;

    isoSpeed = prefs.getString('isoSpeed') ?? isoSpeed;
    focalLength = prefs.getString('focalLength') ?? focalLength;
    lens = prefs.getString('lens') ?? lens;
  }
}

void clearReference() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('slateNumber');
  prefs.remove('productionTitle');
  prefs.remove('director');

  prefs.remove('scene');
  prefs.remove('shot');
  prefs.remove('take');

  prefs.remove('cameraNumber');
  prefs.remove('cameraMan');
  prefs.remove('fps');
  prefs.remove('width');
  prefs.remove('height');

  prefs.remove('isoSpeed');
  prefs.remove('focalLength');
  prefs.remove('lens');
}

class UpdateStatus extends ChangeNotifier {
  bool status = true;

  void setStatus(bool s) {
    status = s;
  }

  bool getStatus() {
    return status;
  }
}
