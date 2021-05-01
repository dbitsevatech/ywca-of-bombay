import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register_otp.dart';
import '../../models/user.dart';
import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';

enum GenderChoices { female, male, declineToState }

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName;
  String lastName;
  DateTime dateOfBirth = new DateTime.now().subtract(Duration(days: 4380));
  String emailId;
  String phoneNumber;
  String gender = "Female";

  final _user = User(null, null, DateTime.now().subtract(Duration(days: 4380)),
      null, null, null, null, null, null, null);

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  GenderChoices selectedGender = GenderChoices.female;
  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
      // initialDatePickerMode: DatePickerMode.year,
      // https://github.com/flutter/flutter/issues/67909
      // https://github.com/flutter/flutter/pull/67926
      //
      // TODO: Check if above line UX issue is solved
      // Try this picker if issue does not solve: https://pub.dev/packages/flutter_rounded_date_picker
      helpText: 'Select Date of Birth',
      fieldLabelText: 'Enter date of birth',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: primaryColor, // highlighed date color
              onPrimary: Colors.black, // highlighted date text color
              surface: primaryColor, // header color
              onSurface: Colors.grey[800], // header text & calendar text color
            ),
            dialogBackgroundColor: Colors.white, // calendar bg color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: secondaryColor, // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != dateOfBirth) {
      setState(() {
        dateOfBirth = picked;
        // print(picked);
        print(dateOfBirth);
      });
    }
  }

  _showAlreadyRegisteredSnackBar() {
    final snackBar = SnackBar(
      content: Text(
        'Your phone number is already registered! Proceed to Log In',
        // style: TextStyle(fontSize: 15),
      ),
      // backgroundColor: Colors.red,
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

    // _scaffoldkey.currentState.showSnackBar(registerSnackBar); // Deprecated
    // https://flutter.dev/docs/release/breaking-changes/scaffold-messenger
    // https://stackoverflow.com/questions/65906662/showsnackbar-is-deprecated-and-shouldnt-be-used
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
            // userData: _user,
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
      _showAlreadyRegisteredSnackBar();
    }
  }

  @override
  void initState() {
    setState(() {
      selectedGender = GenderChoices.female;
      gender = "Female";
    });
    super.initState();
  }

  final int height = 1;
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
                // circle design and Title
                Stack(
                  children: <Widget>[
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
                          padding: EdgeInsets.only(top: _height * 0.095),
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 35,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RacingSansOne',
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
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
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
                            setState(() {
                              firstName = value;
                            });
                          },
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'First name is required.';
                            else
                              return null;
                          },
                          style: TextStyle(fontFamily: 'Montserrat'),
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
                              lastName = value;
                            });
                          },
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Last name is required.';
                            else
                              return null;
                          },
                          style: TextStyle(fontFamily: 'Montserrat'),
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
                          // keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            setState(() {
                              // dateOfBirth = DateTime.parse(value);
                              // dateOfBirth\ = value;
                            });
                          },
                          controller: dateController,
                          style: TextStyle(fontFamily: 'Montserrat'),
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
                            // TODO: BUG: text cursor showing over the date picker bcoz of async-await
                            await _selectDate();
                            dateController.text =
                                "${dateOfBirth.toLocal()}".split(' ')[0];
                          },
                        ),
                        SizedBox(height: _height * 0.015),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            setState(() {
                              emailId = value;
                            });
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            // return null coz validator has to return something
                            return null;
                          },
                          style: TextStyle(fontFamily: 'Montserrat'),
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
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Mobile number is required';
                            else if (!RegExp(r"^\d{10}$").hasMatch(value))
                              return 'Please enter a valid mobile number';
                            else
                              return null;
                          },
                          onSaved: (String value) {
                            setState(() {
                              phoneNumber = value;
                            });
                          },
                          style: TextStyle(fontFamily: 'Montserrat'),
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
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: const Text('Female'),
                              leading: Radio(
                                value: GenderChoices.female,
                                groupValue: selectedGender,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (GenderChoices value) {
                                  setState(() {
                                    selectedGender = value;
                                    gender = "Female";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Male'),
                              leading: Radio(
                                value: GenderChoices.male,
                                groupValue: selectedGender,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (GenderChoices value) {
                                  setState(() {
                                    selectedGender = value;
                                    gender = "Male";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Decline to state'),
                              leading: Radio(
                                value: GenderChoices.declineToState,
                                groupValue: selectedGender,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (GenderChoices value) {
                                  setState(() {
                                    selectedGender = value;
                                    gender = "Decline to State";
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: _height * 0.015),
                        GradientButton(
                          buttonText: 'Next',
                          screenHeight: _height,
                          route: 'register2',
                          onPressedFunction: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();

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
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
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
    );
  }
}

enum MemberChoices { yes, no, maybe }

// ignore: must_be_immutable
class RegisterScreen2 extends StatefulWidget {
  // final User userData;
  // var userData = User();
  final String firstName;
  final String lastName;
  final String emailId;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;
  RegisterScreen2({
    // this.userData,
    this.firstName,
    this.lastName,
    this.emailId,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
  });
  @override
  _RegisterScreen2State createState() => _RegisterScreen2State(
        // userData,
        firstName,
        lastName,
        emailId,
        phoneNumber,
        gender,
        dateOfBirth,
      );
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  // final User userData;
  // var userData = User();
  final String firstName;
  final String lastName;
  final String emailId;
  final String phoneNumber;
  final String gender;
  final DateTime dateOfBirth;

  String profession;
  String placeOfWork;
  String nearestCenter = "Chembur";
  String interestInMembership = "Yes";
  _RegisterScreen2State(
    // this.userData,
    this.firstName,
    this.lastName,
    this.emailId,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
  );
  MemberChoices _selectedMembershipInterest = MemberChoices.yes;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  void _onRegisterButtonPressed() async {
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

  @override
  void initState() {
    setState(() {
      _selectedMembershipInterest = MemberChoices.yes;
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
                          onSaved: (String value) {
                            setState(() {
                              if (value == '') {
                                profession = 'Retired';
                              } else {
                                profession = value;
                              }
                            });
                          },
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
                                placeOfWork = value;
                              }
                            });
                          },
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
                        // TODO: BUG: Focus goes to previous textfield after selecting center
                        // https://flutter.dev/docs/cookbook/forms/focus
                        // https://stackoverflow.com/questions/49592099/slide-focus-to-textfield-in-flutter
                        Text(
                          'Nearest YWCA Center',
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: _width * 0.262,
                            right: _width * 0.262,
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
                            onChanged: (String value) {
                              setState(() {
                                nearestCenter = value;
                                print(nearestCenter);
                              });
                            },
                            hint: Text(
                              "Nearest YWCA Center",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: _height * 0.010),
                        Text(
                          'Interested in being a member?',
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Column(
                          // TODO: Ability to select radio button when text is tapped
                          children: <Widget>[
                            ListTile(
                              title: const Text('Yes'),
                              leading: Radio(
                                value: MemberChoices.yes,
                                groupValue: _selectedMembershipInterest,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (MemberChoices value) {
                                  setState(() {
                                    _selectedMembershipInterest = value;
                                    interestInMembership = "Yes";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('No'),
                              leading: Radio(
                                value: MemberChoices.no,
                                groupValue: _selectedMembershipInterest,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (MemberChoices value) {
                                  setState(() {
                                    _selectedMembershipInterest = value;
                                    interestInMembership = "No";
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Maybe'),
                              leading: Radio(
                                value: MemberChoices.maybe,
                                groupValue: _selectedMembershipInterest,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                                onChanged: (MemberChoices value) {
                                  setState(() {
                                    _selectedMembershipInterest = value;
                                    interestInMembership = "Maybe";
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: _height * 0.005),
                        GradientButton(
                          buttonText: 'Register',
                          screenHeight: _height,
                          route: 'register_otp',
                          onPressedFunction: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
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
