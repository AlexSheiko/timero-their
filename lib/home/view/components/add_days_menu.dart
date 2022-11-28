import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class AddDaysMenu extends StatefulWidget {
  const AddDaysMenu(this.goal, this.setCardState, {Key? key}) : super(key: key);

  final Goal goal;
  final Function(FrontLayerState) setCardState;

  @override
  State<AddDaysMenu> createState() => _AddDaysMenuState();
}

class _AddDaysMenuState extends State<AddDaysMenu> {
  bool resetsOption = false;
  bool deleteCardOption = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            narrowButton(
              text: 'Add goal',
              onPressed: () {
                widget.setCardState(FrontLayerState.isEditDaysMenuOpen);
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
                          text: 'Cancel',
                          onPressed: () {
                            setState(() {
                              resetsOption = false;
                            });
                          },
                          buttonColor: ThemeColor.mainColorDark,
                          textColor: Colors.white),
                      const SizedBox(width: 20),
                      optionsMenuButton(
                          text: 'Confirm',
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
                          text: 'Cancel',
                          onPressed: () {
                            setState(() {
                              deleteCardOption = false;
                            });
                          },
                          buttonColor: ThemeColor.confirmRejectColor,
                          textColor: ThemeColor.mainColorDark),
                      const SizedBox(
                        width: 20,
                      ),
                      optionsMenuButton(
                          text: 'Confirm',
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
