import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/gradient_button.dart';
import 'admin_edit_event_image.dart';
import 'package:date_time_picker/date_time_picker.dart';

// ignore: must_be_immutable
class EditEventScreen extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue;
  String eventType;
  DateTime eventDate, eventDeadline;
  String eventTime;

  EditEventScreen({
    required this.id,
    required this.eventAmount,
    required this.eventDescription,
    required this.eventName,
    required this.eventImageUrl,
    required this.eventVenue,
    required this.eventType,
    required this.eventDate,
    required this.eventDeadline,
    required this.eventTime,
  });
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String id = '';
  String eventAmount = '';
  String eventDescription = '';
  String eventName = '';
  String eventImageUrl = '';
  String eventVenue = '';
  String eventType = "Everyone";
  late DateTime eventDate, eventDeadline;
  String eventTime = '';

  // Variables for TimePicker
  String _valueChanged4 = '';
  String _valueToValidate4 = '';
  String _valueSaved4 = '';
  late TextEditingController _controller4;
  TextEditingController timeController = TextEditingController();

  // Variables for Date of event and Deadline
  DateTime selectedDateOfEvent = DateTime.now();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDateOfDeadline = DateTime.now();
  TextEditingController deadlineController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // form key for validation

  final GlobalKey<ScaffoldState> _scaffoldkey =
      GlobalKey<ScaffoldState>(); // scaffold key for snack bar

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        //_initialValue = '2000-10-22 14:30';
        _controller4.text = '17:01';
      });
    });
  }

  // everyone-0, members only-1
  int? _eventTypeRadioValue = 0;
  void _handleEventTypeRadioValueChange(int? value) {
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

  Future _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime(1940),
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
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
        // print(picked);
        print(eventDate);
      });
    }
  }

  Future _selectDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDeadline,
      firstDate: DateTime(1940),
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
        // print(picked);
        print(eventDeadline);
      });
    }
  }

  Future<bool?> _onBackPressed() async {
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

  Future<bool?> savePressed() {
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

    return WillPopScope(
      onWillPop: () async {
        bool? result = await _onBackPressed();
        if (result == null) {
          result = false;
        }
        return result;
      },
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
                  // Displaying event image
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
                            // Edit event image alertbox
                             await showDialog(
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
                          }),
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
                                eventName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null)
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
                                eventDescription = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null)
                                return 'Event Description is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
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
                                eventVenue = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null)
                                return 'Event Venue is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
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
                                eventAmount = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null)
                                return 'Event Amount is required.';
                              else
                                return null;
                            },
                            decoration: InputDecoration(
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
                            onChanged: (value) {
                              setState(() {});
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
                          DateTimePicker(
                            type: DateTimePickerType.time,
                            timePickerEntryModeInput: true,
                            // controller: _controller4,
                            initialValue: eventTime, //_initialValue,
                            icon: Icon(Icons.access_time),
                            timeLabelText: "Select Time",
                            use24HourFormat: true,
                            locale: Locale('pt', 'BR'),
                            onChanged: (val) =>
                                setState(() => _valueChanged4 = val),
                            validator: (val) {
                              setState(() => _valueToValidate4 = val ?? '');
                              return null;
                            },
                            onSaved: (val) =>
                                setState(() => _valueSaved4 = val ?? ''),
                          ),

                          SizedBox(height: _height * 0.015),
                          // Deadline to register
                          TextFormField(
                            onChanged: (value) {
                              setState(() {});
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
                          // Event Type
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
                                onChanged: _handleEventTypeRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _eventTypeRadioValue = 0;
                                    _handleEventTypeRadioValueChange(
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
                                onChanged: _handleEventTypeRadioValueChange,
                                focusColor: secondaryColor,
                                hoverColor: secondaryColor,
                                activeColor: secondaryColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _eventTypeRadioValue = 1;
                                    _handleEventTypeRadioValueChange(
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
                          // Update event button
                          GradientButton(
                            buttonText: 'Update Event',
                            screenHeight: _height,
                            onPressedFunction: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _formKey.currentState!.save();
                               await showDialog(
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
                                          // updating the event after changes if yes pressed
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
                                            'eventTime': _valueChanged4,
                                            'eventDeadline': eventDeadline,
                                            'eventType': eventType
                                          });
                                          print("updated on firestore");
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
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
