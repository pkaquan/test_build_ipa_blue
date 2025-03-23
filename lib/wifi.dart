// import 'package:bluetooth/data.dart';
// import 'package:flutter/material.dart';

// class Wifi extends StatefulWidget {
//   final Function(Data) addData;
//   const Wifi({required this.addData, super.key});

//   @override
//   State<Wifi> createState() => _WifiState();
// }

// class _WifiState extends State<Wifi> {
//   final ssid = TextEditingController();
//   final password = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 24),
//               child: TextField(
//                 style: TextStyle(fontSize: 16),
//                 keyboardType: TextInputType.emailAddress,
//                 controller: ssid,
//                 decoration: InputDecoration(
//                   enabled: true,
//                   hintText: 'SSID',
//                   prefixIcon: Icon(Icons.phone, size: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 24),
//               child: TextField(
//                 style: TextStyle(fontSize: 16),
//                 keyboardType: TextInputType.emailAddress,
//                 controller: password,
//                 decoration: InputDecoration(
//                   enabled: true,
//                   hintText: 'Password',
//                   prefixIcon: Icon(Icons.email, size: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(30)),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: saveWifi,
//               child: Text(
//                 'Lưu',
//                 style: TextStyle(color: Colors.black, fontSize: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void saveWifi() {
//     final user = Data(ssid.text, password.text);
//     widget.addData(user);
//     Navigator.pop(context);
//   }
// }
