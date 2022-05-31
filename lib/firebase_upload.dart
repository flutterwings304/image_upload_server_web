import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

uploadFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (result == null) {
    return;
  }
  print(result.files.first);
  final data = result.files.first.bytes;
  Reference _reference =
      FirebaseStorage.instance.ref().child("Testimonials/${"gh"}");

  await _reference.putData(data!).whenComplete(() async {
    await _reference.getDownloadURL().then((url) {});
  });
}

Future uploadOnServer(
  byteData,
) async {
  var uri = "YOUR_SERVER_URL";
  FormData _fd = FormData.fromMap({
    "files": base64Encode(byteData),
  });
  Dio()
      .post(uri, data: _fd, options: Options(responseType: ResponseType.json))
      .then((value) {
    //TODO: Do things accorindly
  });
}

dynamic pickFiles() async {
  () async {};
}

class ImageUpload extends StatelessWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ImageUpload");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Upload'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadFile();
          },
          child: const Text('Upload'),
        ),
      ),
    );
  }
}
