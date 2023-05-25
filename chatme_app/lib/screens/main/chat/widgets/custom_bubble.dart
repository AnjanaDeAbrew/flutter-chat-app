import 'package:dude/components/custom_text.dart';
import 'package:flutter/material.dart';

class CustomBubbleSpecialOne extends StatelessWidget {
  final bool isSender;
  final String text;
  final String time;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;

  const CustomBubbleSpecialOne({
    Key? key,
    this.isSender = true,
    required this.text,
    required this.time,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 16,
        color: Color.fromARGB(255, 181, 181, 181),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all_rounded,
        size: 16,
        color: Color.fromARGB(255, 74, 144, 241),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Container(
          decoration: isSender
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 188, 118, 235),
                      Color(0xff9159E6),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(0.0),
                  ),
                )
              : const BoxDecoration(
                  color: Color(0xffE5E5EA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            margin: isSender
                ? const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5)
                : const EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 1, right: 62, top: 0, bottom: 9),
                  child: Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Positioned(
                  bottom: -1,
                  right: 0,
                  child: Row(
                    children: [
                      CustomText(
                        time,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                        color: isSender
                            ? const Color.fromARGB(255, 199, 199, 199)
                            : const Color.fromARGB(255, 103, 103, 103),
                      ),
                      const SizedBox(width: 5),
                      stateIcon != null && stateTick
                          ? stateIcon
                          : const SizedBox(
                              width: 1,
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
