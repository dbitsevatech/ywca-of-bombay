import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:auth/authentication/register.dart';

void main() => runApp(LoginScreen());

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign In',
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    // circle design
                    children: <Widget>[
                      Positioned(
                        child: Image.asset("assets/images/circle-design.png"),
                      ),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 100),
                            child:Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 35,
                                color: Color(0xff49DEE8),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RacingSansOne',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Welcome Back !',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
                    height: 50,
                  ),
                  Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      controller: _controller,
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Mobile number is required';
                        else if (!RegExp(r"^\d{10}$").hasMatch(value))
                          return 'Please enter a valid mobile number';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixText: '+91 | ',
                        labelText: 'Mobile Number',
                        filled: true,
                        fillColor: Color(0xffF3F4F6),
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          colors: [
                            Color(0xff00BBE4),
                            Color(0xff00BBE4),
                            Color(0xff005BE4)
                          ],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: FlatButton(
                      onPressed: () {
                        print(_controller.text);
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => OTPScreen(_controller.text)));
                      },
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 130.0, vertical: 25.0),
                    ),
                  ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text("Don't have an account? ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                            )),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Montserrat',
                              color: Color(0xff49DEE8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:ywca/otp.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//  TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Auth'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(children: [
//             Container(
//               margin: EdgeInsets.only(top: 60),
//               child: Center(
//                 child: Text(
//                   'Phone Authentication',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 40, right: 10, left: 10),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Phone Number',
//                   prefix: Padding(
//                     padding: EdgeInsets.all(4),
//                     child: Text('+1'),
//                   ),
//                 ),
//                 maxLength: 10,
//                 keyboardType: TextInputType.number,
//                 controller: _controller,
//               ),
//             )
//           ]),
//           Container(
//             margin: EdgeInsets.all(10),
//             width: double.infinity,
//             child: FlatButton(
//               color: Colors.blue,
//               onPressed: () {
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (context) => OTPScreen(_controller.text)));
//               },
//               child: Text(
//                 'Next',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
