// TODO: Event image change and time display for edit event

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/gradient_button.dart';
import 'admin_edit_event_image.dart';

// ignore: must_be_immutable
class EditEventScreen extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue;
  String eventType;
  DateTime eventDate, eventDeadline, eventTime;
  // Timestamp eventTime;

  EditEventScreen(
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
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue;
  String eventType = "Everyone";
  DateTime eventDate, eventDeadline, eventTime;
  // Timestamp eventTime;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  // everyone-0, members only-1
  int _eventTypeRadioValue;
  void _handleEventTyptRadioValueChange(int value) {
    setState(() {
      _eventTypeRadioValue = value;
      if (_eventTypeRadioValue == 0) {
        eventType = "Everyone";
      } else {
        eventType = "Members only";
      }
      print("eventType selected: $eventType");
    });
  }

  DateTime selectedDateOfEvent = DateTime.now();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDateOfDeadline = DateTime.now();
  TextEditingController deadlineController = TextEditingController();

  //Time
  TextEditingController timeController = TextEditingController();

  Future _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
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
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
        // print(picked);
        print(eventDate);
      });
    }
  }

  Future _selectDeadline() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: eventDeadline,
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
    if (picked != null && picked != eventDeadline) {
      setState(() {
        eventDeadline = picked;
        // print(picked);
        print(eventDeadline);
      });
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

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to exit without saving changes?'),
            content:
                Text('Please press the SAVE button at the bottom of the page'),
            actions: <Widget>[
              TextButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text('YES'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<bool> savePressed() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Your request to change information has been successfully sent!'),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    id = widget.id;
    eventName = widget.eventName;
    eventAmount = widget.eventAmount;
    eventDescription = widget.eventDescription;
    eventVenue = widget.eventVenue;
    eventImageUrl = widget.eventImageUrl;
    eventDate = widget.eventDate;
    eventTime = widget.eventTime;
    eventType = widget.eventType;
    eventDeadline = widget.eventDeadline;
    if (eventType == "Members only") {
      _eventTypeRadioValue = 1;
    } else if (eventType == "Everyone") {
      _eventTypeRadioValue = 0;
    }
    dateController.text = DateFormat('dd-MM-yyyy').format(widget.eventDate);

    deadlineController.text =
        DateFormat('dd-MM-yyyy').format(widget.eventDeadline);

    super.initState();
  }

  final int height = 1;
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    // dateTime variable
    // String newEventTime = eventTime.toString();
    // TimeOfDay timesEvent =
    //     TimeOfDay.fromDateTime(DateTime.parse(newEventTime)); // 4:30pm
    // print('printing time');
    // print(timesEvent);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldkey,
        // body:WillPopScope(
        //   onWillPop: _onBackPressed,
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
                              fontFamily: 'LobsterTwo',
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
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
                            onPressed: () {
                              _onBackPressed();
                            },
                            // onPressed: () => Navigator.of(context).pop(true),
                            // onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: _height * 0.095),
                            child: Text(
                              'EDIT EVENT',
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
                  Image.network(
                    eventImageUrl,
                    fit: BoxFit.cover,
                    width: 120.0,
                  ),
                  SizedBox(height: 20),
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
                            'Edit Image',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            bool result = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Confirmation'),
                                  content: Text(
                                      'Are you sure you want to edit this image?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(
                                            false); // dismisses only the dialog and returns false
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop(true);
                                        goToEditEventImage(
                                            context, id, eventImageUrl);
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                            // goToEditEventImage(
                            //   context,
                            //   id,
                            //   eventImageUrl),
                          }
                          // captureImage(ImageSource.gallery),
                          ),
                    ),
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
                          // Event Name
                          TextFormField(
                            initialValue: eventName,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                eventName = value;
                              });
                            },
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Event name is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(
                              //   Icons.account_circle,
                              //   color: secondaryColor,
                              // ),
                              labelText: 'Event Name',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          // Event Description
                          TextFormField(
                            initialValue: eventDescription,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                eventDescription = value;
                              });
                            },
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Event Description is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(
                              //   Icons.account_circle,
                              //   color: secondaryColor,
                              // ),
                              labelText: 'Event Description',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          // Event Venue
                          TextFormField(
                            initialValue: eventVenue,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                eventVenue = value;
                              });
                            },
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Event Venue is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(
                              //   Icons.account_circle,
                              //   color: secondaryColor,
                              // ),
                              labelText: 'Event Venue',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          // Event Amount
                          TextFormField(
                            initialValue: eventAmount,
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              setState(() {
                                eventAmount = value;
                              });
                            },
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Event Amount is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
                              // prefixIcon: Icon(
                              //   Icons.account_circle,
                              //   color: secondaryColor,
                              // ),
                              labelText: 'Event Amount',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: _height * 0.015),
                          // Date of event
                          TextFormField(
                            // initialValue: DateFormat('yyyy-MM-dd').format(Provider.of<UserData>(context, listen:false).getdateOfBirth).toString(),
                            // keyboardType: TextInputType.datetime,
                            onChanged: (value) {
                              setState(() {
                                // dateOfEvent = DateTime.parse(value);
                                // dateOfEvent\ = value;
                              });
                            },
                            controller: dateController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: secondaryColor,
                              ),
                              labelText: 'Date of Event',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _selectDate();
                              dateController.text =
                                  "${eventDate.toLocal()}".split(' ')[0];
                            },
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
                            // initialValue: ,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                            ),
                            onTap: () async {
                              // print('time of event');
                              // print(eventTime);
                              // timeController.text = "${eventTime.toLocal()}".split(' ')[1];
                              // print(timeController.text);
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

                          SizedBox(height: _height * 0.015),
                          // Deadline to register
                          TextFormField(
                            // initialValue: DateFormat('yyyy-MM-dd').format(Provider.of<UserData>(context, listen:false).getdateOfBirth).toString(),
                            // keyboardType: TextInputType.datetime,
                            onChanged: (value) {
                              setState(() {
                                // dateOfEvent = DateTime.parse(value);
                                // dateOfEvent\ = value;
                              });
                            },
                            controller: deadlineController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.date_range,
                                color: secondaryColor,
                              ),
                              labelText: 'Deadline to register',
                              filled: true,
                              fillColor: formFieldFillColor,
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: formFieldFillColor),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              errorBorder: InputBorder.none,
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await _selectDeadline();
                              deadlineController.text =
                                  "${eventDeadline.toLocal()}".split(' ')[0];
                            },
                          ),
                          SizedBox(height: _height * 0.015),
                          Text(
                            'Event Type',
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
                                groupValue: _eventTypeRadioValue,
                                onChanged: _handleEventTyptRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _eventTypeRadioValue = 0;
                                    _handleEventTyptRadioValueChange(
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
                              Radio(
                                value: 1,
                                groupValue: _eventTypeRadioValue,
                                onChanged: _handleEventTyptRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _eventTypeRadioValue = 1;
                                    _handleEventTyptRadioValueChange(
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
                          SizedBox(
                            height: 10,
                          ),
                          GradientButton(
                            buttonText: 'Update Event',
                            screenHeight: _height,
                            route: 'home',
                            onPressedFunction: () async {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              bool result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text(
                                        'Are you sure you want to save the changes?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).pop(
                                              false); // dismisses only the dialog and returns false
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(true);
                                          print("Updating record on firestore");
                                          FirebaseFirestore.instance
                                              .collection('events')
                                              .doc(id)
                                              .update({
                                            'eventName': eventName,
                                            'eventDescription':
                                                eventDescription,
                                            'eventVenue': eventVenue,
                                            'eventAmount': eventAmount,
                                            'eventDate': eventDate,
                                            // 'eventImageUrl': url,
                                            // 'eventTime': newTime,
                                            'eventDeadline': eventDeadline,
                                            'eventType': eventType
                                          });
                                          print("updated on firestore");
                                          Navigator.pop(context);
                                          // Navigator.pop(context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              // print("Updating record on firestore");
                              // FirebaseFirestore.instance
                              //     .collection('events')
                              //     .doc(id)
                              //     .update({
                              //   'eventName': eventName,
                              //   'eventDescription': eventDescription,
                              //   'eventVenue': eventVenue,
                              //   'eventAmount': eventAmount,
                              //   'eventDate': eventDate,
                              //   // 'eventImageUrl': url,
                              //   // 'eventTime': newTime,
                              //   'eventDeadline': eventDeadline,
                              //   'eventType': eventType
                              // });
                              // print("updated on firestore");
                              // Navigator.pop(context);
                              // Navigator.pop(context);
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
      ),
    );
  }
}

goToEditEventImage(BuildContext context, String id, String eventImageUrl) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => AdminEditEventImage(
              id: id,
              eventImageUrl: eventImageUrl,
            )),
  );
}
