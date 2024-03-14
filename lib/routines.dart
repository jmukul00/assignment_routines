import 'dart:io';

import 'package:assignment/routine_model.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class Routines extends StatefulWidget {
  const Routines({super.key});

  @override
  State<Routines> createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[1],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<RoutineModel> data = [
    RoutineModel(
        title: "Cleanser",
        desc: "Cetaphil Gentle Skin Cleanser",
        completed: false),
    RoutineModel(title: "Toner", desc: "Thayers Witch Hazel Toner"),
    RoutineModel(title: "Moisturizer", desc: "Kiehl's Ultra Facial Cream"),
    RoutineModel(title: "Sunscreen", desc: "Supergoop Unseen Sunscreen SPF 40"),
    RoutineModel(title: "Lip Balm", desc: "Glossier Birthday Balm Dotcom"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Daily Skincare",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 15.0, bottom: 15.0),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFF2E8EB),
                  ),
                  child: data[index].completed
                      ? Icon(Icons.done)
                      : Icon(Icons.question_mark_outlined),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index].title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(data[index].desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, color: Color(0xff8f4c61)))
                      ],
                    )),
                Spacer(),
                data[index].completed
                    ? SizedBox()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: IconButton(
                          onPressed: () {
                            openCameraAndUpload(index);
                          },
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                data[index].completed
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(data[index].time!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 15, color: Color(0xff8f4c61))),
                      )
                    : SizedBox()
              ],
            ),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  void openCameraAndUpload(int index) async {
    XFile? image;
    bool clicked = false;
    bool loading = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (buildContext, dialogState) {
          return AlertDialog(
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: clicked
                  ? Image.file(File(image!.path))
                  : CameraPreview(_controller),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              clicked
                  ? ElevatedButton(
                      onPressed: () async {
                        if (loading) {
                          null;
                        } else {
                          try {
                            dialogState(() {
                              loading = true;
                            });
                            FirebaseStorage storage = FirebaseStorage.instance;
                            String fileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            Reference ref = storage
                                .ref()
                                .child("images")
                                .child("$fileName.jpg");
                            await ref.putFile(File(image!.path));
                            final f = DateFormat('hh:mm aaa');
                            String dateTime =
                                f.format(DateTime.now()).toString();

                            setState(() {
                              data[index].completed = true;
                              data[index].time = dateTime;
                            });

                            dialogState(() {
                              loading = false;
                            });
                            Navigator.of(context).pop();
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: loading
                          ? Container(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : Text('Upload'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          image = await _controller.takePicture();
                          dialogState(() {
                            clicked = true;
                          });
                          //Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Take Picture'),
                    ),
            ],
          );
        });
      },
    );
  }
}
