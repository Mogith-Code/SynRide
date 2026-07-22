import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize cloud services & state repositories
  runApp(const SyncRideApp());
}
