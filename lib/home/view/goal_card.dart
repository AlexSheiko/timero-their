import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:measured_size/measured_size.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/app/view/components/ui_views_states.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/home/view/components/add_days_menu.dart';
import 'package:timero/home/view/components/delete_days_menu.dart';
import 'package:timero/home/view/components/set_name_menu.dart';
import 'package:timero/theme/const_theme.dart';

import 'components/edit_days_menu.dart';

part 'back_layer.dart';
part 'front_layer.dart';

class GoalCard extends StatefulWidget {
  const GoalCard({required this.goal, this.initialCardState, super.key});

  final Goal goal;
  final FrontLayerState? initialCardState;

  @override
  State<GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<GoalCard> {
  _GoalCardState();

  Size wsize = Size.zero;
  FrontLayerState cardState = FrontLayerState.initial;

  @override
  void initState() {
    if (widget.initialCardState != null) {
      setState(() {
        cardState = widget.initialCardState!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 27.0),
      child: MeasuredSize(
        onChange: (Size size) {
          // MeasuredSize is needed to show the gray background behind Historic Overview
          setState(() {
            wsize = size;
          });
        },
        child: BlocBuilder<GoalsCubit, GoalsState>(
          builder: (context, state) {
            return Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              shadowColor: const Color.fromRGBO(58, 58, 58, 0.5),
              elevation: 6,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                    child: BackLayer(
                      widget.goal,
                      cardState,
                      (FrontLayerState state) {
                        setState(() {
                          cardState = state;
                        });
                      },
                      wsize,
                    ),
                  ),
                  Positioned.fill(
                    child: FrontLayer(
                      widget.goal,
                      cardState,
                      (FrontLayerState state) {
                        setState(() {
                          cardState = state;
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

String _parseDate(DateTime startDate) {
  String result = '';
  String day = startDate.day.toString();
  String year = startDate.year.toString();
  int tempMonth = startDate.month;
  String month = _parseMonth(tempMonth);
  result = '$day $month $year';
  return result;
}

String _parseMonth(int tempMonth) {
  String month = '';
  switch (tempMonth) {
    case 1:
      month = 'January';
      break;
    case 2:
      month = 'February';
      break;
    case 3:
      month = 'March';
      break;
    case 4:
      month = 'April';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'June';
      break;
    case 7:
      month = 'July';
      break;
    case 8:
      month = 'August';
      break;
    case 9:
      month = 'September';
      break;
    case 10:
      month = 'October';
      break;
    case 11:
      month = 'November';
      break;
    case 12:
      month = 'December';
      break;
  }
  return month;
}

String _timeSinceLastReset(Goal goal) {
  // String text = '';
  // Duration time;
  // String days;
  // String hours;
  // DateTime startDate;
  // if (goal.resets.isEmpty) {
  //   startDate = goal.startDate;
  // } else {
  //   startDate = goal.resets.last;
  // }
  // time = startDate.difference(DateTime.now());
  // List<int> result = _parseTime(time);
  // if (result.first == 0) {
  //   days = '';
  // } else {
  //   if (result.first == 1) {
  //     days = '1 day';
  //   } else {
  //     days = '${result.first * -1} days ';
  //   }
  // }
  // hours = '${result.last * -1} hours';
  // text = '$days $hours';
  // return text;}
  if (goal.resets.isEmpty) {
    return '0 hours';
  } else {
    int days = DateTime.now().difference(goal.resets.first).inDays;
    int hours =
        (DateTime.now().difference(goal.resets.first).inHours - 24 * days);
    return days > 0
        ? '$days ${days == 1 ? 'day' : 'days'}  $hours ${hours == 1 ? 'hour' : 'hours'}'
        : '$hours ${hours == 1 ? 'hour' : 'hours'}';
  }
}

double _calculateWidth(
    BuildContext context, List<DateTime> resets, int index, Goal goal) {
  double result = 0;
  var width = MediaQuery.of(context).size.width;
  if (width > 0) {
    const padding = 44; // TODO: Where is this from?
    width = width - padding;
    // print('Total width (after subtracting padding): $width');
    // print('User has ${resets.length} resets');
    // print('Goal\'s start date is ${goal.startDate}');
    // print('Now is ${DateTime.now()}');
    print('------------------------------------');
    if (resets.isEmpty) {
      result = width;
    } else {
      DateTime startOfPeriod;
      DateTime endOfPeriod;
      Duration allPeriodDuration = DateTime.now().difference(goal.startDate);
      // print('Total duration for all resets is : $allPeriodDuration');
      if (index == 0) {
        // First index
        startOfPeriod = goal.startDate;
        endOfPeriod = resets.last;
      } else if (index == resets.length) {
        // Last index
        startOfPeriod = resets.first;
        endOfPeriod = DateTime.now();
      } else {
        startOfPeriod = resets[resets.length - index - 1];
        endOfPeriod = resets[resets.length - index];
      }
      Duration periodDuration = (startOfPeriod.difference(endOfPeriod)).abs();
      // Convert reset duration to days and hours
      int days = periodDuration.inDays;
      int hours = (periodDuration.inHours - 24 * days);
      print('Duration for reset $index is $days days and $hours hours');
      result = (periodDuration.inSeconds / allPeriodDuration.inSeconds) * width;
      print('Reset #$index width is: $result');
    }
  }
  return result;
}

Color _calculateColor(int index, int length) {
  // if (kDebugMode) {
  //   // Random color
  //   return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  // }
  Color result = ThemeColor.mainColorLight;
  if (index == length) {
    result = ThemeColor.mainColorGreen;
  }
  return result;
}

List<int> _parseTime(Duration time) {
  List<int> parsedTime = [];
  var days = time.inDays;
  var hours = time.inHours;
  hours -= days * 24;
  parsedTime.add(days);
  parsedTime.add(hours);
  return parsedTime;
}

String _daysForDetails(List<DateTime> resets, int index, Goal goal) {
  if (index == resets.length - 1) {
    int days = resets[index].difference(goal.startDate).inDays;
    int hours = resets[index].difference(goal.startDate).inHours - 24 * days;
    return '$days ${days == 1 ? 'day' : 'days'}  $hours ${hours == 1 ? 'hour' : 'hours'}';
  } else {
    int days = resets[index].difference(resets[index + 1]).inDays;
    int hours = resets[index].difference(resets[index + 1]).inHours - 24 * days;
    return '$days ${days == 1 ? 'day' : 'days'}  $hours ${hours == 1 ? 'hour' : 'hours'}';
  }
}

String _textForDetails(List<DateTime> resets, int index) {
  String text = '';
  if (index == 0) {
    text = 'Last reset: ';
  } else {
    text = 'Reset ${resets.length - index} : ';
  }
  text += _parseDate(resets[index]);
  return text;
}

double _historicalHeight(bool isDetailsOpen) {
  if (isDetailsOpen) {
    return 200.0;
  } else {
    return 70.0;
  }
}

Widget _goalDetails(Goal goal, Size size) {
  if (goal.goalDays != 0) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your current goal: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(58, 58, 58, 1),
                  fontFamily: ThemeFontFamily.montserratRegular,
                ),
              ),
              Text(
                '${goal.goalDays} days',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(58, 58, 58, 1),
                  fontFamily: ThemeFontFamily.montserratRegular,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _goalContainer(size, goal),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _remainingDays(goal),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(58, 58, 58, 1),
                  fontFamily: ThemeFontFamily.montserratRegular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}

String _remainingDays(Goal goal) {
  int passedDays;
  String result;
  if (goal.resets.isEmpty) {
    passedDays = DateTime.now().difference(goal.startDate).inDays;
  } else {
    passedDays = DateTime.now().difference(goal.resets.last).inDays;
  }
  result = '${goal.goalDays - passedDays} days remaining';
  return result;
}

Widget _goalContainer(Size size, Goal goal) {
  return SizedBox(
    width: double.infinity,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ThemeColor.mainColorLight,
            border: Border.all(
              color: ThemeColor.mainColorLight,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 30,
          width: size.width,
        ),
        Container(
          decoration: BoxDecoration(
            color: ThemeColor.mainColorGreen,
            border: Border.all(
              color: ThemeColor.mainColorGreen,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 30,
          width: _calculateGoalWidth(size, goal),
        ),
      ],
    ),
  );
}

double _calculateGoalWidth(Size size, Goal goal) {
  int passedDays;
  double result;
  if (goal.resets.isEmpty) {
    passedDays = DateTime.now().difference(goal.startDate).inDays;
  } else {
    passedDays = DateTime.now().difference(goal.resets.last).inDays;
  }
  result = size.width * (passedDays / goal.goalDays);
  return result;
}
