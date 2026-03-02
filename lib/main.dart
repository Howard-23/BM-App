library barangaymo_app;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'src/core/activation_flow.dart';
part 'src/official/official_shell.dart';
part 'src/shared/barangay_services.dart';
part 'src/auth/auth_flow.dart';
part 'src/resident/resident_shell_dashboard.dart';
part 'src/resident/resident_commerce.dart';
part 'src/resident/resident_services_account.dart';
part 'src/resident/resident_rbi.dart';

void main() => runApp(const BarangayMoApp());

class BarangayMoApp extends StatelessWidget {
  const BarangayMoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BarangayMo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFD70000),
      ),
      home: const RoleGatewayScreen(),
    );
  }
}
