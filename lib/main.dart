import 'package:flutter/material.dart';

import 'portal_berita_page.dart';

void main() {
  runApp(MyApp());
}

// Bikin UI dlu
// Tambahin package http
// buat network request
// ubah response ke object dart
// Bikin model class
// ubah http.response menjadi model class
// Ambil data
// Tampilkan data
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: PortalBeritaPage(
        title: 'News App',
      ),
    );
  }
}
