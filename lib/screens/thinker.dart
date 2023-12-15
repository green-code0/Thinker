import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../constant/color.dart';
import '../widgets/appbar.dart';
import '../widgets/custombutton.dart';

class Thinker extends StatefulWidget {
  final String level;
  final int noOfbuttons;
  final int noOfnumbers;
  final int time;
  final int noOfFail;

  const Thinker(
      {super.key,
      required this.level,
      required this.noOfbuttons,
      required this.noOfnumbers,
      required this.time,
      required this.noOfFail});

  @override
  // ignore: library_private_types_in_public_api
  _ThinkerState createState() => _ThinkerState();
}

class _ThinkerState extends State<Thinker> {
  List<String> baseList = [];
  List<int> resultList = [];
  List<int> tempList = [];
  List<int> isTappedList = [];

  String level = '';
  String startbutton = 'Start';
  int fail = 0;
  int tapindex = 0;
  bool isHide = true;
  bool canTap = false;
  int myluck = 0;

  @override
  initState() {
    level = widget.level;
    initLists();
    super.initState();
  }

  initLists() {
    baseList = List.generate(widget.noOfbuttons * widget.noOfbuttons,
        (index) => index < widget.noOfnumbers ? (index + 1).toString() : '',
        growable: false);

    resultList = List.generate(widget.noOfnumbers, (index) => index + 1,
        growable: false);

    generateList();
  }

  start() {
    refresh();
    setState(() {});
  }

  Timer? timer;

  refresh() {
    baseList.shuffle();
    isHide = false;
    fail = 0;
    myluck = 1;
    tapindex = 0;
    canTap = false;
    startbutton = 'Again';
    generateList();

    timer = Timer(Duration(milliseconds: widget.time), () {
      setState(() {
        isHide = true;
        canTap = true;
      });
    });
  }

  generateList() {
    tempList = List.generate(widget.noOfnumbers, (index) => 0, growable: false);
    isTappedList = List.generate(
        widget.noOfbuttons * widget.noOfbuttons, (index) => 0,
        growable: false);
  }

  check(value, index) {
    if (value == '') {
      fail++;
      isTappedList[index] = -1;
    } else {
      value = int.parse(value);
      tempList[tapindex] = value;

      if (value == (tapindex + 1)) {
        tapindex++;
        isTappedList[index] = 1;
      }
    }

    if (fail >= widget.noOfFail) {
      _showdialog('Game Over', falsebtn);
      canTap = false;
    } else if (tempList[widget.noOfnumbers - 1] ==
        resultList[widget.noOfnumbers - 1]) {
      _showdialog('You win', truebtn);
      canTap = false;
    }

    setState(() {});
  }

  _showdialog(String title, Color titlecolor) => showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Scaffold(
              body: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 44,
                      height: 180,
                      decoration: BoxDecoration(
                        color: titlecolor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: titlecolor,
                              fontSize: 36,
                              fontFamily: 'LilitaOne',
                              fontWeight: FontWeight.bold,
                              shadows: const [
                                Shadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (title == 'Game Over') {
                                seeNumbers();
                              } else {
                                reset();
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: bgbtn,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: borderbtn,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  title == 'Game Over'
                                      ? 'See Numbers'
                                      : 'Clear',
                                  style: const TextStyle(
                                    color: alltexts,
                                    fontSize: 36,
                                    fontFamily: 'LilitaOne',
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black38,
                                        blurRadius: 10,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              backgroundColor: Colors.transparent);
        },
        animationType: DialogTransitionType.fade,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 100),
      );

  reset() {
    Navigator.of(context).pop();
    fail = 0;
    canTap = false;
    myluck = 0;
    tapindex = 0;
    startbutton = 'Start Again';
    generateList();
    setState(() {});
  }

  seeNumbers() {
    Navigator.of(context).pop();
    canTap = false;
    myluck = 0;

    for (var i = tapindex + 1; i <= widget.noOfnumbers; i++) {
      for (var j = 0; j < widget.noOfbuttons * widget.noOfbuttons; j++) {
        if (baseList[j] == i.toString()) {
          isTappedList[j] = 2;
        }
      }
    }

    setState(() {});
  }

  openNextNumber() {
    myluck = 0;
    for (var i = 0; i < widget.noOfbuttons * widget.noOfbuttons; i++) {
      if (baseList[i] == (tapindex + 1).toString()) {
        isTappedList[i] = 1;
        tempList[tapindex] = (tapindex + 1);
        tapindex++;
        break;
      }
    }

    if (fail >= widget.noOfFail) {
      _showdialog('Game Over', falsebtn);
      canTap = false;
    } else if (tempList[widget.noOfnumbers - 1] ==
        resultList[widget.noOfnumbers - 1]) {
      _showdialog('You win', truebtn);
      canTap = false;
    }

    setState(() {});
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        appBar: CustomAppBar(
          actions: _actions(),
          title: level,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.noOfFail; i++)
                  Icon(Icons.close_rounded,
                      color: i < fail ? falsebtn : cross, size: 30)
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: widget.noOfbuttons,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  padding: const EdgeInsets.all(10),
                  children: [
                    for (var i = 0;
                        i < widget.noOfbuttons * widget.noOfbuttons;
                        i++)
                      anybutton(baseList[i], i),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => start(),
              child: CustomButton(
                text: startbutton,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget>? _actions() => [
        GestureDetector(
            onTap: () => myluck == 1 ? openNextNumber() : null,
            child: Stack(
              children: [
                const Icon(Icons.lightbulb_rounded, color: alltexts, size: 40),
                Positioned(
                    right: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: bgbtn,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: bg,
                            width: 2,
                          )),
                      child: Center(
                          child: Text(
                        myluck.toString(),
                        style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'LilitaOne',
                            color: alltexts),
                      )),
                    )),
              ],
            )),
        const SizedBox(width: 20),
      ];

  Widget anybutton(value, index) => GestureDetector(
        onTap: canTap ? () => check(value, index) : null,
        child: Container(
          decoration: BoxDecoration(
            color: isTappedList[index] == 1 || isTappedList[index] == 2
                ? truebtn
                : isTappedList[index] == -1
                    ? falsebtn
                    : allboxs,
            borderRadius: BorderRadius.circular(5),
            border: isTappedList[index] == 2
                ? Border.all(
                    color: falsebtn,
                    width: 2,
                  )
                : null,
          ),
          child: Center(
              child: Text(
                  isTappedList[index] == 1 ||
                          isTappedList[index] == 2 ||
                          !isHide
                      ? '$value'
                      : '',
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'LilitaOne',
                    color: alltexts,
                  ))),
        ),
      );
}
