import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class MeetingOptions extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOptions(
      {Key? key,
      required this.text,
      required this.isMute,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Switch.adaptive(
            value: isMute,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
