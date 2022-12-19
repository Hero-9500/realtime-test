import 'package:flutter/material.dart';

import 'package:realtime_test/core/colors.dart';
import 'package:realtime_test/presentation/widgets/primary_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Calendar widgets',
              style: TextStyle(
                color: AppColors.jet,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 42),
            PrimaryButton(
              buttonText: 'Without preset',
              onPressed: () {},
            ),
            const SizedBox(height: 80),
            PrimaryButton(
              buttonText: 'With 4 presets',
              onPressed: () {},
            ),
            const SizedBox(height: 80),
            PrimaryButton(
              buttonText: 'With 6 presets',
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const Text(
        'With ❤️ by Hiren Ramani',
        style: TextStyle(
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
