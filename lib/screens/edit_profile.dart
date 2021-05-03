import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/blue_bubble_design.dart';
import '../widgets/constants.dart';
import '../widgets/gradient_button.dart';
import '../models/user.dart';

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
  DateTime dob;
  String profession;
  String placeOfWork;
  String nearestCenter = "Chembur";
  String interestInMembership = "Yes";
  String uid;
  var userInfo;

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
    userInfo = Provider.of<UserData>(context, listen: false);
    uid = Provider.of<UserData>(context, listen: false).getuid;
    firstName = Provider.of<UserData>(context, listen: false).getfirstName;
    lastName = Provider.of<UserData>(context, listen: false).getlastName;
    email = Provider.of<UserData>(context, listen: false).getemailId;
    phoneNumber = Provider.of<UserData>(context, listen: false).getphoneNumber;
    dob = Provider.of<UserData>(context, listen: false).getdateOfBirth;
    gender = Provider.of<UserData>(context, listen: false).getgender;
    nearestCenter =
        Provider.of<UserData>(context, listen: false).getnearestCenter;
    placeOfWork = Provider.of<UserData>(context, listen: false).getplaceOfWork;
    profession = Provider.of<UserData>(context, listen: false).getprofession;
    interestInMembership =
        Provider.of<UserData>(context, listen: false).getinterestInMembership;
    dateController.text = DateFormat('yyyy-MM-dd')
        .format(Provider.of<UserData>(context, listen: false).getdateOfBirth);
    setState(() {
      if (interestInMembership == 'Yes') {
        _selectedMembershipInterest = MemberChoices.yes;
      } else if (interestInMembership == 'Yes') {
        _selectedMembershipInterest = MemberChoices.no;
      } else {
        _selectedMembershipInterest = MemberChoices.maybe;
      }
      if (gender == 'Female') {
        selectedGender = GenderChoices.female;
      } else if (gender == 'Male') {
        selectedGender = GenderChoices.male;
      } else {
        selectedGender = GenderChoices.declineToState;
      }
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
                        leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
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
                // Form
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.02,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // TODO: Add form field to upload user image
                        TextFormField(
                          initialValue: firstName,
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
                          initialValue: lastName,
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
                          // initialValue: DateFormat('yyyy-MM-dd').format(Provider.of<UserData>(context, listen:false).getdateOfBirth).toString(),
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
                          initialValue:
                              Provider.of<UserData>(context, listen: false)
                                  .getemailId,
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
                          initialValue:
                              Provider.of<UserData>(context, listen: false)
                                  .getprofession,
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
                          initialValue:
                              Provider.of<UserData>(context, listen: false)
                                  .getplaceOfWork,
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
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            // left: _width * 0.262,
                            // right: _width * 0.262,
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
                            onChanged: (String value) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                nearestCenter = value;
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
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
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

                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .update({
                                  "firstName": firstName,
                                  "lastName": lastName,
                                  "dateOfBirth": dob,
                                  "emailId": email,
                                  "gender": gender,
                                  "profession": profession,
                                  "placeOfWork": placeOfWork,
                                  "nearestCenter": nearestCenter,
                                  "interestInMembership": interestInMembership
                                })
                                .then((value) => print("User Updated"))
                                .catchError((error) =>
                                    print("Failed to update user: $error"));
                            await userInfo.updateAfterAuth(
                                uid,
                                firstName,
                                lastName,
                                dob,
                                email,
                                phoneNumber,
                                gender,
                                profession,
                                placeOfWork,
                                nearestCenter,
                                interestInMembership);

                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          height: _height * 0.020,
                        ),
                        Center(
                          child: Text(
                            'Your details will be verified by the admin and then updated within a few days',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Montserrat',
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
