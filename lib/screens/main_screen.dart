import 'dart:io';

import 'package:camera_app/controller/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff021625),
            Color(0xff0483e7),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Consumer(
            builder: (context, ref, child) {
              final image = ref.watch(imageProvider).image;
              return ListView(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Search by image',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 60,
                    ),
                    child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Please upload an image',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                )
                              ],
                            )
                          : Image.file(
                            File(image.path),
                          ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              ref.read(imageProvider).getCameraImage();
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Take photo',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              ref.read(imageProvider).getGalleryImage();
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.yellow[800],
                              child: Icon(
                                Icons.photo_album_outlined,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () async {
                          ref.read(imageProvider).removeImage();
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
