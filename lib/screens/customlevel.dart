import 'package:flutter/material.dart';
import 'thinker.dart';
import '../constant/color.dart';
import '../widgets/appbar.dart';
import '../widgets/custombutton.dart';

class CustomLevel extends StatefulWidget {
  const CustomLevel({super.key});

  @override
  State<CustomLevel> createState() => _CustomLevelState();
}

class _CustomLevelState extends State<CustomLevel> {
  String level = 'Custom';
  double noOfButtons = 3;
  double noOfNumbers = 3;
  double time = 2;
  double fail = 3;

  TextStyle textStyle = const TextStyle(
    color: alltexts,
    fontSize: 24,
    fontFamily: 'LilitaOne',
  );

  void onChangedButtons(double newValue) {
    setState(() {
      noOfButtons = newValue;
      noOfNumbers = ((noOfButtons * noOfButtons) / 3).round().toDouble();
    });
  }

  void onChangedNumbers(double newValue) {
    setState(() {
      noOfNumbers = newValue;
    });
  }

  void onChangedTime(double newValue) {
    setState(() {
      time = newValue;
    });
  }

  void onChangedFail(double newValue) {
    setState(() {
      fail = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: bg,
      appBar: CustomAppBar(
        actions: null,
        title: level,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // noOfButtons
              Text(
                "${noOfButtons.round()} by ${noOfButtons.round()} Squares",
                style: textStyle,
              ),
              Slider(
                value: noOfButtons,
                onChanged: onChangedButtons,
                min: 3,
                max: 8,
                divisions: 5,
                activeColor: bgbtn,
                inactiveColor: line,
              ),
              const SizedBox(
                height: 10,
              ),

              // noOfNumbers
              Text(
                " 1 to ${noOfNumbers.round()} numbers",
                style: textStyle,
              ),
              Slider(
                value: noOfNumbers,
                onChanged: onChangedNumbers,
                min: 3,
                max: ((noOfButtons * noOfButtons) / 2).roundToDouble(),
                divisions:
                    (((noOfButtons * noOfButtons) / 2) - 3).round().toInt(),
                activeColor: bgbtn,
                inactiveColor: line,
              ),
              const SizedBox(
                height: 10,
              ),

              // time
              Text("${time.round()} seconds delay", style: textStyle),
              Slider(
                value: time,
                onChanged: onChangedTime,
                min: 1,
                max: 8,
                divisions: 7,
                activeColor: bgbtn,
                inactiveColor: line,
              ),
              const SizedBox(
                height: 10,
              ),

              // fail
              Text("till ${fail.round()} fail", style: textStyle),
              Slider(
                value: fail,
                onChanged: onChangedFail,
                min: 3,
                max: 6,
                divisions: 3,
                activeColor: bgbtn,
                inactiveColor: line,
              ),
              const SizedBox(
                height: 40,
              ),

              levelButton('Custom', noOfButtons.round(), noOfNumbers.round(),
                  time.toInt(), fail.toInt()),
            ],
          ),
        ),
      ),
    ));
  }

  Widget levelButton(
      String level, int noOfButtons, int noOfNumbers, int time, int fail) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Thinker(
                    level: level,
                    noOfbuttons: noOfButtons,
                    noOfnumbers: noOfNumbers,
                    time: time * 1000,
                    noOfFail: fail,
                  )),
        );
      },
      child: CustomButton(
        text: level,
      ),
    );
  }
}
