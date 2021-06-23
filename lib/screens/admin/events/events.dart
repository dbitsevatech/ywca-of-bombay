import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';

import 'event_details.dart';
import '../../../models/Event.dart';
import '../../../widgets/constants.dart';
import '../../../widgets/blue_bubble_design.dart';

// ignore: must_be_immutable
class AdminEvents extends KFDrawerContent {
  @override
  _AdminEventsState createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  final List<Event> _allEvents = Event.allEvents();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Stack(
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
                    Icons.menu,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: widget.onMenuPressed,
                ),
              ),
            ),
            // Events & Search bar Starts
            PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Column(
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
                          style: TextStyle(
                            fontSize: 28,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.notification_important,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
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
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            // card view for the events
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 160.0, 0.0, 0.0),
              child: getHomePageBody(context),
            ),
            // ElevatedButton.icon(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     // backgroundColor: MaterialStateProperty.all(secondaryColor),
            //     primary: secondaryColor,
            //     onPrimary: Colors.black87,
            //     // padding: MaterialStateProperty.all(EdgeInsets.all(5)),
            //     shape: RoundedRectangleBorder(
                       //       borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //     ),
            //     // textStyle: MaterialStateProperty.all(
            //     //   TextStyle(fontSize: 30),
            //     // ),
            //   ),
            //   icon: Icon(Icons.add),
            //   label: Text("Add Event"),
            // )
            // Padding(
            //   padding: EdgeInsets.fromLTRB(200.0, 650.0, 0.0, 0.0),
            //   child:
            Column(
              children: [
                Spacer(flex: 20),
                Row(
                  children: [
                    Spacer(flex: 15),
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed))
                            return secondaryColor.withOpacity(0.90);
                          return firstButtonGradientColor;
                        }),
                        foregroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          // if (states.contains(MaterialState.pressed))
                          //   return Colors.black45;
                          return null;
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      icon: Icon(Icons.add),
                      label: Text(
                        "New Event",
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
              ],
            ),
            // ),
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
    return Card(
      elevation: 0,
      child: ListTile(
        // Image
        leading: Image.asset(
          "assets/images/events/" + _allEvents[index].image,
          fit: BoxFit.cover,
          width: 120.0,
        ),
        // Date & Time
        title: Text(
          _allEvents[index].dateTime,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5),
            Text(
              _allEvents[index].name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Resource Person: ${_allEvents[index].resourcePerson}',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Venue: ${_allEvents[index].venue}',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Amount: ${_allEvents[index].cost}',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Spacer(),
                Spacer(),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                    // textStyle: MaterialStateProperty.all(
                    //   TextStyle(fontSize: 20),
                    // ),
                  ),
                  child: Icon(
                    Icons.edit,
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                    // textStyle: MaterialStateProperty.all(
                    //   TextStyle(fontSize: 30),
                    // ),
                  ),
                  child: Icon(
                    Icons.delete,
                  ),
                ),
                // ElevatedButton.icon(
                //   onPressed: () {},
                //   icon: Icon(Icons.edit),
                //   label: Text(""),
                // ),
              ],
            ),
          ],
        ),
        // trailing: Icon(Icons.more_vert),
        onTap: () {
          gotoSecondActivity(context);
        },
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
