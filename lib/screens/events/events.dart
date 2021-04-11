import './event_details.dart';
import '../../models/Event.dart';

import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

// ignore: must_be_immutable
class Events extends KFDrawerContent {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final List<Event> _allEvents = Event.allEvents();

  @override
  Widget build(BuildContext context) {
    // TODO: Decide whether SafeArea or Scaffold
    // return Scaffold(
    // body: Center
    return SafeArea(
      child: Center(
        child: Stack(
          children: <Widget>[
            // TODO: Decide whether CustomPaint or Image
            // Container(
            //   child: CustomPaint(
            //     painter: OpenPainter(),
            //   ),
            // ),
            Positioned(
              child: Image.asset("assets/images/circle-design.png"),
            ),
            Positioned(
              child: AppBar(
                centerTitle: true,
                title: Text("YWCA Of Bombay",
                    style: new TextStyle(
                        fontFamily: 'LilyScriptOne',
                        fontSize: 18.0,
                        color: Colors.black87)),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: widget.onMenuPressed,
                ),
              ),
            ),
            // Events & Search bar Starts
            PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: new Column(
                children: <Widget>[
                  // Distance from ywca
                  // or else it will overlap
                  SizedBox(height: 80),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        TextSpan(
                            text: 'Events ',
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(Icons.notification_important),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  new TextField(
                    decoration: InputDecoration(
                        hintText: "Search by venue",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.mic,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.transparent),
                  ),
                ],
              ),
            ),
            // card view for the events
            new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
                child: getHomePageBody(context))
          ],
        ),
      ),
    );
  }

  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: _allEvents.length,
      itemBuilder: _getItemUI,
      padding: EdgeInsets.all(0.0),
    );
  }

  // Card view
  Widget _getItemUI(BuildContext context, int index) {
    return new Card(
      elevation: 0,
      child: new Column(
        children: <Widget>[
          new ListTile(
            // Image
            leading: new Image.asset(
              "assets/images/events/" + _allEvents[index].image,
              fit: BoxFit.cover,
              width: 120.0,
            ),
            // Date & Time
            title: new Text(
              _allEvents[index].dateTime,
              style: new TextStyle(
                  color: Color(0xFF49DEE8),
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
            ),
            subtitle: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  new Text(_allEvents[index].name,
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  new Text(
                      'Resource Person: ${_allEvents[index].resourcePerson}',
                      style: new TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.normal)),
                  SizedBox(height: 5),
                  new Text('Venue: ${_allEvents[index].venue}',
                      style: new TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.normal)),
                  SizedBox(height: 5),
                  new Text('Amount: ${_allEvents[index].cost}',
                      style: new TextStyle(
                          fontSize: 11.0, fontWeight: FontWeight.normal)),
                ]),
            //trailing: ,
            onTap: () {
              gotoSecondActivity(context);
            },
          )
        ],
      ),
    );
  }
}

gotoSecondActivity(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailPage()),
  );
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff49DEE8).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    //circles
    canvas.drawCircle(Offset(-5, 45), 100, paint1);
    canvas.drawCircle(Offset(105, 8), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
