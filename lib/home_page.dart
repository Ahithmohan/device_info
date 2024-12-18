import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _deviceDetails = "Device information";

  Future<void> _getDeviceInfo() async {
    final device = DeviceInfoPlugin();
    String deviceDetails = "";
    if (Platform.isAndroid) {
      var androidInfo = await device.androidInfo;
      deviceDetails =
          "Device Name: ${androidInfo.brand}\nDevice Model: ${androidInfo.model}\nDevice ID: ${androidInfo.id}";
    } else if (Platform.isIOS) {
      var iosInfo = await device.iosInfo;
      deviceDetails =
          "Device Name: ${iosInfo.name}\nDevice ID: ${iosInfo.identifierForVendor}";
    } else {
      deviceDetails = "Unsupported Platform";
    }

    setState(() {
      _deviceDetails = deviceDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(child: Text("Device Details")),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Card(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _deviceDetails,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.green)),
              onPressed: _getDeviceInfo,
              child: const Text(
                "Get Device ID",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
