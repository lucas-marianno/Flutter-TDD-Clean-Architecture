import 'dart:io';

String readJson(String fileName) {
  final currentDir = Directory.current.path;

  return File('$currentDir\\test\\helper\\$fileName').readAsStringSync();
}
