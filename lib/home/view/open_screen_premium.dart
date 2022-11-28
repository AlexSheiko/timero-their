import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/settings/view/settings_screen.dart';
import 'package:timero/theme/const_theme.dart';
import 'package:timero/theme/custom_icons/custom_icon_plus_icons.dart';
import 'package:timero/timers/view/timers_reorderable_list_view.dart';

class OpenScreenPremium extends StatefulWidget {
  const OpenScreenPremium({Key? key}) : super(key: key);

  @override
  State<OpenScreenPremium> createState() => _OpenScreenPremiumState();
}

class _OpenScreenPremiumState extends State<OpenScreenPremium> {
  @override
  void initState() {
    BlocProvider.of<GoalsCubit>(context).onPageOpened();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Quit timer',
                style: TextStyle(
                  color: ThemeColor.mainColorDark,
                  fontFamily: ThemeFontFamily.montserratRegular,
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      ),
                  icon: const Icon(
                    Icons.account_circle,
                    color: Color.fromRGBO(58, 58, 58, 1),
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<GoalsCubit, GoalsState>(
        builder: (context, state) {
          if (state is GoalsLoadSuccess && state.goals.isNotEmpty) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TimersReorderableListView(timers: state.goals),
            );
          } else if (state is GoalsStateInitial ||
              (state is GoalsLoadSuccess && state.goals.isEmpty)) {
            return plusButton(context, true);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Widget plusButton(BuildContext context, bool enabled) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 80),
    child: Center(
      child: MaterialButton(
        onPressed: () {
          BlocProvider.of<GoalsCubit>(context).addGoal(
            name: '',
          );
        },
        color: enabled == true ? Colors.white : ThemeColor.backGrounColor,
        padding: const EdgeInsets.all(10),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(CustomIconPlus.plus_svgrepo_com,
            size: 30, color: Color.fromARGB(255, 43, 43, 43)),
      ),
    ),
  );
}
