import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../widgets/blue_bubble_design.dart';
import '../../../widgets/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// ignore: must_be_immutable
class AdminEditEventImage extends StatefulWidget {
  String id, eventImageUrl;

  AdminEditEventImage({
    required this.id,
    required this.eventImageUrl,
  });

  @override
  _AdminEditEventImageState createState() => _AdminEditEventImageState();
}

class _AdminEditEventImageState extends State<AdminEditEventImage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // image path variable
  File? _image;
  // display the select iamge
  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          source: ImageSource.gallery, maxHeight: 2000, maxWidth: 2000);
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
    // ignore: unnecessary_null_comparison
    if (_image != null) {
      return Image.file(_image!);
    } else {
      return Text('Choose an image to show', style: TextStyle(fontSize: 18.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    // fetching the values
    String id = widget.id, eventImageUrl = widget.eventImageUrl;

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
                            'Edit Image',
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
                // selected new image
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
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01,
                    horizontal: _width * 0.04,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
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
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                // alertbox for saving the new/changed image
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirmation'),
                                      content: Text(
                                          'Are you sure you want to save new image?'),
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
                                            updateData(context, id,eventImageUrl);
                                            Navigator.pop(context);
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
  Future updateData(BuildContext context, id, eventImageUrl) async {
    await FirebaseStorage.instance
        .refFromURL(eventImageUrl)
        .delete();
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image!);

    uploadTask.whenComplete(() {
      print("uploaded");
    });
    // reference to the firestore of the image
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    var url = imageUrl.toString();
    print("Image URL=" + url);

    print("Updating record on firestore");
    FirebaseFirestore.instance
        .collection('events')
        .doc(id)
        .update({'eventImageUrl': url});
    print("updated on firestore");
  }
}

goBackToPreviousScreen(BuildContext context) {
  Navigator.pop(context);
}
