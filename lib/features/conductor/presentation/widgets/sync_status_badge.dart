import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SyncStatusBadge extends StatelessWidget {
  final bool isOnline;
  final int pendingCount;
  final VoidCallback? onTap;

  const SyncStatusBadge({
    super.key,
    required this.isOnline,
    required this.pendingCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isOnline
              ? (pendingCount > 0 ? AppColors.warning.withOpacity(0.15) : AppColors.success.withOpacity(0.15))
              : AppColors.danger.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isOnline
                ? (pendingCount > 0 ? AppColors.warning : AppColors.success)
                : AppColors.danger,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isOnline
                  ? (pendingCount > 0 ? Icons.cloud_upload : Icons.cloud_done)
                  : Icons.cloud_off,
              size: 16,
              color: isOnline
                  ? (pendingCount > 0 ? AppColors.warning : AppColors.success)
                  : AppColors.danger,
            ),
            const SizedBox(width: 6),
            Text(
              isOnline
                  ? (pendingCount > 0 ? 'Syncing ($pendingCount Queue)' : 'Live Cloud Sync')
                  : 'Offline ($pendingCount Pending)',
              style: TextStyle(
                color: isOnline
                    ? (pendingCount > 0 ? AppColors.warning : AppColors.success)
                    : AppColors.danger,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
