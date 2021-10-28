import 'package:flutter/material.dart';

class Initiative {
  // FOR INITIATIVES LIST PAGE
  //--- Name Of Initiative
  final String name;
  //--- image path for card image
  final String image;
  //--- card color
  final Color color;

  // FOR INITIATIVE DETAILS PAGE
  //--- Title of Initiative
  final String title;
  //--- Description of initiative
  final String description;
  //--- List of image paths for Initiative
  final List<String> imagePathList;
  //--- List of image titles for Initiative
  final List<String> imageTitleList;

  Initiative({
    required this.name,
    required this.image,
    required this.color,
    required this.title,
    required this.description,
    required this.imagePathList,
    required this.imageTitleList,
  });

  static List<Initiative> allInitiatives() {
    List<Initiative> listOfInitiatives = [];

    listOfInitiatives.add(
      Initiative(
        name: "PIYA",
        image: 'assets/images/initiatives/piya/1-walk-for-freedom.jpeg',
        // color: Colors.blue[700],
        color: Colors.blue[700]!,
        title: "PIYA - Participation and involvement of youth in action",
        description:
            "Participation and Involvement of Youth in Action (PIYA) is committed to advocate for women’s rights, through the active participation and involvement of a diverse group of young women between the age of 18 to 30 years, who are potential leaders and are committed to social action and transformation of society.",
        imagePathList: [
          'assets/images/initiatives/piya/1-walk-for-freedom.jpeg',
          'assets/images/initiatives/piya/2-walkathon.jpg',
          'assets/images/initiatives/piya/3-a-trek-to-kaldurg-fort.jpg',
          'assets/images/initiatives/piya/4-interschool-competition.jpeg',
          'assets/images/initiatives/piya/5-dance-therapy-by-piya.jpeg',
          'assets/images/initiatives/piya/6-piya.jpeg',
        ],
        imageTitleList: [
          "Walk for freedom",
          "Walkathon",
          "A trek to Kaldurg Fort",
          "Interschool competition",
          "Dance Therapy by PIYA",
          "PIYA",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Asha Kiran Guest House",
        image: "assets/images/initiatives/asha_kiran/1-annual-day.jpg",
        color: Colors.yellow[700]!,
        title: "Asha Kiran Guest House",
        description:
            "Asha Kiran, the women’s development complex at Andheri continues to be a ray of hope to all its beneficiaries. It is dedicated to the all-round development of women and children of different backgrounds, age group, cultures, castes and creeds. It caters to the rapidly changing needs by providing a home away from home for Senior Citizens and Guests, to organizing awareness programmes, vocational courses, study centers, a day care center for senior citizens from the community, a crèche for children of domestic workers, and a shelter for women in distress. It also has an Amphitheatre and a hall facility.",
        imagePathList: [
          'assets/images/initiatives/asha_kiran/1-annual-day.jpg',
          'assets/images/initiatives/asha_kiran/2-sports-day.jpg',
          'assets/images/initiatives/asha_kiran/3-training-of-puppeteers.png',
          'assets/images/initiatives/asha_kiran/4-workshop-on-muslim-legal-rights.png',
          'assets/images/initiatives/asha_kiran/5-cartoon-making-workshop.png',
          'assets/images/initiatives/asha_kiran/6-self-defence-training.jpg',
          'assets/images/initiatives/asha_kiran/7-annual-day-celebration.jpeg',
        ],
        imageTitleList: [
          "Annual Day",
          "Sports Day",
          "Training of Puppeteers",
          "Workshop on Muslim Legal Rights",
          "Cartoon Making Workshop",
          "Self Defence Training",
          "Annual Day Celebration",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "PASI",
        image:
            "assets/images/initiatives/pasi/1-panel-discussion-on-women-and-social-media.jpg",
        color: Colors.red[700]!,
        title: "PASI - Public Affairs and Social Issues",
        description:
            "Public Affairs and Social Issues (PASI) creates an impact both within and outside YWCA by organizing different programmes on current social issues, impacting lives of people in different spheres of life. It also networks with other like-minded organisations to gain strength to address issues that need advocacy.",
        imagePathList: [
          'assets/images/initiatives/pasi/1-panel-discussion-on-women-and-social-media.jpg',
          'assets/images/initiatives/pasi/2-paralegal-training.png',
          'assets/images/initiatives/pasi/3-session-on-rti.jpg',
          'assets/images/initiatives/pasi/4-life-and-struggle-of-transgender.png',
          'assets/images/initiatives/pasi/5-childrens-day-celebration.jpg',
        ],
        imageTitleList: [
          "Panel Discussion on Women and Social Media",
          "Paralegal training",
          "Session on RTI",
          "Life and Struggle of Transgender",
          "Children's Day Celebration"
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "WDU",
        image:
            "assets/images/initiatives/wdu/1-nutritious-food-competition.jpeg",
        color: Colors.green[700]!,
        title: "WDU - Women’s Development Unit",
        description:
            "Women’s Development Unit (WDU) promotes all round well-being of women and children. This is achieved through community development programs, vocational training courses, sustainability projects, capacity building activities and awareness programs. Aasra is a family counseling center which supports women in need.",
        imagePathList: [
          'assets/images/initiatives/wdu/1-nutritious-food-competition.jpeg',
          'assets/images/initiatives/wdu/2-childrens-programme.jpeg',
          'assets/images/initiatives/wdu/3-bakery-certificate-competition.jpeg',
          'assets/images/initiatives/wdu/4-debate-competition.png',
          'assets/images/initiatives/wdu/5-bakery-practical.jpg',
          'assets/images/initiatives/wdu/6-rally-on-human-rights-awareness.jpg',
          'assets/images/initiatives/wdu/7-annual-sports-day.jpg',
          'assets/images/initiatives/wdu/8-bunny-tamtola.jpg',
          'assets/images/initiatives/wdu/9-peace-march.jpg',
          'assets/images/initiatives/wdu/10-childrens-camp.jpeg',
          'assets/images/initiatives/wdu/11-disaster-management-training.jpeg',
          'assets/images/initiatives/wdu/12-anand-mela.jpeg',
        ],
        imageTitleList: [
          "Nutritious food Competition",
          "Children's Programme ",
          "Bakery certificate distribution",
          "Debate Competition",
          "Bakery Practical",
          "Rally on Human Rights Awareness",
          "Annual Sports Day Celebration",
          "Bunny Tamtola",
          "Peace March",
          "Children's Camp",
          "Disaster Management Training",
          "Anand Mela",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "YWCA Hostels",
        image: "assets/images/initiatives/ywca_hostels/1-abh-in-night.jpg",
        color: Colors.deepOrange,
        title: "YWCA Hostels",
        description:
            "YWCA Hostels - Achamma Bhavan, Anugraha, Dipti Dhaman and Lady Willingdon is the bench mark in Mumbai/ Navi Mumbai for hygienic, well equipped and disciplined hostels. It provides a safe and secure surrounding to women who are new to the city.",
        imagePathList: [
          'assets/images/initiatives/ywca_hostels/1-abh-in-night.jpg',
          'assets/images/initiatives/ywca_hostels/2-ddh.jpg',
          'assets/images/initiatives/ywca_hostels/3-national-festival-celebration.jpg',
          'assets/images/initiatives/ywca_hostels/4-dining-room-lwh.png',
          'assets/images/initiatives/ywca_hostels/5-ddh-lounge.jpg',
          'assets/images/initiatives/ywca_hostels/6-lwh-building.jpeg',
        ],
        imageTitleList: [
          "ABH In-night",
          "DDH",
          "National Festival Celebration",
          "Dining Room LWH",
          "DDH Lounge",
          "LWH Building",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Public Relations",
        image:
            "assets/images/initiatives/public_relations/1-staff-training.jpeg",
        color: Colors.deepPurple,
        title: "PR - Public Relations",
        description:
            "Public Relations (PR) manages the brand image of YWCA with both the internal and external stakeholders. It facilitates communication and contributes in myriad ways for the well-being and growth of the organization.",
        imagePathList: [
          'assets/images/initiatives/public_relations/1-staff-training.jpeg',
          'assets/images/initiatives/public_relations/2-music-around-the-world.jpg',
          'assets/images/initiatives/public_relations/3-training-on-gst.jpg',
        ],
        imageTitleList: [
          "Staff Training",
          "Music around the world",
          "Training on GST",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Shelter Homes",
        image:
            "assets/images/initiatives/shelter_homes/1-inauguration-of-ummeed-shelter-home.jpeg",
        color: Colors.pink,
        title: "Shelter Homes",
        description:
            "Shelter homes run in collaboration with the BMC provides a home to homeless and distressed women.",
        imagePathList: [
          'assets/images/initiatives/shelter_homes/1-inauguration-of-ummeed-shelter-home.jpeg',
          'assets/images/initiatives/shelter_homes/2-inauguration-of-ummeed-shelter-home.jpg',
          'assets/images/initiatives/shelter_homes/3-ashraya.jpeg',
        ],
        imageTitleList: [
          "Inaugration of Ummeed Shelter home",
          "Inaugration of Ummeed Shelter home",
          "Ashraya",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Membership",
        image: "assets/images/initiatives/memberships/1-ekta.jpeg",
        color: Colors.yellow[700]!,
        title: "Membership",
        description:
            "Membership is the foundation of all YWCA committees and activities, through which members promote the vision and mission of the Association.",
        imagePathList: [
          'assets/images/initiatives/memberships/1-ekta.jpeg',
          'assets/images/initiatives/memberships/2-evening-of-carols.jpg',
          'assets/images/initiatives/memberships/3-sacred-music.jpg',
          'assets/images/initiatives/memberships/4-world-membership-day.jpg',
          'assets/images/initiatives/memberships/5-christmas-programme.jpeg',
        ],
        imageTitleList: [
          "EKTA",
          "Evening of Carols",
          "Sacred Music",
          "World Membership Day",
          "Christmas Programme",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "International Centre",
        image: "assets/images/initiatives/international_centre/1-ic-review.jpg",
        color: Colors.blue[700]!,
        title: "IC - International Centre",
        description:
            "The YWCA International Centre, a medium sized guest house situated in the heart of the Commercial Capital of Mumbai City. With a wide range of rooms of varying quality to suit your needs, our center provides you and your family with a home away from home. It's your choice if you'd like a single, double, triple, family or dormitory room. All are of the finest quality and available at an unbelievable price.",
        imagePathList: [
          'assets/images/initiatives/international_centre/1-ic-review.jpg',
          'assets/images/initiatives/international_centre/2-family-room.png',
          'assets/images/initiatives/international_centre/3-waiting-room.png',
          'assets/images/initiatives/international_centre/4-reception.png',
        ],
        imageTitleList: [
          "IC Review",
          "Family Room",
          "Waiting Room",
          "Reception",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "Spiritual Emphasis",
        image:
            "assets/images/initiatives/spiritual_emphasis/1-world-day-of-prayer.jpg",
        color: Colors.green[700]!,
        title: "SE - Spiritual Emphasis",
        description:
            "Spiritual Emphasis (SE) gives special study and thought to the implementation of YWCA statements of policy, relevant to the Christian emphasis.",
        imagePathList: [
          'assets/images/initiatives/spiritual_emphasis/1-world-day-of-prayer.jpg',
          'assets/images/initiatives/spiritual_emphasis/2-ywca-n-ymca-week-of-prayer.jpg',
          'assets/images/initiatives/spiritual_emphasis/3-week-of-prayer.jpeg',
        ],
        imageTitleList: [
          "World Day of Prayer",
          "YWCA & YMCA Week of Prayer",
          "Week of Prayer",
        ],
      ),
    );
    listOfInitiatives.add(
      Initiative(
        name: "General",
        image: "assets/images/initiatives/general/1-paralegal-training.jpg",
        color: Colors.deepPurple,
        title: "General",
        description: "Events conducted in general",
        imagePathList: [
          'assets/images/initiatives/general/1-paralegal-training.jpg',
          'assets/images/initiatives/general/2-agm.jpg',
          'assets/images/initiatives/general/3-best-ngo-award.jpg',
          'assets/images/initiatives/general/4-best-ngo-award.jpg',
        ],
        imageTitleList: [
          "Paralegal Training",
          "AGM",
          "Best NGO Award",
          "Best NGO Award",
        ],
      ),
    );

    return listOfInitiatives;
  }
}
