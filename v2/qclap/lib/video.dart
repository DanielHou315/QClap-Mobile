import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoMetadata {
  int slateNumber = 1;

  // Production Information
  String productionTitle = "";
  String director = "";

  // Scene Information
  String scene = "1";
  String shot = "1";
  int take = 1;

  // Camera Info
  int cameraNumber = 1;
  String cameraMan = "";

  double fps = 30.00;
  int width = 1920;
  int height = 1080;

  String? isoSpeed = "2000";
  String? focalLength = "80 mm";
  String? lens = "N/A";

  int dateTime = -1;

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
      this.lens,
      this.dateTime);

  VideoMetadata.fromStorage(SharedPreferences prefs) {
    slateNumber = prefs.getInt('slateNumber') ?? slateNumber;
    productionTitle = prefs.getString('productionTitle') ?? productionTitle;
    director = prefs.getString('director') ?? director;

    scene = prefs.getString('scene') ?? scene;
    shot = prefs.getString('shot') ?? shot;
    take = prefs.getInt('take') ?? take;

    cameraNumber = prefs.getInt('cameraNumber') ?? cameraNumber;
    cameraMan = prefs.getString('cameraMan') ?? cameraMan;

    fps = prefs.getDouble('fps') ?? fps;
    width = prefs.getInt('width') ?? width;
    height = prefs.getInt('height') ?? height;

    isoSpeed = prefs.getString('isoSpeed') ?? isoSpeed;
    focalLength = prefs.getString('focalLength') ?? focalLength;
    lens = prefs.getString('lens') ?? lens;
    dateTime = prefs.getInt('dateTime') ?? dateTime;
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
