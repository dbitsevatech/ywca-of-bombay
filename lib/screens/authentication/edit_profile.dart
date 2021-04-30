import 'package:flutter/material.dart';

import '../../widgets/blue_bubble_design.dart';
import '../../widgets/constants.dart';
import '../../widgets/gradient_button.dart';

enum GenderChoices { female, male, declineToState }
enum MemberChoices { yes, no, maybe }

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String gender = "Female";
  DateTime dob = new DateTime.now().subtract(Duration(days: 4380));
  String profession;
  String placeOfWork;
  String nearestCenter;
  String interestInMembership = "Yes";

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  MemberChoices _selectedMembershipInterest = MemberChoices.yes;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  GenderChoices selectedGender = GenderChoices.female;
  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
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
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
        // print(picked);
        print(dob);
      });
    }
  }

  @override
  void initState() {
    setState(() {
      selectedGender = GenderChoices.female;
      gender = "Female";
      _selectedMembershipInterest = MemberChoices.yes;
      interestInMembership = "Yes";
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
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: _height * 0.095),
                          child: Text(
                            'EDIT PROFILE',
                            style: TextStyle(
                              fontSize: 35,
                              // color: Color(0xff333333),
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RacingSansOne',
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.0, 5.0),
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
                // Form
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.04,
                    // horizontal: _height * 0.02,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // TODO: Add form field to upload user image
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: secondaryColor,
                            ),
                            labelText: 'First Name',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: secondaryColor,
                            ),
                            labelText: 'Last Name',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: secondaryColor,
                            ),
                            labelText: 'Date of Birth',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _selectDate();
                            dateController.text =
                                "${dob.toLocal()}".split(' ')[0];
                          },
                        ),
                        SizedBox(height: _height * 0.015),
                        TextFormField(
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
                              color: secondaryColor,
                            ),
                            labelText: 'Email Address',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone_android,
                              color: secondaryColor,
                            ),
                            prefixText: '+91 | ',
                            labelText: 'Mobile Number',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                        TextFormField(
                          keyboardType: TextInputType.text,
                          onSaved: (String value) {
                            setState(() {
                              profession = value;
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
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                        SizedBox(
                          height: 10,
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
                            disabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: formFieldFillColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: InputBorder.none,
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
                        SizedBox(
                          height: 10,
                        ),
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
                          height: 55,
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
                        SizedBox(height: 10),
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
                          buttonText: 'Edit Profile',
                          screenHeight: _height,
                          route: 'home',
                          onPressedFunction: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();

                            // TODO: update changes to firebase

                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            'Your Details will be verified by admin and then updated within few days',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'RacingSansOne',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
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
