// import 'package:flutter/material.dart';
import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:qclap/video.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qclap/qclap_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QClap',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      // home: const MyHomePage(title: 'QClap'),
      home: QClapHome(title: "QClap"),
    );
  }
}

class QClapHome extends StatefulWidget {
  QClapHome({super.key, required this.title});

  String title;
  bool infoUpdateBit = false;

  @override
  _QClapHomeState createState() => _QClapHomeState();
}

class _QClapHomeState extends State<QClapHome> {
  VideoMetadata videoMeta = VideoMetadata();
  String clipLink = "https://qclap.danielhou.me/0/";

  Future<void> _buildVideoMeta() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    videoMeta = VideoMetadata.fromStorage(prefs);
  }

  void _setSceneNumber(String newSceneNumber) {
    setState(() {
      videoMeta.scene = newSceneNumber;
    });
  }

  void _setShotNumber(String newShotNumber) {
    setState(() {
      videoMeta.shot = newShotNumber;
    });
  }

  void _incrementTakeNumber() {
    setState(() {
      videoMeta.take++;
    });
  }

  void _decrementTakeNumber() {
    setState(() {
      videoMeta.take--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // App Bar
        appBar: CustomAppBar(
          title: "TItle?",
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: CustomTextField(
                      // widthPercentage: 25,
                      heightPercentage: 20,
                      fixedText: "Scene",
                      textInput: videoMeta.scene.padLeft(2, '0'),
                      infoUpdateBit: widget.infoUpdateBit,
                    ),
                  ),
                  Flexible(
                    child: CustomTextField(
                      // widthPercentage: 25,
                      heightPercentage: 20,
                      fixedText: "Shot",
                      textInput: videoMeta.shot.padLeft(2, '0'),
                      infoUpdateBit: widget.infoUpdateBit,
                    ),
                  ),
                  Flexible(
                    child: CustomTextField(
                      // widthPercentage: 25,
                      heightPercentage: 20,
                      fixedText: "Take",
                      textInput: videoMeta.take.toString().padLeft(2, '0'),
                      infoUpdateBit: widget.infoUpdateBit,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 0,
              ),

              // Camera QR Section
              Flexible(

                // Middle Section
                child: Row(
                  children: [

                    // Left Half Info
                    Flexible(
                      child: Column(children: [
                        
                        // Director Row
                        Row(
                          children: [
                            Flexible(
                              child: CustomTextField(
                                // widthPercentage: 25,
                                heightPercentage: 18,
                                fixedText: "Director",
                                textInput: videoMeta.director,
                                infoUpdateBit: widget.infoUpdateBit,
                              ),
                            ),
                            Flexible(
                              child: CustomTextField(
                                // widthPercentage: 25,
                                heightPercentage: 18,
                                fixedText: "Slate No.",
                                textInput: videoMeta.slateNumber
                                    .toString()
                                    .padLeft(2, '0'),
                                infoUpdateBit: widget.infoUpdateBit,
                              ),
                            ),
                          ],
                        ),

                        // Camera Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: CustomTextField(
                                // widthPercentage: 25,
                                heightPercentage: 18,
                                fixedText: "Cam Man",
                                textInput: videoMeta.cameraMan.padLeft(2, '0'),
                                infoUpdateBit: widget.infoUpdateBit,
                              ),
                            ),
                            Flexible(
                              child: CustomTextField(
                                // widthPercentage: 25,
                                heightPercentage: 18,
                                fixedText: "Camera",
                                textInput: videoMeta.cameraNumber
                                    .toString()
                                    .padLeft(2, '0'),
                                infoUpdateBit: widget.infoUpdateBit,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 0,
                        ),

                        // Time Row
                        DateTimeWidget(),

                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          height: 0,
                        ),

                        // Last Row of Info
                        Row(
                          children: [
                            Flexible(
                              child: TextDisplayField(
                                // widthPercentage: 25,
                                heightPercentage: 12,
                                fixedText: "FPS",
                                textDisplay: videoMeta.fps.toString().padLeft(2, '0'),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                            ),
                            Flexible(
                              child: TextDisplayField(
                                // widthPercentage: 25,
                                heightPercentage: 12,
                                fixedText: "Resolution",
                                textDisplay: (videoMeta.width.toString() + "x" + videoMeta.height.toString()).padLeft(2, '0'),
                              ),
                            ),
                          ],
                        ),

                        // Last Row of Info
                        Row(
                          children: [
                            Flexible(
                              child: TextDisplayField(
                                // widthPercentage: 25,
                                heightPercentage: 12,
                                fixedText: "ISO",
                                textDisplay: videoMeta.isoSpeed.toString().padLeft(2, '0'),
                              ),
                            ),
                            SizedBox(
                              width: 100.0,
                            ),
                            Flexible(
                              child: TextDisplayField(
                                // widthPercentage: 25,
                                heightPercentage: 12,
                                fixedText: "Lens",
                                textDisplay: videoMeta.lens.toString().padLeft(2, '0'),
                              ),
                            ),

                            Flexible(
                              child: TextDisplayField(
                                // widthPercentage: 25,
                                heightPercentage: 12,
                                fixedText: "Lens",
                                textDisplay: widget.infoUpdateBit.toString().padLeft(2, '0'),
                              ),
                            ),
                          ],
                        ),

                        
                      ]),
                    ),
                    // QR Code Section
                    QRCodeWidget(
                        widthPercentage: 100,
                        heightPercentage: 100,
                        infoUpdateBit: widget.infoUpdateBit,
                        data: clipLink),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
