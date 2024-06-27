import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key});

  static Future<void> openMap() async {
    const String googleUrl = 'https://www.google.com/maps/search/my+location/';
    final Uri _uri = Uri.parse(googleUrl);
    try {
      await launch(_uri.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: 'something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = 24.0; // Ukuran ikon
    final buttonPadding = 8.0; // Padding tombol

    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/constants/assets/image/maps.png',
              width: 400,
              height: 400,
            ),
            SizedBox(height: 16), // Jarak antara gambar dan tombol
            ElevatedButton(
              onPressed: () {
                openMap(); // Panggil metode openMap saat tombol ditekan
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_city, size: iconSize),
                  SizedBox(width: buttonPadding),
                  Text('Open Maps'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
