import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {

  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton({ @required this.color, @required this.text, @required this.onPressed, @required this.size });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;

  SettingButton(this.color, this.text, this.size, this.value,
    this.setting, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white)
      ),
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
    );
  }
}
