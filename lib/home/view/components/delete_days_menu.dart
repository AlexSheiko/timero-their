import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class DeleteDaysMenu extends StatefulWidget {
  const DeleteDaysMenu(this.goal, this.setCardState, {Key? key})
      : super(key: key);

  final Goal goal;
  final Function(FrontLayerState) setCardState;

  @override
  State<DeleteDaysMenu> createState() => _DeleteDaysMenuState();
}

class _DeleteDaysMenuState extends State<DeleteDaysMenu> {
  bool deleteGoalOption = false;
  bool resetsOption = false;
  bool deleteCardOption = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.setCardState(FrontLayerState.initial),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            deleteGoalOption == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      optionsMenuButton(
                          text: "Cancel",
                          onPressed: () {
                            setState(() {
                              deleteGoalOption = false;
                            });
                          },
                          buttonColor: Colors.white,
                          textColor: ThemeColor.mainColorDark),
                      const SizedBox(width: 20),
                      optionsMenuButton(
                          text: "Confirm",
                          onPressed: () {
                            BlocProvider.of<GoalsCubit>(context)
                                .deleteDays(widget.goal.id);
                          },
                          buttonColor: Colors.white,
                          textColor: ThemeColor.mainColorDark),
                    ],
                  )
                : narrowButton(
                    text: 'Delete goal',
                    onPressed: () {
                      setState(() {
                        deleteGoalOption = true;
                        resetsOption = false;
                        deleteCardOption = false;
                      });
                    },
                    buttonColor: Colors.white,
                    textColor: const Color.fromRGBO(58, 58, 58, 1),
                  ),
            const SizedBox(height: 20),
            resetsOption == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      optionsMenuButton(
                          text: "Cancel",
                          onPressed: () {
                            setState(() {
                              resetsOption = false;
                            });
                          },
                          buttonColor: ThemeColor.mainColorDark,
                          textColor: Colors.white),
                      const SizedBox(width: 20),
                      optionsMenuButton(
                          text: "Confirm",
                          onPressed: () {
                            BlocProvider.of<GoalsCubit>(context)
                                .addReset(widget.goal);
                          },
                          buttonColor: ThemeColor.mainColorDark,
                          textColor: Colors.white),
                    ],
                  )
                : narrowButton(
                    text: 'Reset',
                    onPressed: () {
                      setState(() {
                        resetsOption = true;
                        deleteGoalOption = false;
                        deleteCardOption = false;
                      });
                    },
                    buttonColor: const Color.fromRGBO(58, 58, 58, 1),
                    textColor: Colors.white,
                  ),
            const SizedBox(height: 20),
            deleteCardOption == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      optionsMenuButton(
                          text: "Cancel",
                          onPressed: () {
                            setState(() {
                              deleteCardOption = false;
                            });
                          },
                          buttonColor: ThemeColor.confirmRejectColor,
                          textColor: ThemeColor.mainColorDark),
                      const SizedBox(width: 20),
                      optionsMenuButton(
                          text: "Confirm",
                          onPressed: () {
                            BlocProvider.of<GoalsCubit>(context)
                                .deleteGoals(widget.goal);
                          },
                          buttonColor: ThemeColor.confirmRejectColor,
                          textColor: ThemeColor.mainColorDark),
                    ],
                  )
                : narrowButton(
                    text: 'Delete',
                    onPressed: () {
                      setState(() {
                        deleteCardOption = true;
                        resetsOption = false;
                        deleteGoalOption = false;
                      });
                    },
                    buttonColor: ThemeColor.buttonMainColor,
                    textColor: const Color.fromRGBO(58, 58, 58, 1),
                  ),
          ],
        ),
      ),
    );
  }
}
