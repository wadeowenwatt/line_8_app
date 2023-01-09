import 'package:flutter/material.dart';

class TabNotiBadgeWidget extends StatefulWidget {
  const TabNotiBadgeWidget({
    super.key,
    required int counter,
    required Icon icon, required this.labelTab,
  })
      : _counter = counter,
        _icon = icon;

  final String labelTab;
  final int _counter;
  final Icon _icon;


  @override
  State<TabNotiBadgeWidget> createState() => _TabNotiBadgeWidgetState();
}

class _TabNotiBadgeWidgetState extends State<TabNotiBadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Stack(
        children: <Widget>[
          widget._icon,
          Positioned(
            right: 0,
            child: Container(
              padding: widget._counter == 0
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget._counter == 0 ? '' : '${widget._counter}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
      text: widget.labelTab,
    );
  }
}
