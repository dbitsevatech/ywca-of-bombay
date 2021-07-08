import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../widgets/blue_bubble_design.dart';
import 'package:intl/intl.dart';
import '../../../widgets/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// ignore: must_be_immutable
class AdminNewEvent extends StatefulWidget {
  @override
  _AdminNewEventState createState() => _AdminNewEventState();
}

class _AdminNewEventState extends State<AdminNewEvent> {
  late String eventTitle, eventDescription, eventVenue, eventAmount, eventImageUrl;
  String eventType = "Everyone";
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validationgetText

  // choose the image
  late File _image;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateTime eventDate = DateTime.now().subtract(Duration(days: 4380));
  Future _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
      helpText: 'Select Date of Event',
      fieldLabelText: 'Enter date of Event',
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
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
        // print(eventDate);
      });
    }
  }

  // Deadline of Event
  DateTime eventDeadline = DateTime.now().subtract(Duration(days: 4380));

  Future _selectDeadline(context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDeadline,
      firstDate: DateTime(1940),
      lastDate: DateTime.now().subtract(Duration(days: 4380)),
      helpText: 'Select Deadline of Event',
      fieldLabelText: 'Enter Deadline of Event',
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
        // print(eventDeadline);
      });
    }
  }

  // Image
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
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
    if (_image != null) {
      return Image.file(_image);
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
    String fileName = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);

    uploadTask.whenComplete(() {
      // print("uploaded");
    });
    // reference to the firestore of the image
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();
    // print("Image URL=" + url);

    // print("Creating record on firestore");
    // print("time");
    // print(eventTime);

    TimeOfDay selectedTime = eventTime;
    final now = DateTime.now();
    DateTime newTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    final document = FirebaseFirestore.instance.collection('events').add({
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventVenue': eventVenue,
      'eventAmount': eventAmount,
      'eventImageUrl': url,
      'eventDate': eventDate,
      'eventDeadline': eventDeadline,
      'eventTime': newTime,
      'eventType': eventType
    }).then((value) =>
        // print(value.id)
        FirebaseFirestore.instance
            .collection('eventsBackup')
            .doc(value.id)
            .set({
          // 'eventID' : value.id,
          'eventName': eventName,
          'eventImageUrl': url,
          'eventDate': eventDate,
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
    setState(() {
      eventType = "Everyone";
    });
    super.initState();
  }

  // Time picker
  TimeOfDay? eventTime;

  String getText() {
    if (eventTime == null) {
      return 'Select Time';
    } else {
      final hours = eventTime!.hour.toString().padLeft(2, '0');
      final minutes = eventTime!.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
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
                        //do something
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
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: TextButton(
                      child: Text(
                        'Choose File',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => captureImage(ImageSource.gallery),
                    ),
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
                          validator: (String? value) {
                            if (value == null)
                              return 'Event name is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
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
                          validator: (String? value) {
                            if (value == null)
                              return 'Event description is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
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
                          validator: (String? value) {
                            if (value == null)
                              return 'Event venue is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
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
                          validator: (String? value) {
                            if (value == null)
                              return 'Event amount is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
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

                        //Date of Event
                        TextFormField(
                          onChanged: (value) {
                            setState(() {});
                          },
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
                            labelText: 'Date of Event',
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
                                "${DateFormat('dd-MM-yyyy').format(eventDate.toLocal())}"
                                    .split(' ')[0];
                          },
                        ),
                        SizedBox(height: _height * 0.015),

                        // Time
                        TextFormField(
                          controller: timeController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.timer,
                              color: secondaryColor,
                            ),
                            labelText: getText(),
                          ),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                          ),
                          onTap: () async {
                            // pickTime(context);
                            final initialTime = TimeOfDay(hour: 9, minute: 0);
                            final newTime = await showTimePicker(
                              context: context,
                              initialTime: eventTime ?? initialTime,
                            );

                            if (newTime == null) return;
                            setState(() => eventTime = newTime);
                          },
                        ),

                        SizedBox(height: _height * 0.015),
                        //Deadline of Event
                        TextFormField(
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
                            await _selectDate(context);
                            deadlineController.text =
                                "${DateFormat('dd-MM-yyyy').format(eventDeadline.toLocal())}"
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
                          child: FractionallySizedBox(
                            widthFactor: 1,
                            child: TextButton(
                              child: Text(
                                'Upload',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                uploadData(
                                    context,
                                    eventTitle,
                                    eventDescription,
                                    eventVenue,
                                    eventAmount,
                                    eventDate,
                                    eventDeadline,
                                    eventTime,
                                    eventType);
                                goBackToPreviousScreen(context);
                              },
                            ),
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
