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
