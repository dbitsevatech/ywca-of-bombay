import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../widgets/blue_bubble_design.dart';
// import 'adminAddNewEvent.dart';
import 'package:intl/intl.dart';

class AdminEventDetailPage extends StatefulWidget {
  String id,
      eventAmount,
      eventDescription,
      eventName,
      eventImageUrl,
      eventVenue,
      eventType;
  DateTime eventDate, eventDeadline;
  Timestamp eventTime;

  AdminEventDetailPage(
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
  _AdminEventDetailPageState createState() => _AdminEventDetailPageState();
}

class _AdminEventDetailPageState extends State<AdminEventDetailPage> {
  int _currentIndex = 0;

  // carousel images
  final List<String> imagesList = [
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80',
  ];

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
    Timestamp eventTime = widget.eventTime;

  // event date
  String formattedEventDate = DateFormat('dd-MM-yyyy').format(eventDate);

// event deadline
  String formattedDeadlineDate = DateFormat('dd-MM-yyyy').format(eventDeadline);

// event time
  DateTime newEventTime = eventTime.toDate();
  String formattedEventTime = DateFormat('kk:mm:a').format(newEventTime);

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
      // event_deadline = widget.event_deadline;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 300),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              //do something
              goBackToPreviousScreen(context);
            },
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {
              //do something
              // gotoSecondActivity(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            // color: Colors.orange,
            padding: EdgeInsets.only(top: _height * 0.005, left: _height * 0.3),
            child: RaisedButton(
              onPressed: () {
                gotoSecondActivity(context);
              },
              color: Color(0xFF00bbe4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Member",
                style: new TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ),
          DetailPageBlueBubbleDesign(),
          // Carousel
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentIndex = index;
                  },
                );
              },
            ),
            items: imagesList
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      elevation: 6.0,
                      shadowColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imagesList.map((urlOfItem) {
              int index = imagesList.indexOf(urlOfItem);
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Color.fromRGBO(0, 0, 0, 0.8)
                      : Color.fromRGBO(0, 0, 0, 0.3),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: _height * 0.025),
          SizedBox(height: _height * 0.025),
          //title
          Stack(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.005, left: _height * 0.04),
                child: Text(
                  eventName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              // description
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.06, left: _height * 0.04),
                child: Text(
                  eventDescription,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
              // resource person
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.20, left: _height * 0.04),
                child: Text(
                  eventName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
              // venue
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.25, left: _height * 0.04),
                child: Text(
                  eventVenue,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
              //amount
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.30, left: _height * 0.04),
                child: Text(
                  eventAmount,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
              // date
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.35, left: _height * 0.04),
                child: Text(
                  "Date :"+formattedEventDate,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
              // time
              Container(
                padding:
                    EdgeInsets.only(top: _height * 0.40, left: _height * 0.04),
                child: Text(
                  "Time : "+formattedEventTime,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff000000),
                    fontFamily: 'Montserrat_Light',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

goBackToPreviousScreen(BuildContext context) {
  Navigator.pop(context);
}

gotoSecondActivity(BuildContext context) {
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => AdminAddNewEvent()),
  // );
}