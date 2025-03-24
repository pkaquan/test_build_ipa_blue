import 'package:bluetooth/streambuild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách thiết bị Bluetooth")),
      body: GetBuilder<Streambuild>(
        init: Streambuild(),
        builder: (Streambuild controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResult,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.rssi.toString()),
                                onTap:
                                    () => controller.connectingDevice(data.device),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(child: Text("Không tìm thấy thiết bị"));
                    }
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    controller.startScan();
                    // await controller.disconnectDevice();
                  },
                  child: Text("SCAN"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
