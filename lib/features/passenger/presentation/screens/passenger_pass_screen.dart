import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class PassengerPassScreen extends StatelessWidget {
  const PassengerPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital SyncPass Commuter QR'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // SyncPass Commuter Card Widget
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SYNCRIDE PASSPORT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 14,
                        ),
                      ),
                      Icon(Icons.nfc, color: Colors.white70),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Simulated QR Code Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.qr_code_2_rounded, size: 140, color: Colors.black87),
                        SizedBox(height: 4),
                        Text(
                          'PASS-9984-2026',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PASSENGER NAME', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          Text('Renujaan R.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('PASS TYPE', style: TextStyle(color: Colors.white70, fontSize: 10)),
                          Text('Monthly Commuter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Wallet & Reload Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SyncPass Wallet Balance', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      SizedBox(height: 4),
                      Text(
                        'LKR 1,450.00',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.success),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Top up LKR 500 added to SyncPass Wallet!')),
                      );
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Top Up'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
