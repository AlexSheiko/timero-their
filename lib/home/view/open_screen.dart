import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timero/app/view/components/custom_loader_overlay.dart';
import 'package:timero/app/view/components/ui_views_states.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/home/view/goal_card.dart';
import 'package:timero/home/view/open_screen_premium.dart';
import 'package:timero/premium/logic/premium_cubit.dart';
import 'package:timero/settings/view/settings_screen.dart';
import 'package:timero/theme/const_theme.dart';
import 'package:timero/theme/custom_icons/custom_icon_plus_icons.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({this.doNotRedirectToPremium = false, super.key});

  final bool doNotRedirectToPremium;

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  void initState() {
    unawaited(context.read<GoalsCubit>().onPageOpened());
    unawaited(context.read<PremiumCubit>().onPageOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PremiumCubit, PremiumState>(
      listener: (context, state) {
        if (state is PremiumLoadSuccess) {
          if (state.hasPremium) {
            if (!widget.doNotRedirectToPremium) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OpenScreenPremium(),
                ),
              );
            }
          }
        } else if (state is PremiumLoadFailure) {
          showErrorMessage(context, state.errorMessage);
        }
        if (state is PremiumLoadInProgress) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      },
      child: CustomLoaderOverlay(
        child: Scaffold(
          backgroundColor: ThemeColor.backGrounColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(100, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color.fromRGBO(58, 58, 58, 1),
                  side: const BorderSide(
                      width: 0, color: ThemeColor.mainColorDark)),
              onPressed: () {
                unawaited(context.read<PremiumCubit>().purchase());
              },
              child: const FittedBox(
                child: Text(
                  'Buy me a coffee to unlock unlimited timers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: ThemeFontFamily.montserratBold,
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                FrontLayerState cardState = FrontLayerState.isSetNameMenuOpen;
                return Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: double.infinity,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (final goal in state.goals)
                        _setCardState(goal, cardState),
                      const SizedBox(height: 35),
                      BlocBuilder<GoalsCubit, GoalsState>(
                        builder: (context, state) {
                          final isSetNameMenuOpen = state is GoalsLoadSuccess &&
                              state.goals.isNotEmpty &&
                              state.goals.first.name.isEmpty;
                          return isSetNameMenuOpen
                              ? nothing
                              : plusButton(context, false);
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is GoalsStateInitial ||
                  (state is GoalsLoadSuccess && state.goals.isEmpty)) {
                return plusButton(context, true);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _setCardState(Goal goal, FrontLayerState cardState) {
  if ((goal.name.isNotEmpty &&
          cardState == FrontLayerState.isSetNameMenuOpen) ||
      (goal.goalDays != 0 && cardState == FrontLayerState.isEditDaysMenuOpen)) {
    cardState = FrontLayerState.initial;
  } else {
    if (goal.name.isEmpty) {
      cardState = FrontLayerState.isSetNameMenuOpen;
    } else if (goal.goalDays != 0) {
      cardState = FrontLayerState.isDeleteDaysMenuOpen;
    } else {
      cardState = FrontLayerState.isAddDaysMenuOpen;
    }
  }
  return GoalCard(
    key: ValueKey(goal),
    goal: goal,
    initialCardState: cardState,
  );
}

Widget plusButton(BuildContext context, bool enabled) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 80),
    child: Center(
      child: MaterialButton(
        onPressed: () {
          if (enabled) {
            BlocProvider.of<GoalsCubit>(context).addGoal(
              name: '',
            );
          } else {
            null;
          }
        },
        color: enabled == true ? Colors.white : ThemeColor.backGrounColor,
        padding: const EdgeInsets.all(10),
        elevation: enabled == true ? 3 : 0,
        shape: const CircleBorder(),
        child: Icon(
          CustomIconPlus.plus_svgrepo_com,
          size: 30,
          color: enabled == true
              ? ThemeColor.mainColorDark
              : ThemeColor.mainColorLight,
        ),
      ),
    ),
  );
}
