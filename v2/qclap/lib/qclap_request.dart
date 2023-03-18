import "package:qclap/video.dart";
import "package:http/http.dart" as http;
import "dart:convert";

Future<String> requestPost(VideoMetadata vidMeta) async {
  // var url = Uri.parse('https://qclap.danielhou.me/api/api1/vm/create/');
  var url = Uri.https('qclap.danielhou.me', '/api/api1/vm/create/');
  // var header = {
  //   "Access-Control-Allow-Origin": "*",
  // };
  var data = {
    'username': 'danielhou315@gmail.com',
    'password': 'HhdQclap104235',
    'slate_number': vidMeta.slateNumber,
    'production_title': vidMeta.productionTitle,
    'director': vidMeta.director,
    'scene': vidMeta.scene,
    'shot': vidMeta.shot,
    // 'take': int.parse(vidMeta.take),
    'take': vidMeta.take,
    'camera_man': vidMeta.cameraMan,
    // 'camera_number': int.parse(vidMeta.cameraNumber),
    'camera_number': vidMeta.cameraNumber,
    // 'fps': double.parse(vidMeta.fps),
    'fps': vidMeta.fps,
    // 'width': int.parse(vidMeta.width),
    'width': vidMeta.width,
    // 'height': int.parse(vidMeta.height),
    'height': vidMeta.height,
    // 'iso_speed': int.parse(vidMeta.isoSpeed),
    'iso_speed': vidMeta.isoSpeed,
    'focal_length': vidMeta.focalLength,
    'lens': vidMeta.lens,
  };

  print("Sending Data");
  var response = await http.post(url, body: data);
  print(response);

  print("Received Data");

  print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  if (response.statusCode == 201) {
    return response.body;
  } else if (response.statusCode == 422) {
    return "Invalid Data";
  } else if (response.statusCode == 400) {
    return "No Login Info";
  } else if (response.statusCode == 401) {
    return "Wrong Email or Password";
  } else {
    return "Server side Error";
  }
}
