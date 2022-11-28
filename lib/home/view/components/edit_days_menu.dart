import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timero/app/view/classic_button.dart';
import 'package:timero/home/data/model/card_state.dart';
import 'package:timero/home/data/model/goal.dart';
import 'package:timero/home/logic/goals_cubit.dart';
import 'package:timero/theme/const_theme.dart';

class EditDaysMenu extends StatefulWidget {
  const EditDaysMenu(this.goal, this.setCardState, {Key? key})
      : super(key: key);

  final Goal goal;
  final Function(FrontLayerState) setCardState;

  @override
  State<EditDaysMenu> createState() => _EditDaysMenuState();
}

class _EditDaysMenuState extends State<EditDaysMenu> {
  final TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String hintText = 'Type name here';
  final TextEditingController goalController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextField(
                focusNode: focusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: goalController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(58, 58, 58, 1),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: ThemeFontFamily.montserratRegular,
                  ),
                  hintText: hintText,
                ),
              ),
            ),
            const SizedBox(height: 20),
            narrowButton(
              text: 'Add goal',
              onPressed: () {
                if (goalController.text.isNotEmpty) {
                  BlocProvider.of<GoalsCubit>(context)
                      .addDays(goalController.text, widget.goal.id);
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
                widget.setCardState(FrontLayerState.isAddDaysMenuOpen);
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
