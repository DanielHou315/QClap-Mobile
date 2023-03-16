import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';
import 'dart:async';
import 'package:qclap/qclap_request.dart';
import 'package:qclap/video.dart';
import 'package:provider/provider.dart';

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
    return Consumer<UpdateStatus>(
      builder: (context, updatestatus, child) {
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
    );
  }
}

// QClap String Field
class CustomTextField extends StatefulWidget {
  // final double widthPercentage;
  final double heightPercentage;
  final String fixedText;
  String textInput = '';
  bool infoUpdateBit;

  CustomTextField({
    Key? key,
    // required this.widthPercentage,
    required this.heightPercentage,
    required this.fixedText,
    required this.textInput,
    required this.infoUpdateBit,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
            widget.fixedText + widget.infoUpdateBit.toString(),
            style: TextStyle(
              fontSize: 18,
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
              setState(() {
                widget.textInput = value;
                widget.infoUpdateBit = true;
              });
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
  bool infoUpdateBit;

  String data;

  QRCodeWidget({
    required this.widthPercentage,
    required this.heightPercentage,
    required this.infoUpdateBit,
    required this.data,
  });

  @override
  _QRCodeWidgetState createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  @override
  void initState() {
    widget.data = 'https://qclap.danielhou.me/0/';
    super.initState();
  }

  void updateData(String newData) {
    setState(() {
      widget.data = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    final qrSize =
        min(screenHeight * widget.widthPercentage / 100, screenWidth * 0.6);

    if (widget.infoUpdateBit == false) {
      return SizedBox(
        width: qrSize,
        height: qrSize,
        child: QrImage(
          data: widget.data,
          version: QrVersions.auto,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // Callback function to be executed on tap
          print('SizedBox was tapped!');
        },
        child: SizedBox(
            width: qrSize,
            height: qrSize,
            child: Text(
              "Tap to Get QR Code",
            )),
      );
    }
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
    double timeFontSize = MediaQuery.of(context).size.width * 0.04;
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
