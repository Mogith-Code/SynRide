import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/repositories/ticket_repository.dart';

class OfflineSyncQueueScreen extends StatefulWidget {
  const OfflineSyncQueueScreen({super.key});

  @override
  State<OfflineSyncQueueScreen> createState() => _OfflineSyncQueueScreenState();
}

class _OfflineSyncQueueScreenState extends State<OfflineSyncQueueScreen> {
  final TicketRepository _repository = TicketRepository();
  bool _isSyncing = false;

  void _triggerSync() async {
    setState(() => _isSyncing = true);
    final count = await _repository.syncPendingQueue();
    if (!mounted) return;
    setState(() => _isSyncing = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          count > 0
              ? 'Successfully synced $count ticket(s) to cloud database!'
              : 'All offline records are synced.',
        ),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingTickets = _repository.pendingTickets;
    final isOnline = _repository.isOnline;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Queue Sync Engine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isOnline ? AppColors.success : AppColors.warning,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isOnline ? Icons.cloud_done : Icons.cloud_off,
                    size: 36,
                    color: isOnline ? AppColors.success : AppColors.warning,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isOnline ? 'Cloud Connection Active' : 'Offline Storage Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isOnline ? AppColors.success : AppColors.warning,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pendingTickets.isEmpty
                              ? 'All local tickets are synced with Realtime DB.'
                              : '${pendingTickets.length} ticket(s) waiting in local SQLite queue.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Pending Queue List Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pending Queue Payloads',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '${pendingTickets.length} items',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: pendingTickets.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 64, color: AppColors.success),
                          SizedBox(height: 12),
                          Text(
                            'Local Queue is Clear!',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'All issued tickets are safely stored in the cloud.',
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: pendingTickets.length,
                      itemBuilder: (context, index) {
                        final ticket = pendingTickets[index];
                        return Card(
                          color: Colors.white,
                          elevation: 1,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: AppColors.warning,
                              child: Icon(Icons.sync_problem, color: Colors.white, size: 20),
                            ),
                            title: Text(
                              ticket.ticketNumber,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${ticket.originStop} ➔ ${ticket.destinationStop}'),
                            trailing: Text(
                              'LKR ${ticket.fareAmount.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),

            // Force Sync Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: (pendingTickets.isEmpty || _isSyncing) ? null : _triggerSync,
                icon: _isSyncing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.cloud_upload_rounded),
                label: Text(
                  _isSyncing ? 'SYNCING TO CLOUD...' : 'FORCE SYNC QUEUE NOW',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
