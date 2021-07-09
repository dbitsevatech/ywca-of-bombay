// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
//
// import '../../widgets/blue_bubble_design.dart';
//
// class InitiativeDetails extends StatefulWidget {
//   final String title;
//   final String description;
//   final List<String> imagePathList;
//   final List<String> imageTitleList;
//
//   const InitiativeDetails(
//     this.title,
//     this.description,
//     this.imagePathList,
//     this.imageTitleList,
//   );
//
//   @override
//   _InitiativeDetailsState createState() => _InitiativeDetailsState(
//       title, description, imagePathList, imageTitleList);
// }
//
// class _InitiativeDetailsState extends State<InitiativeDetails> {
//   final String _title;
//   final String _description;
//   final List<String> _imagePathList;
//   final List<String> _imageTitleList;
//
//   _InitiativeDetailsState(
//     this._title,
//     this._description,
//     this._imagePathList,
//     this._imageTitleList,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     final _height = MediaQuery.of(context).size.height;
//
//     print("title: " + this._title);
//     print("description: " + this._description);
//     print("image list: " + this._imagePathList.toString());
//     print("image list: " + this._imageTitleList.toString());
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         title: Text(
//           "YWCA Of Bombay",
//           style: TextStyle(
//             fontFamily: 'LobsterTwo',
//             fontStyle: FontStyle.italic,
//             fontWeight: FontWeight.bold,
//             fontSize: 18.0,
//             color: Colors.black87,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.share,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               //do something
//               // gotoSecondActivity(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     color: Colors.orange,
//                     // margin: EdgeInsets.all(0.0),
//                     // child: CustomPaint(
//                     //   painter: BlueBubbleDesign(),
//                     // ),
//                     child: DetailPageBlueBubbleDesign(),
//                   ),
//                 ],
//               ),
//               Padding(padding: const EdgeInsets.only(top: 10)),
//               Container(
//                 height: 420,
//                 child: Swiper(
//                   autoplay: false,
//                   itemCount: this._imagePathList.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Column(
//                       // To centralize the children.
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image(
//                             image: AssetImage(this._imagePathList[index]),
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         SizedBox(
//                           height: _height * 0.01,
//                         ),
//                         Text(
//                           this._imageTitleList[index],
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.black,
//                             fontWeight: FontWeight.normal,
//                             fontFamily: 'Monstserrat',
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     );
//                   },
//                   viewportFraction: 0.85,
//                   scale: 0.9,
//                   pagination: SwiperPagination(
//                     //changing the color of the pagination dots and that of
//                     //the active dot
//                     builder: DotSwiperPaginationBuilder(
//                       color: Colors.grey,
//                       activeColor: Color(0XFF80DEEA),
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 30, right: 30),
//                 child: Column(
//                   children: [
//                     Text(
//                       // 'PIYA- Participation and involvement of youth in action',
//                       this._title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Montserrat',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(
//                       height: _height * 0.01,
//                     ),
//                     Text(
//                       this._description,
//                       // "Participation and Involvement of Youth in Action (PIYA) is committed to advocate for women’s rights, through the active participation and involvement of a diverse group of young women between the age of 18 to 30 years, who are potential leaders and are committed to social action and transformation of society.",
//                       //overflow: TextOverflow.fade,
//                       maxLines: 8,
//                       style: TextStyle(
//                         fontSize: 16,
//                         height: 1.5,
//                         color: Colors.black,
//                         fontWeight: FontWeight.normal,
//                         fontFamily: 'Montserrat',
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
