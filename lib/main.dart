import 'package:flutter/material.dart';
import 'package:number_2/Features/view/contact_page.dart';
import 'package:number_2/Features/view/login_page.dart';
import 'package:number_2/Features/view/map_page.dart';
import 'package:number_2/Features/view/profile_page.dart';
import 'package:number_2/shared_components/widget/bottom_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CustomBottomNavigationBar(),

      },
  }
