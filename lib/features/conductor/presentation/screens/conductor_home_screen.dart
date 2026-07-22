import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ConductorHomeScreen extends StatefulWidget {
  const ConductorHomeScreen({super.key});

  @override
  State<ConductorHomeScreen> createState() => _ConductorHomeScreenState();
}

class _ConductorHomeScreenState extends State<ConductorHomeScreen> {
  int passengerCount = 18;
  final int busCapacity = 54;
  bool isSynced = true;

  void _issueTicket() {
    if (passengerCount < busCapacity) {
      setState(() {
        passengerCount++;
        isSynced = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ticket Issued! Occupancy updated live to Cloud.'),
          duration: Duration(seconds: 1),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _passengerAlighted() {
    if (passengerCount > 0) {
      setState(() {
        passengerCount--;
        isSynced = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conductor Digital Ticket Sync'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSynced ? Icons.cloud_done : Icons.cloud_off,
                        color: isSynced ? AppColors.success : AppColors.warning,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isSynced ? 'Live Cloud Sync Active' : 'Offline Mode',
                        style: TextStyle(
                          color: isSynced ? AppColors.success : AppColors.warning,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Onboard Passengers', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    '$passengerCount / $busCapacity',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.danger,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _passengerAlighted,
                    icon: const Icon(Icons.remove, size: 28),
                    label: const Text('Alighted (-1)', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _issueTicket,
                    icon: const Icon(Icons.confirmation_number, size: 28),
                    label: const Text('Issue Ticket (+1)', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
