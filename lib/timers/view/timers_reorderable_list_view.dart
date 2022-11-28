import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/home/view/goal_card.dart';
import 'package:timero/theme/const_theme.dart';
import 'package:timero/theme/custom_icons/custom_icon_plus_icons.dart';

import '../../home/view/open_screen.dart';

class TimersReorderableListView extends StatefulWidget {
  const TimersReorderableListView({required this.timers, super.key});

  final List<Goal> timers;

  @override
  State<TimersReorderableListView> createState() =>
      _TimersReorderableListViewState();
}

class _TimersReorderableListViewState extends State<TimersReorderableListView> {
  final controller = ScrollController();
  final reorderableController = ScrollController();
  final scrollViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FrontLayerState cardState = FrontLayerState.isSetNameMenuOpen;
    return ReorderableListView(
      scrollController: reorderableController,
      footer: Column(
        children: [
          BlocBuilder<GoalsCubit, GoalsState>(
            builder: (context, state) {
              final isSetNameMenuOpen = state is GoalsLoadSuccess &&
                  state.goals.isNotEmpty &&
                  state.goals.first.name.isEmpty;
              return isSetNameMenuOpen
                  ? const SizedBox()
                  : plusButton(context, false);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      const OpenScreen(doNotRedirectToPremium: true),
                ),
              );
            },
            child: const Text('Back'),
          )
        ],
      ),
      proxyDecorator: (child, _, __) => ProxyDecorator(child),
      onReorder: (int oldIndex, int newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        _reorderInLocalState(oldIndex, newIndex);
        _reorderInRemoteDatabase();
      },
      children: [
        for (final goal in widget.timers) _setCardState(goal, cardState),
      ],
    );
  }

  void _reorderInLocalState(int oldIndex, int newIndex) {
    setState(() {
      final timer = widget.timers.removeAt(oldIndex);
      widget.timers.insert(newIndex, timer);
    });
  }

  void _reorderInRemoteDatabase() {
    context.read<GoalsCubit>().saveGoalsOrder(widget.timers);
  }
}

class ProxyDecorator extends StatelessWidget {
  const ProxyDecorator(this.child, {super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 16,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            elevation: 0,
          ),
        ),
        child,
      ],
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
