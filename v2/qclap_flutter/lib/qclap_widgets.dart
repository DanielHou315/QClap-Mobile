import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'dart:async';
import 'package:qclap/qclap_request.dart';
import 'package:qclap/video.dart';

import 'package:shared_preferences/shared_preferences.dart';

// QClap App Bar
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  String title;

  CustomAppBar({super.key, required this.title});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// App Bar
class _CustomAppBarState extends State<CustomAppBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // The QClap App Bar
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              // Left Search
              child: TextField(
                style: TextStyle(
                  fontSize: 24,
                ),
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Production',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    widget.title = value;
                  });
                },
              ),
            ),
          ],
        ),

        // Buttons
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => LoginOverlay(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // do something
            },
          ),
        ],
        elevation: 0,
        bottom: PreferredSize(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            height: 0,
          ),
          preferredSize: Size.fromHeight(1),
        ));
  }
}

// Static Text Field
class TextDisplayField extends StatefulWidget {
  // final double widthPercentage;
  final double heightPercentage;
  final String fixedText;
  String textDisplay = '';

  TextDisplayField({
    Key? key,
    // required this.widthPercentage,
    required this.heightPercentage,
    required this.fixedText,
    required this.textDisplay,
  }) : super(key: key);

  @override
  _TextDisplayFieldState createState() => _TextDisplayFieldState();
}

class _TextDisplayFieldState extends State<TextDisplayField> {
  @override
  Widget build(BuildContext context) {
    // final width =
    //     MediaQuery.of(context).size.width * widget.widthPercentage / 100;
    final height =
        MediaQuery.of(context).size.height * widget.heightPercentage / 100;
    final double inputFontSize = height * 0.4;

    return Container(
      // width: width,
      height: height,
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.grey[300]!,
          //   width: 1,
          // ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fixedText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.textDisplay,
            style: TextStyle(
              fontSize: inputFontSize,
            ),
          ),
        ],
      ),
    );
  }
}

// QClap String Field
class CustomTextField extends StatefulWidget {
  // final double widthPercentage;
  final double heightPercentage;
  final String fixedText;
  String textInput = '';
  final String storeKey;

  CustomTextField({
    Key? key,
    // required this.widthPercentage,
    required this.heightPercentage,
    required this.fixedText,
    required this.textInput,
    required this.storeKey,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Future<void> _setPref(String value) async {
    // perform some asynchronous operation
    // and return the result
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.storeKey, value);
    setState(() {
      widget.textInput = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width =
    //     MediaQuery.of(context).size.width * widget.widthPercentage / 100;
    final height =
        MediaQuery.of(context).size.height * widget.heightPercentage / 100;
    final double inputFontSize = height * 0.4;

    return Container(
      // width: width,
      height: height,
      decoration: BoxDecoration(
          // border: Border.all(
          //   color: Colors.grey[300]!,
          //   width: 1,
          // ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fixedText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextField(
            style: TextStyle(
              fontSize: inputFontSize,
            ),
            decoration: InputDecoration(
              hintText: widget.fixedText,
              border: InputBorder.none,
            ),
            onChanged: (value) {
              _setPref(value);
            },
          ),
        ],
      ),
    );
  }
}

// QR Code Display Field
class QRCodeWidget extends StatefulWidget {
  final double widthPercentage;
  final double heightPercentage;

  QRCodeWidget({
    required this.widthPercentage,
    required this.heightPercentage,
  });

  @override
  _QRCodeWidgetState createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  String data = 'https://qclap.danielhou.me/api/api1/ping/';
  @override
  void initState() {
    data = 'https://qclap.danielhou.me/api/api1/ping/';
    super.initState();
  }

  Future<void> updateQR() async {
    print("In Update Function");
    SharedPreferences pref = await SharedPreferences.getInstance();
    VideoMetadata newMeta = VideoMetadata.fromStorage(pref);
    String rtn = await requestPost(newMeta);
    print("Received String");
    if (rtn != "error") {
      setState(() {
        data = rtn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    final qrSize =
        min(screenHeight * widget.widthPercentage / 100, screenWidth * 0.5);

    return Column(
      children: [
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            minimumSize:
                MaterialStateProperty.all(Size(150, 30)), // set button size
            textStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 16)), // set font size
            overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(
                0.2)), // set overlay color to black with 20% opacity
          ),
          onPressed: () {
            updateQR();
          },
          child: Text('Update QR'),
        ),
        const SizedBox(
          height: 5
        ),
        SizedBox(
          width: qrSize,
          height: qrSize,
          child: QrImage(
            data: data,
            version: QrVersions.auto,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        )
      ],
    );
  }
}

// Date Time Display Field
class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDateTimeText(_dateTime.year.toString() + " / "),
        _buildDateTimeText(_dateTime.month.toString() + " / "),
        _buildDateTimeText(_dateTime.day.toString()),
        SizedBox(width: 48.0),
        _buildDateTimeText(_dateTime.hour.toString() + " : ",
            color: Colors.red),
        _buildDateTimeText(_dateTime.minute.toString() + " : ",
            color: Colors.red),
        _buildDateTimeText(_dateTime.second.toString(), color: Colors.red),
      ],
    );
  }

  Widget _buildDateTimeText(String text, {Color? color}) {
    double timeFontSize = MediaQuery.of(context).size.height * 0.04;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: TextStyle(
            fontSize: timeFontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}

// Login Overlay
class LoginOverlay extends StatefulWidget {
  const LoginOverlay({Key? key}) : super(key: key);

  @override
  _LoginOverlayState createState() => _LoginOverlayState();
}

class _LoginOverlayState extends State<LoginOverlay> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Close the overlay when tapped outside of it
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  // SizedBox(height: 16),
                  // TextFormField(
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //   ),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Please enter your password';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) {
                  //     _password = value!;
                  //   },
                  // ),
                  // SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       _formKey.currentState!.save();
                  //       // TODO: Verify login information here
                  //       Navigator.of(context).pop();
                  //     }
                  //   },
                  //   child: Text('Login'),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
