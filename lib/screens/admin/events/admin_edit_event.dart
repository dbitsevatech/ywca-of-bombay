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
import 'admin_events.dart';

// ignore: must_be_immutable
class AdminEditEvent extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue,
      eventType;
  DateTime eventDate, eventDeadline, eventTime;

  AdminEditEvent(
      {this.id,
      this.eventAmount,
      this.eventDescription,
      this.eventName,
      this.eventImageUrl,
      this.eventVenue,
      this.eventType,
      this.eventDate,
      this.eventDeadline,
      this.eventTime});

  @override
  _AdminEditEventState createState() => _AdminEditEventState();
}

class _AdminEditEventState extends State<AdminEditEvent> {
  CollectionReference collectionUser =
      FirebaseFirestore.instance.collection('events');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _formkey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  String member = "Everyone";

  // choosing the image
  File _image;

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
      return Text('Choose a image to show', style: TextStyle(fontSize: 18.0));
    }
  }

  TimeOfDay time;

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minutes = time.minute.toString().padLeft(2, '0');

      return '$hours:$minutes';
    }
  }

  // everyone-0, members-1
  int _memberRadioValue = 0;
  void _handleEventRadioValueChange(int value) {
    setState(() {
      _memberRadioValue = value;
      if (_memberRadioValue == 0) {
        member = "Everyone";
      } else {
        member = "Members only";
      }
      print("Event is for: $member");
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // fetching the values
    String id = widget.id,
        eventAmount = widget.eventAmount,
        eventDescription = widget.eventDescription,
        eventName = widget.eventName,
        eventImageUrl = widget.eventImageUrl,
        eventVenue = widget.eventVenue,
        eventType = widget.eventType;
    DateTime eventDate = widget.eventDate;
    DateTime eventDeadline = widget.eventDeadline;
    DateTime eventTime = widget.eventTime;

    //Time
    TextEditingController timeController = TextEditingController();

    // dateTime variable
    String newEventTime = eventTime.toString();
    TimeOfDay timesEvent =
        TimeOfDay.fromDateTime(DateTime.parse(newEventTime)); // 4:30pm
    print('printing time');
    print(timesEvent);

    print("event date");
    print(eventDate);
    print('event deadline');
    print(eventDeadline);

    @override
    void initState() {
      super.initState();
      id = widget.id;
      eventName = widget.eventName;
      eventAmount = widget.eventAmount;
      eventDescription = widget.eventDescription;
      eventVenue = widget.eventVenue;
      eventImageUrl = widget.eventImageUrl;
      eventDate = widget.eventDate;
      eventType = widget.eventType;
      eventDeadline = widget.eventDeadline;
      eventTime = widget.eventTime;
    }

    // date of event
    DateTime dateOfEvent = eventDate;
    Future _selectDate(context) async {
      final DateTime pickedEvent = await showDatePicker(
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
                onSurface:
                    Colors.grey[800], // header text & calendar text color
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
      if (pickedEvent != null && pickedEvent != dateOfEvent) {
        setState(() {
          dateOfEvent = pickedEvent;
          print(dateOfEvent);
        });
      }
    }

    // Deadline of Event
    DateTime deadlineOfEvent = eventDeadline;

    Future _selectDeadline(context) async {
      final DateTime pickedDeadline = await showDatePicker(
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
                onSurface:
                    Colors.grey[800], // header text & calendar text color
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
      if (pickedDeadline != null && pickedDeadline != deadlineOfEvent) {
        setState(() {
          deadlineOfEvent = pickedDeadline;
          print(deadlineOfEvent);
        });
      }
    }

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
                            'Edit Event',
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
                // Old image
                Text(
                  'Old Image',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RacingSansOne',
                  ),
                ),
                Image.network(
                  eventImageUrl,
                  fit: BoxFit.cover,
                  width: 120.0,
                ),
                // selected image
                Text(
                  'New Image',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RacingSansOne',
                  ),
                ),
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
                          initialValue: eventName,
                          onChanged: (value) {
                            eventName = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty)
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
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Description
                        TextFormField(
                          initialValue: eventDescription,
                          onChanged: (value) {
                            eventDescription = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Event description is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Event description',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Venue
                        TextFormField(
                          initialValue: eventVenue,
                          onChanged: (value) {
                            eventVenue = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Event venue is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Event venue',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Amount
                        TextFormField(
                          initialValue: eventAmount,
                          onChanged: (value) {
                            eventAmount = value;
                          },
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Event amount is required';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Event amount',
                            filled: true,
                            fillColor: formFieldFillColor,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
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
                                "${DateFormat('dd-MM-yyyy').format(dateOfEvent.toLocal())}"
                                    .split(' ')[0];
                          },
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        //Time
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
                            final initialTime = TimeOfDay(hour: 9, minute: 0);
                            final newTime = await showTimePicker(
                              context: context,
                              initialTime: time ?? initialTime,
                            );

                            if (newTime == null) return;
                            setState(() => time = newTime);
                          },
                          // onClicked: () => pickTime(context),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        // Deadline
                        TextFormField(
                          // keyboardType: TextInputType.datetime,
                          onChanged: (value) {
                            setState(() {
                              // dateOfEvent = DateTime.parse(value);
                              // dateOfEvent\ = value;
                            });
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
                                "${DateFormat('dd-MM-yyyy').format(deadlineOfEvent.toLocal())}"
                                    .split(' ')[0];
                          },
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),

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
                              groupValue: _memberRadioValue,
                              onChanged: _handleEventRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _memberRadioValue = 0;
                                  _handleEventRadioValueChange(
                                      _memberRadioValue);
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
                              groupValue: _memberRadioValue,
                              onChanged: _handleEventRadioValueChange,
                              focusColor: secondaryColor,
                              hoverColor: secondaryColor,
                              activeColor: secondaryColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _memberRadioValue = 1;
                                  _handleEventRadioValueChange(
                                      _memberRadioValue);
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

                        SizedBox(
                          height: _height * 0.015,
                        ),

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
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                print("title");
                                print(eventName);
                                updateData(
                                    context,
                                    id,
                                    eventName,
                                    eventDescription,
                                    eventVenue,
                                    eventAmount,
                                    dateOfEvent,
                                    deadlineOfEvent,
                                    time,
                                    member);
                                gotoLastScreen(context);
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

  // Updating to firebase
  Future updateData(
      BuildContext context,
      id,
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
      print("uploaded");
    });
    // reference to the firestore of the image
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();
    print("Image URL=" + url);

    print('event_name');
    print(eventName);
    print('event time');
    print(eventDate);
    print('event deadline');
    print(eventDeadline);
    TimeOfDay selectedTime = eventTime;
    final now = DateTime.now();
    DateTime newTime = DateTime(
        now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);

    print("Updating record on firestore");
    FirebaseFirestore.instance.collection('events').doc(id).update({
      'eventName': eventName,
      'eventDescription': eventDescription,
      'eventVenue': eventVenue,
      'eventAmount': eventAmount,
      'eventDate': eventDate,
      'eventImageUrl': url,
      'eventTime': newTime,
      'eventDeadline': eventDeadline,
      'eventType': eventType
    });
    print("updated on firestore");

    //   this.setState(() {
    //     Navigator.pop(context);
    //   });
  }
}

gotoLastScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AdminEvents()),
  );
}

goBackToPreviousScreen(BuildContext context) {
  Navigator.pop(context);
}
