import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../widgets/blue_bubble_design.dart';
import '../../widgets/zoom_image.dart';

class InitiativeDetails extends StatefulWidget {
  final String title;
  final String description;
  final List<String> imagePathList;
  final List<String> imageTitleList;

  const InitiativeDetails(
    this.title,
    this.description,
    this.imagePathList,
    this.imageTitleList,
  );

  @override
  _InitiativeDetailsState createState() => _InitiativeDetailsState(
      title, description, imagePathList, imageTitleList);
}

class _InitiativeDetailsState extends State<InitiativeDetails> {
  final String _title;
  final String _description;
  final List<String> _imagePathList;
  final List<String> _imageTitleList;

  int _currentIndex = 0;

  _InitiativeDetailsState(
    this._title,
    this._description,
    this._imagePathList,
    this._imageTitleList,
  );

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "YWCA OF BOMBAY",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w800,
            fontSize: 18.0,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color: Colors.orange,
                    child: DetailPageBlueBubbleDesign(),
                  ),
                ],
              ),
              SizedBox(height: _height * 0.1),
              CarouselSlider(
                options: CarouselOptions(
                  // height of whole carousel - including image and text
                  // height: 290,
                  height: _height * 0.35,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: this._imagePathList.map((pathOfImage) {
                  int index = this._imagePathList.indexOf(pathOfImage);
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                margin: EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 10.0,
                                ),
                                elevation: 6.0,
                                shadowColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  child: GestureDetector(
                                    child: Image(
                                      image: AssetImage(pathOfImage),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ZoomImageAsset(pathOfImage),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: _height * 0.01),
                          Text(
                            this._imageTitleList[index],
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1.1,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: this._imagePathList.map((pathOfImage) {
                  int index = this._imagePathList.indexOf(pathOfImage);
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 2.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromRGBO(0, 0, 0, 0.8)
                          : Color.fromRGBO(0, 0, 0, 0.3),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  children: [
                    Text(
                      // 'PIYA- Participation and involvement of youth in action',
                      this._title,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: _height * 0.01,
                    ),
                    Text(
                      this._description,
                      // "Participation and Involvement of Youth in Action (PIYA) is committed to advocate for women’s rights, through the active participation and involvement of a diverse group of young women between the age of 18 to 30 years, who are potential leaders and are committed to social action and transformation of society.",
                      //overflow: TextOverflow.fade,
                      maxLines: 8,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Montserrat',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
