import 'package:flutter/material.dart';

import 'package:realtime_test/core/colors.dart';
import 'package:realtime_test/presentation/widgets/date_indicator.dart';
import 'package:realtime_test/presentation/widgets/date_picker.dart';
import 'package:realtime_test/presentation/widgets/primary_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? withoutPresetDateTime;
  DateTime? fourPresetDateTime;
  DateTime? sixPresetDateTime;

  void showDatePicker(DatePreset datePreset) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomDatePicker(
        datePreset: datePreset,
        dateTime: datePreset == DatePreset.none
            ? withoutPresetDateTime
            : datePreset == DatePreset.four
                ? fourPresetDateTime
                : datePreset == DatePreset.six
                    ? sixPresetDateTime
                    : null,
        save: (dateTime) {
          switch (datePreset) {
            case DatePreset.none:
              setState(() {
                withoutPresetDateTime = dateTime;
              });
              break;
            case DatePreset.four:
              setState(() {
                fourPresetDateTime = dateTime;
              });
              break;
            case DatePreset.six:
              setState(() {
                sixPresetDateTime = dateTime;
              });
              break;
            default:
              break;
          }
        },
      ),
    );
  }

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
              onPressed: () {
                showDatePicker(DatePreset.none);
              },
            ),
            if (withoutPresetDateTime != null) ...[
              const SizedBox(height: 16),
              DateIndicator(
                dateTime: withoutPresetDateTime!,
                cancel: () => setState(() {
                  withoutPresetDateTime = null;
                }),
              ),
              const SizedBox(height: 40),
            ] else
              const SizedBox(height: 80),
            PrimaryButton(
              buttonText: 'With 4 presets',
              onPressed: () {
                showDatePicker(DatePreset.four);
              },
            ),
            if (fourPresetDateTime != null) ...[
              const SizedBox(height: 16),
              DateIndicator(
                dateTime: fourPresetDateTime!,
                cancel: () => setState(() {
                  fourPresetDateTime = null;
                }),
              ),
              const SizedBox(height: 40),
            ] else
              const SizedBox(height: 80),
            PrimaryButton(
              buttonText: 'With 6 presets',
              onPressed: () {
                showDatePicker(DatePreset.six);
              },
            ),
            if (sixPresetDateTime != null) ...[
              const SizedBox(height: 16),
              DateIndicator(
                dateTime: sixPresetDateTime!,
                cancel: () => setState(() {
                  sixPresetDateTime = null;
                }),
              ),
            ],
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
