import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/User.dart';
import '../../screens/events/user_events.dart';
import '../../screens/admin/events/admin_events.dart';

import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';

class LoginOtp extends StatefulWidget {
  final String phoneNumber;
  const LoginOtp({required this.phoneNumber});

  @override
  _LoginOtpState createState() => _LoginOtpState(phoneNumber);
}

class _LoginOtpState extends State<LoginOtp>
    with SingleTickerProviderStateMixin {
  // Constants
  final int time = 59;
  var userInfo;

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final String _phoneNumber;

  String _verificationCode = "";
  _LoginOtpState(this._phoneNumber);
  AnimationController? _controller;
  String otp = "";
  // Variables
  Size? _screenSize;
  int _currentDigit = -1;
  int _firstDigit = -1;
  int _secondDigit = -1;
  int _thirdDigit = -1;
  int _fourthDigit = -1;
  int _fifthDigit = -1;
  int _sixthDigit = -1;

  Timer? timer;
  int? totalTimeInSeconds;
  bool? _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  _showInvalidOTPSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Invalid OTP. Try again',
        // style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {},
      ),
    );

    // _scaffoldkey.currentState.showSnackBar(registerSnackBar); // Deprecated
    // https://flutter.dev/docs/release/breaking-changes/scaffold-messenger
    // https://stackoverflow.com/questions/65906662/showsnackbar-is-deprecated-and-shouldnt-be-used
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onLoginButtonPressed() async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otp))
          .then(
        (value) async {
          if (value.user != null) {
            // userInfo.updatefirstName(firstName);
            if (userInfo.getmemberRole == 'Admin') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdminEvents()),
                  (route) => false);
            } else {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Events()),
                  (route) => false);
            }
          }
        },
      );
    } catch (e) {
      FocusScope.of(context).unfocus();
      print(e);
      print("Invalid OTP");

      _showInvalidOTPSnackBar();
    }
    // on FirebaseAuthException catch (e) {
    //   print('Failed with error code: ${e.code}');
    //   print(e.message);
    // }
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Padding(
      padding: EdgeInsets.only(top: _screenSize!.height * 0.12),
      child: Text(
        "Verification Code",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'RacingSansOne',
          fontSize: 32.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Return "Email" label
  get _getPleaseEnterLabel {
    return Text(
      "Please enter the 6-digit OTP code sent\nto your registered mobile number.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }

  // Return "OTP" input field
  get _getInputField {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _otpTextField(_firstDigit),
        _otpTextField(_secondDigit),
        _otpTextField(_thirdDigit),
        _otpTextField(_fourthDigit),
        _otpTextField(_fifthDigit),
        _otpTextField(_sixthDigit),
      ],
    );
  }

  // Returns "OTP" input part
  get _getInputPart {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Stack(
          children: <Widget>[
            // circle design
            MainPageBlueBubbleDesign(),
            Positioned(
              child: AppBar(
                centerTitle: true,
                title: Text(
                  "YWCA Of Bombay",
                  style: TextStyle(
                    fontFamily: 'LobsterTwo',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Positioned(
              child: Center(
                child: _getVerificationCodeLabel,
              ),
            ),
          ],
        ),
        _getPleaseEnterLabel,
        _getInputField,
        _hideResendButton! ? _getTimerText : _getResendButton,
        _logInButton,
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: Offstage(
        offstage: _hideResendButton!,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.access_time),
            SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller!, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return InkWell(
      child: Container(
        height: 32,
        width: 120,
        decoration: BoxDecoration(
          // color: Colors.black,
          color: secondaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(32),
        ),
        alignment: Alignment.center,
        child: Text(
          "Resend OTP",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      onTap: () {
        // Resend you OTP via API or anything
        print("resend button pressed!");
        _verifyPhoneNumber();
      },
    );
  }

  // Log In button
  get _logInButton {
    return FractionallySizedBox(
      widthFactor: 0.92, // button width wrt screen width
      // Log In Button
      child: GradientButton(
        buttonText: 'Log In',
        screenHeight: _screenSize!.height,
        onPressedFunction: () => _onLoginButtonPressed(),
      ),
    );
  }

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91$_phoneNumber',
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            if (userInfo.getmemberRole == 'none') {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Events()),
                  (route) => false);
            } else if (userInfo.getmemberRole == 'Admin') {
              // TOD: Add Admin Events navigation
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     MaterialPageRoute(builder: (context) => AdminMainWidget()),
              //     (route) => false);
            }
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verficationID, int? resendToken) {
        setState(() {
          _verificationCode = verficationID;
        });
        print("code sent. verification id = $_verificationCode");
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        if (!mounted) return;
        setState(() {
          _verificationCode = verificationID;
        });
      },
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return Container(
        height: _screenSize!.width - 180,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 80.0,
                  ),
                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_sixthDigit != -1) {
                            _sixthDigit = -1;
                          } else if (_fifthDigit != -1) {
                            _fifthDigit = -1;
                          } else if (_fourthDigit != -1) {
                            _fourthDigit = -1;
                          } else if (_thirdDigit != -1) {
                            _thirdDigit = -1;
                          } else if (_secondDigit != -1) {
                            _secondDigit = -1;
                          } else if (_firstDigit != -1) {
                            _firstDigit = -1;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Overridden methods
  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    super.initState();
    _verifyPhoneNumber();
    totalTimeInSeconds = time;
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = _hideResendButton;
              });
            }
          });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
    _startCountdown();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: _getAppbar,
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: _screenSize!.width,
//        padding:  EdgeInsets.only(bottom: 16.0),
          child: _getInputPart,
        ),
      ),
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return Container(
      width: 35.0,
      height: 45.0,
      alignment: Alignment.center,
      child: Text(
        // ignore: unnecessary_null_comparison
        digit != -1 ? digit.toString() : "",
        // digit != null ? digit.toString() : "",
        style: TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
      decoration: BoxDecoration(
//            color: Colors.grey.withOpacity(0.4),
          border: Border(
              bottom: BorderSide(
        width: 2.0,
        color: Colors.black,
      ))),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton(
      {required String label, required VoidCallback onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton(
      {required Widget label, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == -1) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == -1) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == -1) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == -1) {
        _fourthDigit = _currentDigit;
      } else if (_fifthDigit == -1) {
        _fifthDigit = _currentDigit;
      } else if (_sixthDigit == -1) {
        _sixthDigit = _currentDigit;

        otp = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString() +
            _fifthDigit.toString() +
            _sixthDigit.toString();

        // Verify your otp by here. API call
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller!
        .reverse(from: _controller!.value == 0.0 ? 1.0 : _controller!.value);
  }

  void clearOtp() {
    _sixthDigit = -1;
    _fifthDigit = -1;
    _fourthDigit = -1;
    _thirdDigit = -1;
    _secondDigit = -1;
    _firstDigit = -1;
    setState(() {});
  }
}

// ignore: must_be_immutable
class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration! * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration!;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Text(
            timerString,
            style: TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
