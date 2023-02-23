import 'package:flutter/material.dart';

class CustomStepperLine extends StatelessWidget {
  final bool isActiveColor;
  const CustomStepperLine(
      {Key? key,
        required this.isActiveColor
     })
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isActiveColor? Theme.of(context).primaryColor.withOpacity(.7):Theme.of(context).hintColor.withOpacity(0.3)
        ),
      ),
    );
  }
}
