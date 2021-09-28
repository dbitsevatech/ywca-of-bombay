import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:vibration/vibration.dart';

import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/gradient_button.dart';

// ignore: must_be_immutable
class AdminNewEvent extends StatefulWidget {
  @override
  _AdminNewEventState createState() => _AdminNewEventState();
}

class _AdminNewEventState extends State<AdminNewEvent> {
  String eventTitle = "";
  String eventDescription = "";
  String eventVenue = "";
  String eventTime = "";
  String eventAmount = "";
  String eventImageUrl = "";
  String eventType = "Everyone";
  // image path variable
  File? _image;
  DateTime eventDate = DateTime.now();
  DateTime eventDeadline = DateTime.now();
  // time
  String? _selectedTime;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _showPickerTime(context) async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'SELECT TIME OF EVENT',
    );
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
      eventTimeController.text = result.format(context);
    }
  }

  Future _selectDate(context) async {
    initializeDateFormatting();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      helpText: 'SELECT DATE OF EVENT',
      fieldLabelText: 'Enter date of Event',
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
    );
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
      });
    }
  }

  Future _selectDeadline(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
      helpText: 'Select Date of Birth',
      fieldLabelText: 'Enter date of birth',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: primaryColor, // highlighed date color
              onPrimary: Colors.black, // highlighted date text color
              surface: primaryColor, // header color
              onSurface: Colors.grey[800]!, // header text & calendar text color
            ),
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
    );
    if (picked != null && picked != eventDeadline) {
      setState(() {
        eventDeadline = picked;
        print(eventDeadline);
      });
    }
  }

  // Image
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery, maxHeight: 2000, maxWidth: 2000);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // displaying image
  Widget _buildImage() {
    // ignore: unnecessary_null_comparison
    if (_image != null) {
      return Image.file(_image!);
    } else {
      return Text('Choose an image to show', style: TextStyle(fontSize: 18.0));
    }
  }

  // uploading image to firebase storage
  Future uploadData(
      BuildContext context,
      eventName,
      eventDescription,
      eventVenue,
      eventAmount,
      eventDate,
      eventDeadline,
      eventTime,
      eventType) async {
    goBackToPreviousScreen(context);
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);

    uploadTask.whenComplete(() {});
    // reference to the firestore of the image
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();
    print("Image URL=" + url);

    FirebaseFirestore.instance.collection('events').add({
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventVenue': eventVenue,
      'eventAmount': eventAmount,
      'eventDate': eventDate,
      'eventImageUrl': url,
      'eventDeadline': eventDeadline,
      'eventTime': eventTime,
      'eventType': eventType,
      'eventClickCount': 0,
      'eventRegisterCount': 0
    }).then((value) => FirebaseFirestore.instance
            .collection('eventsBackup')
            .doc(value.id)
            .set({
          'eventName': eventName,
          'eventDescription': eventDescription,
          'eventVenue': eventVenue,
          'eventAmount': eventAmount,
          'eventDate': eventDate,
          'eventImageUrl': url,
          'eventDeadline': eventDeadline,
          'eventTime': eventTime,
          'eventType': eventType
        }));
  }

  // everyone-0, members-1
  int? _eventTypeRadioValue = 0;
  void _handleEventRadioValueChange(int? value) {
    setState(() {
      _eventTypeRadioValue = value;
      if (_eventTypeRadioValue == 0) {
        eventType = "Everyone";
      } else {
        eventType = "Members only";
      }
      // print("Event is for: $eventType");
    });
  }

  @override
  void initState() {
    Intl.defaultLocale = 'pt_BR';
    setState(() {
      eventType = "Everyone";
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
                  children: <Widget>[
                    MainPageBlueBubbleDesign(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        goBackToPreviousScreen(context);
                      },
                    ),
                    Positioned(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: _height * 0.15),
                          child: Text(
                            'New Event',
                            style: TextStyle(
                              fontSize: 40,
                              color: primaryColor,
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
                  height: _height * 0.025,
                ),
                // choose image
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    horizontal: _width * 0.04,
                  ),
                  child: GradientButton(
                    buttonText: 'Choose file',
                    screenHeight: _height,
                    onPressedFunction: () => captureImage(ImageSource.gallery),
                  ),
                ),
                SizedBox(
                  height: _height * 0.015,
                ),
                // display image
                Center(child: _buildImage()),
                SizedBox(
                  height: _height * 0.015,
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
                        // Event title
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              eventTitle = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Event name is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.star_border,
                              color: secondaryColor,
                            ),
                            labelText: 'Event title',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event description
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              eventDescription = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Event description is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.description_outlined,
                              color: secondaryColor,
                            ),
                            labelText: 'Description',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event venue
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              eventVenue = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Event venue is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.pin_drop_outlined,
                              color: secondaryColor,
                            ),
                            labelText: 'Venue',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Event amount
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              eventAmount = value;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Event amount is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.payments_outlined,
                              color: secondaryColor,
                            ),
                            labelText: 'Amount',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        TextFormField(
                          readOnly: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: dateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Event date is required';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: secondaryColor,
                            ),
                            labelText: 'Event Date',
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
                            await _selectDate(context);
                            dateController.text =
                                "${DateFormat('dd-MM-yyyy', 'en').format(eventDate.toLocal())}"
                                    .split(' ')[0];
                          },
                        ),
                        SizedBox(height: _height * 0.015),
                        // Event Time
                        TextFormField(
                          readOnly: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: eventTimeController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Event time is required';
                            }
                            return null;
                          },
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.alarm,
                              color: secondaryColor,
                            ),
                            labelText: 'Event Time',
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
                            _showPickerTime(context);
                          },
                        ),
                        SizedBox(height: _height * 0.015),
                        //Deadline of Event
                        TextFormField(
                          readOnly: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                          controller: deadlineController,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: secondaryColor,
                            ),
                            labelText: 'Deadline of Event',
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
                            await _selectDeadline(context);
                            deadlineController.text =
                                "${DateFormat('dd-MM-yyyy', 'en').format(eventDeadline.toLocal())}"
                                    .split(' ')[0];
                          },
                        ),
                        SizedBox(height: _height * 0.015),
                        // Event is for
                        Text(
                          'Event is for:',
                          style: TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 0,
                              groupValue: _eventTypeRadioValue,
                              onChanged: _handleEventRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _eventTypeRadioValue = 0;
                                  _handleEventRadioValueChange(
                                      _eventTypeRadioValue);
                                });
                              },
                              child: Text(
                                'Everyone',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value: 1,
                              groupValue: _eventTypeRadioValue,
                              onChanged: _handleEventRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _eventTypeRadioValue = 1;
                                  _handleEventRadioValueChange(
                                      _eventTypeRadioValue);
                                });
                              },
                              child: Text(
                                'Members only',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // end
                        SizedBox(height: _height * 0.015),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: _height * 0.015,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                firstButtonGradientColor,
                                firstButtonGradientColor,
                                secondButtonGradientColor
                              ],
                              begin: FractionalOffset.centerLeft,
                              end: FractionalOffset.centerRight,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: GradientButton(
                            buttonText: 'Submit',
                            screenHeight: _height * 0.4,
                            onPressedFunction: () async {
                              if (!_formKey.currentState!.validate()) {
                                Vibration.vibrate(duration: 100);
                                return;
                              }
                              _formKey.currentState!.save();
                              uploadData(
                                context,
                                eventTitle,
                                eventDescription,
                                eventVenue,
                                eventAmount,
                                eventDate,
                                eventDeadline,
                                _selectedTime,
                                eventType,
                              );
                            },
                          ),
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

goBackToPreviousScreen(BuildContext context) {
  Navigator.pop(context);
}
