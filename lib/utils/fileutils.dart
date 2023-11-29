import 'dart:io';

checkFileExists(String filePath) {
  return File(filePath).existsSync();
}

copyFile(String sourcePath, String copyPath){
  File sourceFile = File(sourcePath);
  sourceFile.copySync(copyPath);
}