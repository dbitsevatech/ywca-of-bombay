import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

import 'login.dart';
import 'register_otp.dart';

import '../../models/User.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/alert_dialogs.dart';
import '../../widgets/gradient_button.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName = '';
  String lastName = '';
  DateTime dateOfBirth = DateTime.now().subtract(Duration(days: 4380));
  String emailId = '';
  String phoneNumber = '';
  String gender = "Female";
  var userInfo;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  // female-0, male-1, decline to state-2
  int _genderRadioValue = 0;
  void _handleGenderRadioValueChange(int? value) {
    setState(() {
      _genderRadioValue = value!;
      if (_genderRadioValue == 0) {
        gender = "Female";
      } else if (_genderRadioValue == 1) {
        gender = "Male";
      } else {
        gender = "Decline to state";
      }
      print("gender selected: $gender");
    });
  }

  Future _selectDate() async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select Date of Birth',
      fieldLabelText: 'Enter date of birth',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF49dee8),
            accentColor: const Color(0xFF49dee8),
            colorScheme: ColorScheme.light(primary: const Color(0xFF49dee8)),

            dialogBackgroundColor: Colors.white, // calendar bg color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: secondaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ))!;
    if (picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
      });
    }
  }

  _showAlreadyRegisteredSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Your phone number is already registered! Proceed to Log In',
      ),
      backgroundColor: Colors.red[400],
      action: SnackBarAction(
        label: 'Log In',
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> _phoneNumberIsAlreadyRegistered(enteredPhoneNumber) async {
    List<String> _listOfRegisteredPhoneNumbers = [];
    print("checking: $enteredPhoneNumber");
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data()["phoneNumber"]);
        _listOfRegisteredPhoneNumbers.add(result.data()["phoneNumber"]);
      });
    });

    print("List of numbers: " + _listOfRegisteredPhoneNumbers.toString());
    print("Phone Number already registered: " +
        _listOfRegisteredPhoneNumbers.contains(enteredPhoneNumber).toString());
    return _listOfRegisteredPhoneNumbers.contains(enteredPhoneNumber);
  }

  void _onNextButtonPressed() async {
    if (!await _phoneNumberIsAlreadyRegistered(phoneNumber)) {
      print("user does not exist");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterScreen2(
            firstName: firstName,
            lastName: lastName,
            emailId: emailId,
            phoneNumber: phoneNumber,
            gender: gender,
            dateOfBirth: dateOfBirth,
          ),
        ),
      );
    } else {
      FocusScope.of(context).unfocus();
      print("PHONE NUMBER ALREADY REGISTERED! \n PROCEED TO LOG IN :)");
      Vibration.vibrate(duration: 100);
      _showAlreadyRegisteredSnackBar();
    }
  }

  @override
  void initState() {
    userInfo = Provider.of<UserData>(context, listen: false);
    setState(() {
      gender = "Female";
    });
    super.initState();
  }

  final int height = 1;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => showExitAlertDialog(context),
      child: Scaffold(
        key: _scaffoldkey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // circle design and Title
                  Stack(
                    children: <Widget>[
                      MainPageBlueBubbleDesign(),
                      Positioned(
                        child: AppBar(
                          centerTitle: true,
                          title: Text(
                            "YWCA OF BOMBAY",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w800,
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
                            padding: EdgeInsets.only(top: _height * 0.095),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 35,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RacingSansOne',
                                letterSpacing: 2.5,
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
                      // Have an account, LOG IN
                      Padding(
                        padding: EdgeInsets.only(top: _height * 0.15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  'Log In',
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
                      ),
                    ],
                  ),
                  // Form
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
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              print(userInfo.getfirstName);
                              setState(() {
                                firstName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return 'First name is required.';
                              else
                                return null;
                            },
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: secondaryColor,
                              ),
                              labelText: 'First Name',
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
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                lastName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return 'Last name is required.';
                              else
                                return null;
                            },
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.account_circle,
                                color: secondaryColor,
                              ),
                              labelText: 'Last Name',
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
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            readOnly: true,
                            onChanged: (value) {},
                            controller: dateController,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: secondaryColor,
                              ),
                              labelText: 'Date of Birth',
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
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _selectDate();
                              dateController.text =
                                  "${DateFormat('dd-MM-yyyy').format(dateOfBirth.toLocal())}"
                                      .split(' ')[0];
                            },
                          ),
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              setState(() {
                                emailId = value!;
                              });
                            },
                            // validator: (String? value) {
                            //   if (value!.isEmpty) {
                            //     return 'Email is required';
                            //   }
                            //   if (!RegExp(
                            //           "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                            //       .hasMatch(value)) {
                            //     return 'Enter a valid email address';
                            //   }
                            //   // return null coz validator has to return something
                            //   return null;
                            // },
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: secondaryColor,
                              ),
                              labelText: 'Email Address',
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
                          SizedBox(height: _height * 0.015),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            validator: (String? value) {
                              if (value!.isEmpty)
                                return 'Mobile number is required';
                              else if (!RegExp(r"^\d{10}$").hasMatch(value))
                                return 'Please enter a valid mobile number';
                              else
                                return null;
                            },
                            onSaved: (String? value) {
                              setState(() {
                                phoneNumber = value!;
                              });
                            },
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
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
                          Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Radio(
                                value: 0,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 0;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Radio(
                                value: 1,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 1;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Male',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Radio(
                                value: 2,
                                groupValue: _genderRadioValue,
                                onChanged: _handleGenderRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _genderRadioValue = 2;
                                      _handleGenderRadioValueChange(
                                          _genderRadioValue);
                                    });
                                  },
                                  child: Text(
                                    'Decline to state',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: _height * 0.015),
                          GradientButton(
                            buttonText: 'Next',
                            screenHeight: _height,
                            onPressedFunction: () async {
                              if (!_formKey.currentState!.validate()) {
                                Vibration.vibrate(duration: 100);
                                return;
                              }
                              _formKey.currentState!.save();
                              print("hello");
                              _onNextButtonPressed();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: _height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Text(
                            'Log In',
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
                  SizedBox(height: _height * 0.015),
                ],
              ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class RegisterScreen2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String emailId;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  RegisterScreen2({
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNumber,
    required this.gender,
    required this.dateOfBirth,
  });
  @override
  _RegisterScreen2State createState() => _RegisterScreen2State(
        firstName,
        lastName,
        emailId,
        phoneNumber,
        gender,
        dateOfBirth,
      );
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  String firstName;
  final String lastName;
  final String emailId;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  var userInfo;

  String profession = "";
  String placeOfWork = "";
  String nearestCenter = "Chembur";
  String interestInMembership = "Yes";
  _RegisterScreen2State(
    this.firstName,
    this.lastName,
    this.emailId,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
  );

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  void _onRegisterButtonPressed() async {
    print("register page: ");
    print(firstName);
    print(lastName);
    print(dateOfBirth);
    print(emailId);
    print(phoneNumber);
    print(gender);
    print(profession);
    print(placeOfWork);
    print(nearestCenter);
    print(interestInMembership);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterOtp(
          firstName: firstName,
          lastName: lastName,
          emailId: emailId,
          placeOfWork: placeOfWork,
          gender: gender,
          dateOfBirth: dateOfBirth,
          phoneNumber: phoneNumber,
          profession: profession,
          nearestCenter: nearestCenter,
          interestInMembership: interestInMembership,
        ),
      ),
    );
  }

  // yes-0, no-1, maybe-2
  int _interestInMembershipRadioValue = 0;
  void _handleInterestInMembershipRadioValueChange(int? value) {
    setState(() {
      _interestInMembershipRadioValue = value!;
      if (_interestInMembershipRadioValue == 0) {
        interestInMembership = "Yes";
      } else if (_interestInMembershipRadioValue == 1) {
        interestInMembership = "No";
      } else {
        interestInMembership = "Maybe";
      }
      print("Membership interest selected: $interestInMembership");
    });
  }

  @override
  void initState() {
    userInfo = userInfo;
    setState(() {
      interestInMembership = "Yes";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
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
                          padding: EdgeInsets.only(top: _height * 0.095),
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 35,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RacingSansOne',
                              letterSpacing: 2.5,
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (String? value) {
                            setState(() {
                              if (value == '') {
                                profession = 'Retired';
                              } else {
                                profession = value!;
                              }
                            });
                          },
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: secondaryColor,
                            ),
                            labelText: 'Profession',
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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  '(Leave blank if retired)',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  top: 2.5,
                                  bottom: 2.5,
                                  right: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            setState(() {
                              if (value == '') {
                                placeOfWork = 'Retired';
                              } else {
                                placeOfWork = value!;
                              }
                            });
                          },
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: secondaryColor,
                            ),
                            labelText: 'Place of work/school/college',
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
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: Text(
                                  '(Leave blank if retired)',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 15,
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  top: 2.5,
                                  bottom: 2.5,
                                  right: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Nearest YWCA Center',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: _width * 0.245,
                            right: _width * 0.245,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: formFieldFillColor,
                            // border: Border.all(),
                          ),
                          child: DropdownButton<String>(
                            value: nearestCenter,
                            icon: Icon(Icons.arrow_drop_down_rounded),
                            elevation: 16,
                            underline: Container(),
                            onChanged: (String? value) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                nearestCenter = value!;
                                print(nearestCenter);
                              });
                            },
                            items: <String>[
                              'Andheri',
                              'Bandra',
                              'Belapur',
                              'Borivali',
                              'Byculla',
                              'Chembur',
                              'Fort',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 16,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: _height * 0.010),
                        Text(
                          'Interested in being a member?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _interestInMembershipRadioValue,
                              onChanged:
                                  _handleInterestInMembershipRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _interestInMembershipRadioValue = 0;
                                    _handleInterestInMembershipRadioValueChange(
                                        _interestInMembershipRadioValue);
                                  });
                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Radio(
                              value: 1,
                              groupValue: _interestInMembershipRadioValue,
                              onChanged:
                                  _handleInterestInMembershipRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _interestInMembershipRadioValue = 1;
                                    _handleInterestInMembershipRadioValueChange(
                                        _interestInMembershipRadioValue);
                                  });
                                },
                                child: Text(
                                  'No',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Radio(
                              value: 2,
                              groupValue: _interestInMembershipRadioValue,
                              onChanged:
                                  _handleInterestInMembershipRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _interestInMembershipRadioValue = 2;
                                    _handleInterestInMembershipRadioValueChange(
                                        _interestInMembershipRadioValue);
                                  });
                                },
                                child: Text(
                                  'Maybe',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: _height * 0.005),
                        GradientButton(
                          buttonText: 'Register',
                          screenHeight: _height,
                          onPressedFunction: () {
                            // if (_formKey.currentState!.validate()) {
                            //   return;
                            // }
                            _formKey.currentState!.save();
                            _onRegisterButtonPressed();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
