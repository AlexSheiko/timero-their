import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class SetNameMenu extends StatefulWidget {
  const SetNameMenu(this.goal, this.setCardState, {Key? key}) : super(key: key);

  final Goal goal;
  final Function(FrontLayerState) setCardState;

  @override
  State<SetNameMenu> createState() => _SetNameMenuState();
}

class _SetNameMenuState extends State<SetNameMenu> {
  final TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String hintText = 'Type name here';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: TextField(
              focusNode: focusNode,
              style: const TextStyle(
                  decoration: TextDecoration.none, decorationThickness: 0),
              maxLength: 20,
              textAlign: TextAlign.center,
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 10, left: 10),
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(58, 58, 58, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
                hintText: hintText,
              ),
            ),
          ),
          const SizedBox(height: 20),
          narrowButton(
            text: 'Create',
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                BlocProvider.of<GoalsCubit>(context)
                    .addName(nameController.text, widget.goal.id);
                widget.setCardState(FrontLayerState.initial);
              } else {
                null;
              }
            },
            buttonColor: const Color.fromRGBO(58, 58, 58, 1),
            textColor: Colors.white,
          ),
          const SizedBox(height: 20),
          narrowButton(
            text: 'Cancel',
            onPressed: () {
              BlocProvider.of<GoalsCubit>(context).deleteGoals(widget.goal);
            },
            buttonColor: ThemeColor.buttonMainColor,
            textColor: const Color.fromRGBO(58, 58, 58, 1),
          ),
        ],
      ),
    );
  }
}
