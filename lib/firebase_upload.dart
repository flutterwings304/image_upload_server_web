import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

uploadFile() async {
  Reference _reference =
      FirebaseStorage.instance.ref().child("Testimonials/${"gh"}");
  final data = pickFiles();
  await _reference.putData(data).whenComplete(() async {
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
  () async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result == null) {
      return null;
    }

    return result.files.first.bytes;
  };
}
