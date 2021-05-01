import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_otp.dart';
import 'register.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';

void main() => runApp(LoginScreen());

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController _controller = TextEditingController();
  String phoneNumber;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snackbar

  void _showNumberNotRegisteredSnackBar() {
    final registerSnackBar = SnackBar(
      content: Text(
        'Phone number not registered!',
        // style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Register',
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
                  (route) => false);
        },
      ),
    );

    // _scaffoldkey.currentState.showSnackBar(registerSnackBar); // Deprecated
    // https://flutter.dev/docs/release/breaking-changes/scaffold-messenger
    // https://stackoverflow.com/questions/65906662/showsnackbar-is-deprecated-and-shouldnt-be-used
    ScaffoldMessenger.of(context).showSnackBar(registerSnackBar);
  }

  void _onLoginButtonPressed(BuildContext context, String phoneNumber) async {
    print("submit function called");
    // final auth = Provider.of(context).auth;
    // if (await auth.userExists(phoneNumber)) {
    //   print("User found");
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => LoginOtp(phoneNumber: phoneNumber),
    //     ),
    //   );
    // } else {
    //   FocusScope.of(context).unfocus();
    //   print("No user found");
    //   _showNumberNotRegisteredSnackBar(); // context needed to be passed?
    // }
    var checkuser = await FirebaseFirestore.instance
        .collection('users')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    if (checkuser.docs.length == 1) {
      print("User found");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginOtp(phoneNumber: phoneNumber),
        ),
      );
    } else {
      FocusScope.of(context).unfocus();
      print("No user found");
      _showNumberNotRegisteredSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                            fontFamily: 'LilyScriptOne',
                            fontSize: 18.0,
                            color: Colors.black87,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: Padding(
                          // padding: EdgeInsets.only(top: 100),
                          padding: EdgeInsets.only(top: _height * 0.15),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 40,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RacingSansOne',
                              letterSpacing: 3,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 3.0),
                                  blurRadius: 3.0,
                                  color: Color(0xff333333),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                Text(
                  'Welcome Back !',
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      'We are happy to see you again. You can continue where you left off by logging in.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff7C82A1),
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    // horizontal: _height * 0.02,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          // controller: _controller,
                          onChanged: (value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Mobile number is required';
                            else if (!RegExp(r"^\d{10}$").hasMatch(value))
                              return 'Please enter a valid mobile number';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: secondaryColor,
                            ),
                            prefixText: '+91 | ',
                            labelText: 'Mobile Number',
                            filled: true,
                            fillColor: formFieldFillColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: secondaryColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.1,
                        ),
                        GradientButton(
                          buttonText: 'Login',
                          screenHeight: _height,
                          route: 'login_otp',
                          onPressedFunction: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            _onLoginButtonPressed(context, phoneNumber);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("Don't have an account? ",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2,
                          ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                                  (route) => false);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
