import 'package:flutter/material.dart';
import 'package:realtime_test/core/colors.dart';
import 'package:realtime_test/core/date_format.dart';

class DateIndicator extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback cancel;
  const DateIndicator({
    super.key,
    required this.dateTime,
    required this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.aliceBlue,
        borderRadius: BorderRadius.circular(68),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.buttonBlue,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            dateTime.ddmmmyyyy,
            style: const TextStyle(
              color: AppColors.buttonBlue,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: cancel,
            child: const Icon(
              Icons.close,
              color: AppColors.buttonBlue,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
