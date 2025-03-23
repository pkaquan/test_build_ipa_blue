import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<ScanResult> _devicesList = [];
  bool isConnected = false;

  final String ssid = "your_ssid"; // Thay thế bằng SSID của bạn
  final String password = "your_password"; // Thay thế bằng password của bạn

  @override
  void initState() {
    super.initState();
    permissionBlue();
  }

  void permissionBlue() async {
    Map<Permission, PermissionStatus> status =
        await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
        ].request();
    if (status[Permission.bluetooth]!.isGranted &&
        status[Permission.bluetoothScan]!.isGranted &&
        status[Permission.bluetoothConnect]!.isGranted) {
      print("Quyền đã được cấp");
      startScan();
    } 
  }

  Future startScan() async {
    _devicesList.clear();
    try {
      await FlutterBluePlus.startScan(
        timeout: Duration(seconds: 4),
        continuousUpdates: true,
      );
      FlutterBluePlus.scanResults.listen((result) {
        _devicesList = result;
        if (mounted) {
          setState(() {});
        }
      });
      await FlutterBluePlus.stopScan();
    } catch (e) {
      e.toString();
    }
  }

  // Gửi SSID và password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Danh sách thiết bị Bluetooth")),
      body: ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          if (_devicesList[index].device.isConnected) {
            setState(() {
              isConnected = true;
            });
          } else if (_devicesList[index].device.isDisconnected) {
            setState(() {
              isConnected = false;
            });
          }
          return ListTile(
            title: Text(
              _devicesList[index].device.platformName.isEmpty
                  ? "Unknown Device"
                  : _devicesList[index].device.platformName,
            ),
            subtitle: Text(isConnected ? "Kết nối" : "Đã kế nối"),
            onTap: () => _devicesList[index].device.connect(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.search),
        onPressed: startScan,
      ),
    );
  }
}
