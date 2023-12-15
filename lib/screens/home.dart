import 'package:flutter/foundation.dart';
import 'package:thinker/constant/color.dart';
import 'package:thinker/screens/customlevel.dart';
import 'package:flutter/material.dart';
import 'thinker.dart';
import '../constant/styles.dart';
import '../widgets/custombutton.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Thinker',
                  style: textStyle(50),
                ),
                const SizedBox(
                  height: 10,
                ),
                levelButton('Very easy', 3, 3, 2000, 3),
                levelButton('Easy', 4, 5, 2000, 3),
                levelButton('Normal', 5, 7, 1500, 3),
                levelButton('Hard', 6, 10, 2000, 3),
                levelButton('Very Hard', 7, 10, 2500, 4),
                levelButton('Impossible ', 8, 16, 3000, 5),
                divider(),
                levelButton('Custom', 0, 0, 0, 0),
              ],
            ),
          ),
        ),
        bottomNavigationBar: myInstagram(),
      ),
    );
  }

  _launchURL(url) async {
    try {
      if (kIsWeb) {
        String withSlashweb = url + "/";
        // ignore: deprecated_member_use
        if (await canLaunch(withSlashweb)) {
          // ignore: deprecated_member_use
          await launch(withSlashweb);
        } else {
          throw 'Could not launch $withSlashweb';
        }
      } else {
        // ignore: deprecated_member_use
        if (!await canLaunch(url)) {
          // ignore: deprecated_member_use
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  Widget myInstagram() => Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        height: 50,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            _launchURL("https://www.instagram.com/greencode0_0");
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "instagram",
                  style: textStyle(8),
                ),
                Text(
                  "GreenCode0_0",
                  style: textStyle(18),
                ),
              ],
            ),
          ),
        ),
      );

  Widget divider() => const Divider(
        color: line,
        height: 25,
        thickness: 1,
        indent: 130,
        endIndent: 130,
      );

  Widget levelButton(
      String level, int noOfButtons, noOfNumbers, time, int fails) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => level == 'Custom'
                ? const CustomLevel()
                : Thinker(
                    level: level,
                    noOfbuttons: noOfButtons,
                    noOfnumbers: noOfNumbers,
                    time: time,
                    noOfFail: fails,
                  ),
          ),
        );
      },
      child: CustomButton(
        text: level,
      ),
    );
  }
}
