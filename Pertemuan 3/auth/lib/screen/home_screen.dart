import 'package:flutter/material.dart';
import 'package:auth/screen/side_menu.dart'; // Import SideMenu

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: SideMenu(), // Ganti dengan SideMenu
      body: const Center(child: Text('Home Screen')),
    );
  }
}