class Event {
  //--- Date & Time of the event
  final String dateTime;
  //--- Name Of Event
  final String name;
  //--- person to contact
  final String resourcePerson;
  //--- venue
  final String venue;
  //--- amount
  final String cost;
  //-- image
  final String image;

  Event({
    required this.dateTime,
    required this.name,
    required this.resourcePerson,
    required this.venue,
    required this.cost,
    required this.image,
  });

  static List<Event> allEvents() {
    // List<Event> listOfEvents = List<Event>(); // Deprecated
    // https://stackoverflow.com/questions/65277843/flutter-list-is-deprecated
    List<Event> listOfEvents = [];

    listOfEvents.add(
      Event(
        dateTime: "Date: 19/12/2020 | 11:00 AM",
        name: "Christmas Decor Workshop",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 17/12/2020 | 05:00 PM",
        name: "Creative Christmas",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 27/11/2020 | 11:00 AM",
        name: "General Medical Checkup Camp",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 26/11/2020 | 10:30 AM",
        name: "Online Disaster Management Training",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 19/12/2020 | 11:00 AM",
        name: "Christmas Decor Workshop",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 17/12/2020 | 05:00 PM",
        name: "Creative Christmas",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 27/11/2020 | 11:00 AM",
        name: "General Medical Checkup Camp",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );
    listOfEvents.add(
      Event(
        dateTime: "Date: 26/11/2020 | 10:30 AM",
        name: "Online Disaster Management Training",
        resourcePerson: "Sharon Pires",
        venue: "Online",
        cost: "Free",
        image: "christmas.jpg",
      ),
    );

    return listOfEvents;
  }
}
