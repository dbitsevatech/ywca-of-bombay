import 'package:flutter/material.dart';

import 'package:auth/screens/authentication/login.dart';
import 'package:auth/screens/authentication/register_otp.dart';

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
  String pow;
  String gender = "Female";
  // var _value;
  final color = const Color(0xff49DEE8);

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

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
      helpText: 'Select Date of Birth',
      fieldLabelText: 'Enter date of birth',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null && picked != dob)
      setState(() {
        dob = picked;
        // print(picked);
        print(dob);
      });
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
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
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
                      // onSaved: (String value) {
                      //   name = value;
                      // },
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
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate();
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
                    onChanged: (value) {
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

                      // validator has to return something :)
                      return null;
                    },
                    // onSaved: (String value) {
                    //   email = value;
                    // },
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
                Container(
                  width: 360,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
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
                        padding: EdgeInsets.all(10),
                      )
                    ],
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
                      onPressed: () {
                        print(dob);
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen2(
                                  name: name,
                                  email: email,
                                  pow: pow,
                                  gender: gender,
                                  dob: dob)),
                        );
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
  final String pow;
  final String gender;
  final DateTime dob;
  RegisterScreen2({this.name, this.email, this.pow, this.gender, this.dob});
  @override
  _RegisterScreen2State createState() =>
      _RegisterScreen2State(name, email, pow, gender, dob);
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final String name;
  final String email;
  final String pow;
  final String gender;
  final DateTime dob;

  String phone;
  String prof;
  String center = 'Chembur';
  String interest = "Yes";
  _RegisterScreen2State(this.name, this.email, this.pow, this.gender, this.dob);
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
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Mobile number is required';
                        else if (!RegExp(r"^\d{10}$").hasMatch(value))
                          return 'Please enter a valid mobile number';
                        else
                          return null;
                      },
                      // onSaved: (String value) {
                      //   phone = value;
                      // },
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
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 360,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
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
                            fontSize: 13,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
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
                  height: 25,
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
                      onPressed: () {
                        print(name);
                        print(email);
                        print(pow);
                        print(dob);
                        print(gender);
                        print(phone);
                        print(prof);
                        print(center);
                        print(interest);
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
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
                                  interest: interest)),
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
