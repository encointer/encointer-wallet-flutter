import 'dart:io';

String fixture(String name) => File('test/mock/fixtures/$name.json').readAsStringSync();
