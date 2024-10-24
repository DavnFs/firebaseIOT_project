import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('esiot-db');
  double temperature = 0.0;
  double humidity = 0.0;
  bool ledStatus = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirebase();
  }

  void _fetchDataFromFirebase() {
    _databaseRef.child('suhu').onValue.listen((event) {
      final temp = event.snapshot.value;
      if (temp != null) {
        setState(() {
          temperature = (temp as num).toDouble();
        });
      }
    });

    _databaseRef.child('kelembapan').onValue.listen((event) {
      final hum = event.snapshot.value;
      if (hum != null) {
        setState(() {
          humidity = (hum as num).toDouble();
        });
      }
    });

    _databaseRef.child('led').onValue.listen((event) {
      final led = event.snapshot.value;
      if (led != null) {
        setState(() {
          ledStatus = led == '1';
        });
      }
    });
  }

  void _toggleLED() {
    final newStatus = !ledStatus;
    _databaseRef.child('led').set(newStatus ? '1' : '0');
  }

  Widget _buildGlassCard({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
    Widget? trailing,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      icon,
                      size: 32,
                      color: iconColor ?? Colors.white.withOpacity(0.9),
                    ),
                    if (trailing != null) trailing,
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Smart Home',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a237e),  // Deep indigo
              Color(0xFF0097a7),  // Cyan
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Expanded(
                  child: _buildGlassCard(
                    icon: Icons.thermostat_outlined,
                    title: 'Temperature',
                    value: '${temperature.toStringAsFixed(1)}°C',
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _buildGlassCard(
                    icon: Icons.water_drop_outlined,
                    title: 'Humidity',
                    value: '${humidity.toStringAsFixed(1)}%',
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _buildGlassCard(
                    icon: ledStatus ? Icons.lightbulb : Icons.lightbulb_outline,
                    iconColor: ledStatus ? Colors.amber : Colors.white.withOpacity(0.9),
                    title: 'LED Control',
                    value: ledStatus ? 'ON' : 'OFF',
                    trailing: Switch(
                      value: ledStatus,
                      onChanged: (value) => _toggleLED(),
                      activeColor: Colors.amber,
                      activeTrackColor: Colors.amber.withOpacity(0.3),
                      inactiveThumbColor: Colors.white.withOpacity(0.9),
                      inactiveTrackColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}