import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:realtime_test/core/colors.dart';
import 'package:realtime_test/core/date_format.dart';
import 'package:realtime_test/presentation/widgets/primary_button.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? dateTime;
  final DatePreset datePreset;
  final Function(DateTime) save;

  const CustomDatePicker({
    super.key,
    this.dateTime,
    this.datePreset = DatePreset.none,
    required this.save,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  var dateToday = DateTime.now();

  var selectedPreset = '';

  final fourPreset = [
    'Never ends',
    '15 days later',
    '30 days later',
    '60 days later',
  ];

  final sixPreset = [
    'Yesterday',
    'Today',
    'Tomorrow',
    'This Saturday',
    'This Sunday',
    'Next Tuesday',
  ];

  @override
  void initState() {
    super.initState();
    dateToday = widget.dateTime ?? DateTime.now();
  }

  int get daysInMonth {
    final year = dateToday.year;
    final month = dateToday.month;
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return daysInMonth[month - 1];
  }

  List<int> daysList(int days) {
    final list = List.generate(
      days,
      (index) => index + 1,
    );

    return list;
  }

  void prevMonth() => setState(() {
        dateToday = DateTime(
          dateToday.year,
          dateToday.month - 1,
        );
      });

  void nextMonth() => setState(() {
        dateToday = DateTime(
          dateToday.year,
          dateToday.month + 1,
        );
      });

  DateTime getDate(String day) {
    var date = DateTime.now();

    while (true) {
      if (DateFormat('EEEE').format(date).toLowerCase() == day.toLowerCase()) {
        return date;
      }
      date = DateTime(
        date.year,
        date.month,
        date.day + 1,
      );
    }
  }

  void changeDate() {
    final today = DateTime.now();
    switch (selectedPreset) {
      case 'Yesterday':
        setState(() {
          dateToday = DateTime(
            today.year,
            today.month,
            today.day - 1,
          );
        });
        break;
      case 'This Saturday':
      case 'This Sunday':
      case 'Next Tuesday':
        setState(() {
          dateToday = getDate(
            selectedPreset.split(' ').last,
          );
        });
        break;
      case 'Today':
      case 'Never ends':
        setState(() {
          dateToday = today;
        });
        break;
      case 'Tomorrow':
        setState(() {
          dateToday = DateTime(
            today.year,
            today.month,
            today.day + 1,
          );
        });
        break;
      case '15 days later':
        setState(() {
          dateToday = DateTime(
            today.year,
            today.month,
            today.day + 15,
          );
        });
        break;
      case '30 days later':
        setState(() {
          dateToday = DateTime(
            today.year,
            today.month,
            today.day + 30,
          );
        });
        break;
      case '60 days later':
        setState(() {
          dateToday = DateTime(
            today.year,
            today.month,
            today.day + 60,
          );
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            if (widget.datePreset != DatePreset.none) ...[
              ...List.generate(
                widget.datePreset == DatePreset.four
                    ? fourPreset.length ~/ 2
                    : sixPreset.length ~/ 2,
                (index) {
                  final list = widget.datePreset == DatePreset.four
                      ? fourPreset
                      : sixPreset;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        PrimaryButton(
                          buttonText: list[index * 2],
                          width: 173,
                          height: 35,
                          onPressed: () {
                            setState(() {
                              selectedPreset = list[index * 2];
                            });
                            changeDate();
                          },
                          buttonColor: list[index * 2] == selectedPreset
                              ? AppColors.buttonBlue
                              : AppColors.aliceBlue,
                          textColor: list[index * 2] == selectedPreset
                              ? AppColors.white
                              : AppColors.buttonBlue,
                        ),
                        const Spacer(),
                        PrimaryButton(
                          buttonText: list[index * 2 + 1],
                          width: 173,
                          height: 35,
                          onPressed: () {
                            setState(() {
                              selectedPreset = list[index * 2 + 1];
                            });
                            changeDate();
                          },
                          buttonColor: list[index * 2 + 1] == selectedPreset
                              ? AppColors.buttonBlue
                              : AppColors.aliceBlue,
                          textColor: list[index * 2 + 1] == selectedPreset
                              ? AppColors.white
                              : AppColors.buttonBlue,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
            ],
            if (widget.datePreset == DatePreset.four) ...[
              const SizedBox(height: 25),
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: prevMonth,
                  behavior: HitTestBehavior.translucent,
                  child: const Icon(
                    Icons.arrow_left_rounded,
                    color: AppColors.spanishGray,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Center(
                    child: Text(
                      dateToday.mmmmyyy,
                      style: const TextStyle(
                        color: AppColors.jet,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: nextMonth,
                  behavior: HitTestBehavior.translucent,
                  child: const Icon(
                    Icons.arrow_right_rounded,
                    color: AppColors.spanishGray,
                    size: 40,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TableCalendar(
              headerVisible: false,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: AppColors.jet,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                weekendStyle: TextStyle(
                  color: AppColors.jet,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              pageJumpingEnabled: false,
              shouldFillViewport: false,
              pageAnimationEnabled: false,
              calendarFormat: CalendarFormat.month,
              rangeSelectionMode: RangeSelectionMode.disabled,
              firstDay: DateTime.utc(0000),
              lastDay: DateTime.utc(4000),
              focusedDay: dateToday,
              currentDay: dateToday,
              onDaySelected: (selectedDay, focusedDay) => setState(() {
                dateToday = selectedDay;
              }),
              availableGestures: AvailableGestures.none,
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: true,
                rangeHighlightColor: AppColors.buttonBlue,
                todayDecoration: BoxDecoration(
                  color: AppColors.buttonBlue,
                  shape: BoxShape.circle,
                ),
                outsideTextStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.platinum,
                  fontWeight: FontWeight.w400,
                ),
                weekendTextStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.jet,
                  fontWeight: FontWeight.w400,
                ),
                holidayTextStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.jet,
                  fontWeight: FontWeight.w400,
                ),
                weekNumberTextStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.jet,
                  fontWeight: FontWeight.w400,
                ),
                defaultTextStyle: TextStyle(
                  fontSize: 15,
                  color: AppColors.jet,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 12),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.buttonBlue,
                  size: 27,
                ),
                const SizedBox(width: 12),
                Text(
                  dateToday.ddmmmyyyy,
                  style: const TextStyle(
                    color: AppColors.jet,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  buttonText: 'Cancel',
                  width: 85,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  buttonColor: AppColors.aliceBlue,
                  textColor: AppColors.buttonBlue,
                ),
                const SizedBox(width: 12),
                PrimaryButton(
                  buttonText: 'Save',
                  width: 73,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.save(dateToday);
                  },
                ),
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

enum DatePreset {
  none,
  four,
  six,
}
