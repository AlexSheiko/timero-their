part of 'goal_card.dart';

class FrontLayer extends StatefulWidget {
  const FrontLayer(this.goal, this.cardState, this.setCardState, {Key? key})
      : super(key: key);

  final Goal goal;
  final FrontLayerState cardState;
  final Function(FrontLayerState) setCardState;

  @override
  State<FrontLayer> createState() => _FrontLayerState();
}

class _FrontLayerState extends State<FrontLayer> {
  @override
  Widget build(BuildContext context) {
    final setCardState = widget.setCardState;
    if (widget.cardState == FrontLayerState.isSetNameMenuOpen) {
      return SetNameMenu(widget.goal, setCardState);
    } else if (widget.cardState == FrontLayerState.initial) {
      return Container();
    } else if (widget.cardState == FrontLayerState.isAddDaysMenuOpen) {
      return AddDaysMenu(widget.goal, setCardState);
    } else if (widget.cardState == FrontLayerState.isEditDaysMenuOpen) {
      return EditDaysMenu(widget.goal, setCardState);
    } else if (widget.cardState == FrontLayerState.isDeleteDaysMenuOpen) {
      return DeleteDaysMenu(widget.goal, setCardState);
    } else {
      return Container();
    }
  }
}

// _editDaysMenu(BuildContext context, Goal goal, Function setCardState) {
//   final TextEditingController goalController = TextEditingController();
//   String hintText = 'Type amount of days';
//   FocusNode focusNode = FocusNode();
//   return GestureDetector(
//     onTap: () => setCardState(FrontLayerState.initial),
//     child: Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(15)),
//         color: Colors.white,
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 14.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 12),
//             child: TextField(
//               focusNode: focusNode,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               controller: goalController,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintStyle: const TextStyle(
//                   color: Color.fromRGBO(58, 58, 58, 1),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 16,
//                   fontFamily: ThemeFontFamily.montserratRegular,
//                 ),
//                 hintText: hintText,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           narrowButton(
//             text: 'Add goal',
//             onPressed: () {
//               if (goalController.text.isNotEmpty) {
//                 BlocProvider.of<GoalsCubit>(context)
//                     .addDays(goalController.text, goal.id);
//                 setCardState(FrontLayerState.initial);
//               } else {
//                 null;
//               }
//             },
//             buttonColor: const Color.fromRGBO(58, 58, 58, 1),
//             textColor: Colors.white,
//           ),
//           const SizedBox(height: 20),
//           narrowButton(
//             text: 'Cancel',
//             onPressed: () {
//               setCardState(FrontLayerState.isAddDaysMenuOpen);
//             },
//             buttonColor: ThemeColor.buttonMainColor,
//             textColor: const Color.fromRGBO(58, 58, 58, 1),
//           ),
//         ],
//       ),
//     ),
//   );
// }
