import 'dart:io';
import 'package:flutter/services.dart';

bool checkFileExists(String filePath) {
  return File(filePath).existsSync();
}

void copyFile(String sourcePath, String copyPath) async {
  ByteData data = await rootBundle.load(sourcePath);
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  File(copyPath).writeAsBytesSync(bytes, flush: true);
}

void deleteFile(String sourcePath){
  File sourceFile = File(sourcePath);
  sourceFile.deleteSync();
}