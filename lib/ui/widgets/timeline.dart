import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Timeline extends StatefulWidget {
  final int activeIndex;
  final double height;
  final int itemCount;
  final Widget Function(int index) callback;

  const Timeline(
      {Key? key,
      required this.activeIndex,
      required this.height,
      required this.itemCount,
      required this.callback})
      : super(key: key);

  @override
  TimelineState createState() => TimelineState();
}

class TimelineState extends State<Timeline> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    int offset = -1;
    if (widget.activeIndex >= 0) {
      offset = 0;
    }
    if (widget.activeIndex > 3) {
      offset = widget.activeIndex - 3;
    }
    if (widget.activeIndex > widget.itemCount - 3) {
      offset = widget.activeIndex;
    }

    if (offset >= 0) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollController.jumpTo(index: offset));
    }

    return SizedBox(
      height: widget.height,
      child: Scrollbar(
        child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemScrollController: _scrollController,
          itemCount: widget.itemCount,
          itemBuilder: (context, index) {
            return widget.callback(index);
          },
        ),
      ),
    );
  }
}
