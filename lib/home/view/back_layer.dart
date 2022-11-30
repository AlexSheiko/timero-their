part of 'goal_card.dart';

class BackLayer extends StatefulWidget {
  const BackLayer(this.goal, this.cardState, this.setCardState, this.wsize,
      {super.key});

  @override
  State<BackLayer> createState() => _BackLayerState();
  final Goal goal;
  final FrontLayerState cardState;
  final Function(FrontLayerState) setCardState;
  final Size wsize;
}

class _BackLayerState extends State<BackLayer> {
  bool isDetailsOpen = false;
  bool isGoalOpen = false;

  @override
  Widget build(BuildContext context) {
    final setCardState = widget.setCardState;
    return Card(
      borderOnForeground: false,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.goal.name,
                  style: TextStyle(
                    fontSize: widget.goal.name.length > 10 ? 17 : 24,
                    fontWeight: FontWeight.w700,
                    color: const Color.fromRGBO(58, 58, 58, 1),
                    fontFamily: ThemeFontFamily.montserratBold,
                  ),
                ),
                RawMaterialButton(
                  onPressed: () {
                    isDetailsOpen = false;
                    if (widget.goal.goalDays == 0) {
                      setCardState(FrontLayerState.isAddDaysMenuOpen);
                    } else {
                      setCardState(FrontLayerState.isDeleteDaysMenuOpen);
                    }
                  },
                  //_optionsCallback(setCardState, widget.goal),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.fromLTRB(7, 2, 7, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: ThemeColor.mainColorLight,
                  elevation: 0,
                  child: const Text(
                    'Options',
                    style: TextStyle(
                      fontSize: 12,
                      color: ThemeColor.mainColorDark,
                      fontFamily: ThemeFontFamily.montserratRegular,
                    ),
                  ),
                )
              ],
            ),
          ),
          _goalDetails(widget.goal, widget.wsize),
          const SizedBox(height: 10),
          const Text(
            'Time since last reset: ',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(58, 58, 58, 1),
              fontFamily: ThemeFontFamily.montserratRegular,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: ThemeColor.mainColorGreen,
              border: Border.all(
                color: ThemeColor.mainColorGreen,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            height: 30,
            constraints: BoxConstraints(
                minHeight: 30, minWidth: MediaQuery.of(context).size.width),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                _timeSinceLastReset(widget.goal),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: ThemeFontFamily.montserratBold,
                  fontSize: 14,
                  color: Color.fromRGBO(58, 58, 58, 1),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _history(
            widget.goal.startDate,
            widget.goal.resets,
            widget.wsize,
            widget.goal,
            isDetailsOpen,
            (newValue) {
              setState(() {
                isDetailsOpen = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  _history(
    DateTime startDate,
    List<DateTime> resets,
    Size size,
    Goal goal,
    bool isDetailsOpen,
    void Function(bool isDetailsOpen) setDetailsOpen,
  ) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Historic overview: ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(58, 58, 58, 1),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  isDetailsOpen
                      ? 'Click bar to minimize'
                      : 'Click bar to expand',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(58, 58, 58, 1),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setDetailsOpen(!isDetailsOpen);
            },
            child: SizedBox(
              height: 30,
              // width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resets.length + 1,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.only(right: 1),
                        decoration: BoxDecoration(
                          color: _calculateColor(index, resets.length),
                          border: Border.all(
                            color: Colors.white,
                            width: 0.25,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 30,
                        width: _calculateWidth(context, resets, index, goal));
                  }),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _parseDate(startDate),
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(58, 58, 58, 1),
              fontFamily: ThemeFontFamily.montserratRegular,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                child: SizedBox(
                    width: isDetailsOpen ? double.infinity : double.infinity,
                    height: isDetailsOpen
                        ? 65 * (resets.length).toDouble() + 30
                        : 0,
                    child: _historyDetails(isDetailsOpen, resets, goal))),
          ),
        ],
      ),
    );
  }

//
  Widget _historyDetails(
    isDetailsOpen,
    List<DateTime> resets,
    Goal goal,
  ) {
    if (isDetailsOpen) {
      if (resets.isNotEmpty) {
        return Center(
          child: Column(
            children: [
              Column(
                children: resets.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _textForDetails(resets, index),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(58, 58, 58, 1),
                          fontFamily: ThemeFontFamily.montserratRegular,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _daysForDetails(resets, index, goal),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(58, 58, 58, 1),
                          fontFamily: ThemeFontFamily.montserratBold,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                }).toList(),
              ),
              Text(
                'Date created: ${_parseDate(goal.startDate)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(58, 58, 58, 1),
                  fontFamily: ThemeFontFamily.montserratRegular,
                ),
              ),
            ],
          ),
        );
      } else {
        return const Center(
          child: Text(
            'No resets yet, nothing to show',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromRGBO(58, 58, 58, 1),
              fontFamily: ThemeFontFamily.montserratRegular,
            ),
          ),
        );
      }
    } else {
      return nothing;
    }
  }
}
