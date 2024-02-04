import 'package:flutter/material.dart';
import 'App.dart';
import 'Krankenhaus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}
