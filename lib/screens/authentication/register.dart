import 'package:ywcaofbombay/screens/authentication/login.dart';
import 'package:ywcaofbombay/screens/authentication/register_otp.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum GenderChoices { female, male, decline }

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name;
  String email;
  DateTime dob = new DateTime.now().subtract(Duration(days: 4380));
  String phone;
  String gender = "Female";
  final color = const Color(0xff49DEE8);

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
      initialDate: dob,
      firstDate: new DateTime(1940),
      lastDate: new DateTime.now().subtract(Duration(days: 4380)),
      // initialDatePickerMode: DatePickerMode.year,
      // TODO: Check if above line UX issue is solved
      // https://github.com/flutter/flutter/issues/67909
      // https://github.com/flutter/flutter/pull/67926
      //
      // Try this picker if issue does not solve: https://pub.dev/packages/flutter_rounded_date_picker
      helpText: 'Select Date of Birth',
      fieldLabelText: 'Enter date of birth',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xff49DEE8), // highlighed date color
              onPrimary: Colors.black, // highlighted date text color
              surface: Color(0xff49DEE8), // header color
              onSurface: Colors.grey[800], // header text & calendar text color
            ),
            dialogBackgroundColor: Colors.white, // calendar bg color
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xff00BBE4), // button text color
              ),
            ),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
        // print(picked);
        print(dob);
      });
    }
  }

  _showAlreadyRegisteredSnackBar() {
    final snackBar = SnackBar(
      content: Text(
          'Your phone number is already registered!. Proceed to Log In :)'),
      backgroundColor: Colors.red,
      // TODO: Add action to snackbar
      action: SnackBarAction(
        label: 'Log In',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<bool> _phoneNumberIsAlreadyRegistered(value) async {
    List<String> _listOfPhoneNumbers = [];

    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data()["phone"]);
        _listOfPhoneNumbers.add(result.data()["phone"]);
      });
    });

    print("List of numbers: " + _listOfPhoneNumbers.toString());
    print("Phone Number already registered: " +
        _listOfPhoneNumbers.contains(value).toString());
    return _listOfPhoneNumbers.contains(value);
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
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.all(16),
          // height: MediaQuery.of(context).size.height, // giving render issue
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
                          child: Text(
                            'REGISTER',
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
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Name is required.';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xff00BBE4),
                        ),
                        labelText: 'Full Name',
                        filled: true,
                        fillColor: Color(0xffF3F4F6),
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      // keyboardType: TextInputType.datetime,
                      onChanged: (value) {
                        setState(() {
                          // dob = DateTime.parse(value);
                          // dob = value;
                        });
                      },
                      controller: dateController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          color: Color(0xff00BBE4),
                        ),
                        labelText: 'Date of Birth',
                        filled: true,
                        fillColor: Color(0xffF3F4F6),
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // TODO: BUG: text cursor showing over the date picker bcoz of async-await
                        await _selectDate();
                        dateController.text = "${dob.toLocal()}".split(' ')[0];
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 360,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      setState(() {
                        email = value;
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
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xff00BBE4),
                      ),
                      labelText: 'Email Address',
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
                  height: 25,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
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
                      // onChanged: (String value) {
                      //   setState(() {
                      //     phone = value;
                      //   });
                      // },
                      onSaved: (String value) {
                        setState(() {
                          phone = value;
                        });
                        //   print("onSaved!: " + value);
                        // List<String> _listOfPhoneNumbers = ['0'];
                        // await FirebaseFirestore.instance
                        //     .collection("users")
                        //     .get()
                        //     .then((querySnapshot) {
                        //   querySnapshot.docs.forEach((result) {
                        //     print(result.data()["phone"]);
                        //     _listOfPhoneNumbers.add(result.data()["phone"]);
                        //   });
                        // });
                        // print(_listOfPhoneNumbers);
                        // if (!_listOfPhoneNumbers.contains(value)) {
                        //   // TODO: Try removing await in below condition
                        //   // if (!await _phoneNumberIsAlreadyRegistered(value)) {
                        // } else {
                        //   FocusScope.of(context).unfocus();
                        //   print(
                        //       "PHONE NUMBER ALREADY REGISTERED! \n PROCEED TO LOG IN :)");
                        //   _showAlreadyRegisteredSnackBar();
                        // }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Color(0xff00BBE4),
                        ),
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
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff49DEE8),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RacingSansOne',
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Female'),
                      leading: Radio(
                        value: GenderChoices.female,
                        groupValue: selectedGender,
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
                        value: GenderChoices.decline,
                        groupValue: selectedGender,
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
                SizedBox(
                  height: 25,
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
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        if (!await _phoneNumberIsAlreadyRegistered(phone)) {
                          print("user does not exist");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen2(
                                  name: name,
                                  email: email,
                                  phone: phone,
                                  gender: gender,
                                  dob: dob),
                            ),
                          );
                        } else {
                          FocusScope.of(context).unfocus();
                          print(
                              "PHONE NUMBER ALREADY REGISTERED! \n PROCEED TO LOG IN :)");
                          _showAlreadyRegisteredSnackBar();
                        }
                      },
                      child: Center(
                        child: Text(
                          'Next',
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
                  height: 10,
                ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Log In',
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
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum MemberChoices { yes, no, maybe }

// ignore: must_be_immutable
class RegisterScreen2 extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final DateTime dob;
  RegisterScreen2({this.name, this.email, this.phone, this.gender, this.dob});
  @override
  _RegisterScreen2State createState() =>
      _RegisterScreen2State(name, email, phone, gender, dob);
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final DateTime dob;

  String prof;
  String pow;
  String center = 'Chembur';
  String interest = "Yes";
  _RegisterScreen2State(
      this.name, this.email, this.phone, this.gender, this.dob);
  final color = const Color(0xff49DEE8);
  MemberChoices _selectedMemberChoice = MemberChoices.yes;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  @override
  void initState() {
    setState(() {
      _selectedMemberChoice = MemberChoices.yes;
      interest = "Yes";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Text(
                            'REGISTER',
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
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (String value) {
                        setState(() {
                          prof = value;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff00BBE4),
                        ),
                        labelText: 'Profession',
                        filled: true,
                        fillColor: Color(0xffF3F4F6),
                        disabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
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
                            color: Color(0xff49DEE8),
                            fontSize: 15,
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 25,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 360,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      setState(() {
                        if (value == '') {
                          pow = 'Retired';
                        } else {
                          pow = value;
                        }
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Color(0xff00BBE4),
                      ),
                      labelText: 'Place of work/school/college',
                      filled: true,
                      fillColor: Color(0xffF3F4F6),
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
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
                            color: Color(0xff49DEE8),
                            fontSize: 15,
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          right: 25,
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
                    color: Color(0xff49DEE8),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RacingSansOne',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  // width: 360,
                  // child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 130.0, right: 130.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xffF3F4F6),
                      // border: Border.all(),
                    ),
                    child: DropdownButton<String>(
                      value: center,
                      underline: Container(),
                      onChanged: (String value) {
                        setState(() {
                          center = value;
                          print(center);
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
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Interested in being a member?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff49DEE8),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'RacingSansOne',
                  ),
                ),
                Column(
                  // TODO: Ability to select radio button when text is tapped
                  children: <Widget>[
                    ListTile(
                      title: const Text('Yes'),
                      leading: Radio(
                        value: MemberChoices.yes,
                        groupValue: _selectedMemberChoice,
                        onChanged: (MemberChoices value) {
                          setState(() {
                            _selectedMemberChoice = value;
                            interest = "Yes";
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('No'),
                      leading: Radio(
                        value: MemberChoices.no,
                        groupValue: _selectedMemberChoice,
                        onChanged: (MemberChoices value) {
                          setState(() {
                            _selectedMemberChoice = value;
                            interest = "No";
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Maybe'),
                      leading: Radio(
                        value: MemberChoices.maybe,
                        groupValue: _selectedMemberChoice,
                        onChanged: (MemberChoices value) {
                          setState(() {
                            _selectedMemberChoice = value;
                            interest = "Maybe";
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
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
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        print(name);
                        print(dob);
                        print(phone);
                        print(email);
                        print(gender);
                        print(prof);
                        print(pow);
                        print(center);
                        print(interest);
                        // TODO: Phone Number already registered snackbar
                        // CollectionReference users =
                        //     FirebaseFirestore.instance.collection('users');
                        // users.doc(documentId).get();
                        _formKey.currentState.save();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterOtp(
                              name: name,
                              email: email,
                              pow: pow,
                              gender: gender,
                              dob: dob,
                              phone: phone,
                              prof: prof,
                              center: center,
                              interest: interest,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Register',
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
                  height: 10,
                ),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            color: Color(0xff49DEE8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class GetUserName extends StatelessWidget {
//   final String documentId;

//   GetUserName(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           print("Something went wrong");
//           return Text("Something went wrong");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           print("Full Name: ${data['full_name']} ${data['last_name']}");
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }
