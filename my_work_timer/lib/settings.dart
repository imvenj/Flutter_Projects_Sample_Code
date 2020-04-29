import 'package:flutter/material.dart';
import 'package:my_work_timer/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings')
      ),
      body: Container(
        child: Settings()
      )
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final textStyle = TextStyle(fontSize: 24);
  TextEditingController txtWork;
  TextEditingController txtShort;
  TextEditingController txtLong;

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';
  int workTime;
  int shortBreak;
  int longBreak;

  SharedPreferences prefs;

  final double buttonSize = 100;

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME);
    shortBreak = prefs.getInt(SHORTBREAK);
    longBreak = prefs.getInt(LONGBREAK);
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          shortBreak = prefs.getInt(SHORTBREAK);
          shortBreak += value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtShort.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          longBreak = prefs.getInt(LONGBREAK);
          longBreak += value;
          if (longBreak >= 1 && longBreak <= 120) {
            prefs.setInt(LONGBREAK, longBreak);
            setState(() {
              txtLong.text = longBreak.toString();
            });
          }
        }
        break;
    }
  }

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text('Work', style: textStyle),
          Text(''),
          Text(''),
          SettingButton(Color(0xff455864), '-', buttonSize, -1, WORKTIME, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork
          ),
          SettingButton(Color(0xff009688), '+', buttonSize, 1, WORKTIME, updateSetting),
          Text('Short', style: textStyle),
          Text(''),
          Text(''),
          SettingButton(Color(0xff455864), '-', buttonSize, -1, SHORTBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort
          ),
          SettingButton(Color(0xff009688), '+', buttonSize, 1, SHORTBREAK, updateSetting),
          Text('Long', style: textStyle),
          Text(''),
          Text(''),
          SettingButton(Color(0xff455864), '-', buttonSize, -1, LONGBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong
          ),
          SettingButton(Color(0xff009688), '+', buttonSize, 1, LONGBREAK, updateSetting),
        ],
        padding: EdgeInsets.all(20)
      )
    );
  }
}