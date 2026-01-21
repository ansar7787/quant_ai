import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(icon: Icons.add, label: 'Deposit', onTap: () {}),
        _buildActionButton(
          icon: Icons.arrow_outward,
          label: 'Withdraw',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.qr_code_scanner,
          label: 'Scan',
          onTap: () {},
        ),
        _buildActionButton(icon: Icons.history, label: 'History', onTap: () {}),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6), // Light grey for light mode
              // Dark mode verification needed later, stick to neutral for now
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black87, size: 24.sp),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
