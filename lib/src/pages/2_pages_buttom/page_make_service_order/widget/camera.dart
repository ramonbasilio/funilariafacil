import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servicemangerapp/src/pages/widgets/page_preview_camera.dart';

class Camera extends StatefulWidget {
  final Function(List<File>) finalReturn;
  const Camera({required this.finalReturn, super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? galleryFile;
  List<File> listImage = [];

  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(
            color: Colors.black,
            width: 5.0,
          ),
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade200,
      ),
      width: double.infinity,
      padding: EdgeInsets.only(top: 10),
      height: 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          listImage.isEmpty
              ? const SizedBox(
                  width: 200,
                  height: 150,
                  child: Center(
                    child: Text('Sem imagens'),
                  ),
                )
              : GestureDetector(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List<Widget>.generate(
                        listImage.length,
                        (int index) {
                          return Container(
                            padding: EdgeInsets.only(left: 10, right: 5),
                            width: 210,
                            height: 250,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => PreviewPageCamera(
                                      file: listImage[index],
                                      checkImage: true,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Image.file(
                                    fit: BoxFit.fitWidth,
                                    width: 200,
                                    height: 200,
                                    listImage[index],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        listImage.removeAt(index);
                                        widget.finalReturn(listImage);
                                      });
                                    },
                                    icon: const Icon(Icons.delete_rounded),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
          IconButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        context: context,
        builder: (context) {
          return SizedBox(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.image_outlined),
                  title: const Text('Galeria'),
                  onTap: () => {getImage(ImageSource.gallery), Get.back()},
                ),
                ListTile(
                    leading: const Icon(Icons.camera_alt_outlined),
                    title: const Text('Camera'),
                    onTap: () => {getImage(ImageSource.camera), Get.back()}),
              ],
            ),
          );
        });
  }

  Future<void> getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
          if (galleryFile != null) {
            listImage.add(galleryFile!);
            widget.finalReturn(listImage);
          }
        }
      },
    );
  }
}
