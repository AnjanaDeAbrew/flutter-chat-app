import 'package:dude/components/custom_text.dart';
import 'package:flutter/material.dart';

const double BUBBLE_RADIUS_IMAGE = 16;

class CustomBubbleNormalImage extends StatelessWidget {
  static const loadingWidget = Center(
    child: CircularProgressIndicator(),
  );

  final String id;
  final String time;
  final Widget image;
  final double bubbleRadius;
  final bool isSender;
  final Color color;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final void Function()? onTap;

  const CustomBubbleNormalImage({
    Key? key,
    required this.id,
    required this.image,
    required this.time,
    this.bubbleRadius = BUBBLE_RADIUS_IMAGE,
    this.isSender = true,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.onTap,
  }) : super(key: key);

  /// image bubble builder method
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
        size: 18,
        color: Color.fromARGB(255, 120, 120, 120),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color.fromARGB(255, 101, 159, 240),
      );
    }

    return Row(
      children: <Widget>[
        isSender
            ? const Expanded(
                child: SizedBox(
                  width: 5,
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .5,
                maxHeight: MediaQuery.of(context).size.width * .5),
            child: GestureDetector(
                onTap: onTap ??
                    () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return _DetailScreen(
                          tag: id,
                          image: image,
                        );
                      }));
                    },
                child: Hero(
                  tag: id,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(bubbleRadius),
                            topRight: Radius.circular(bubbleRadius),
                            bottomLeft: Radius.circular(tail
                                ? isSender
                                    ? bubbleRadius
                                    : 0
                                : BUBBLE_RADIUS_IMAGE),
                            bottomRight: Radius.circular(tail
                                ? isSender
                                    ? 0
                                    : bubbleRadius
                                : BUBBLE_RADIUS_IMAGE),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(bubbleRadius),
                            child: image,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 8,
                        child: Row(
                          children: [
                            CustomText(
                              time,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.left,
                              color: Colors.white,
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
                )),
          ),
        )
      ],
    );
  }
}

/// detail screen of the image, display when tap on the image bubble
class _DetailScreen extends StatefulWidget {
  final String tag;
  final Widget image;

  const _DetailScreen({Key? key, required this.tag, required this.image})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

/// created using the Hero Widget
class _DetailScreenState extends State<_DetailScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: widget.tag,
            child: widget.image,
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
