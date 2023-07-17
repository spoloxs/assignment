import 'dart:io';
import 'package:assignment/bloc/widgets_bloc.dart';
import 'package:assignment/service/firebase.dart';
import 'package:assignment/state/widgets_state.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class WidgetsScreen extends StatefulWidget {
  const WidgetsScreen({super.key});

  @override
  State<StatefulWidget> createState() => WidgetsScreenElements();
}

class WidgetsScreenElements extends State<WidgetsScreen> {
  final textcontroller = TextEditingController();
  ImagePicker picker = ImagePicker();
  String imageURL = 'https://i.imgur.com/sUFH1Aq.png';
  XFile? image;
  String downloadURL = 'https://i.imgur.com/sUFH1Aq.png';
  late File file;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetBloc, WidgetsState>(builder: (context, state) {
      List<Widget> widgetList = [];
      if (state.widgetState["textBox"] == true) {
        widgetList.add(
          TextField(
            controller: textcontroller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),
        );
        widgetList.add(const Spacer());
      }
      if (state.widgetState["imageBox"] == true) {
        widgetList.add(Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final deviceInfo = await DeviceInfoPlugin().androidInfo;
                      var permissionStatus = deviceInfo.version.sdkInt > 32 ? 
                      await Permission.photos.request()
                      : await Permission.storage.request();

                      if (permissionStatus.isGranted) {
                        image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          file = File(image!.path);
                        }
                      }
                    },
                    child: Image.network(imageURL)),
              ],
            )));
        widgetList.add(const Spacer());
      }
      if (state.widgetState["saveButton"] == true) {
        widgetList.add(FloatingActionButton.extended(
            onPressed: () async {
              if (state.widgetState["textBox"] == false &&
                  state.widgetState["imageBox"] == false) {
                showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                          title: Text("Add atleast one widget"),
                        ));
              } else {
                if (state.widgetState["imageBox"] == true) {
                  if (image != null) {
                    downloadURL = await uploadImage(file);
                  }
                }
                uploadData(textcontroller.text, downloadURL);
                setState(() {
                  textcontroller.text = "";
                });

                var documentReference = await getData();
                Map<String, dynamic>? data = documentReference.data();
                if (data != null) {
                  setState(() {
                    textcontroller.text = data["name"];
                    imageURL = data["image"];
                  });
                }
              }
            },
            label: const Text("Submit")));
      }
      if (widgetList.isEmpty == true) {
        widgetList.add(const Text("No Widget Added"));
      }

      return Column(children: widgetList);
    });
  }
}
