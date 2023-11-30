import 'dart:io';

bool checkFileExists(String filePath) {
  return File(filePath).existsSync();
}

void copyFile(String sourcePath, String copyPath){
  File sourceFile = File(sourcePath);
  sourceFile.copySync(copyPath);
}