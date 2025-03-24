//
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final FlutterBlue blue = FlutterBlue.instance;
  List<BluetoothDevice> listDevice = [];
  bool isScanning = false;
  @override
  void initState() {
    super.initState();
  }

  void startScan() {
    setState(() {
      isScanning = false;
      listDevice.clear();
    });
    blue.startScan(timeout: Duration(seconds: 5));
    blue.scanResults.listen((result) {
      for (ScanResult r in result) {
        if (listDevice.contains(r.device)) {
          setState(() {
            listDevice.add(r.device);
          });
        }
      }
    });
    blue.isScanning.listen((isScanning) {
      setState(() {
        this.isScanning = isScanning;
      });
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Đã kết nối với ${device.name}')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Lỗi kết nối: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth'),
        actions: [
          IconButton(
            onPressed: isScanning ? null : startScan,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          if (isScanning)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: listDevice.length,
              itemBuilder: (context, index) {
                BluetoothDevice device = listDevice[index];
                return ListTile(
                  title: Text(
                    device.name.isEmpty ? "Thiết bị không tên" : device.name,
                  ),
                  leading: Text(device.id.toString()),
                  trailing: ElevatedButton(
                    onPressed: () => connectToDevice(device),
                    child: Text("Kết nối"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
