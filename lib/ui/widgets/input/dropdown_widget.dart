import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> nameList;
  String? currentValue;
  ValueChanged<String?>? onChanged;

  DropdownWidget(
      {Key? key, required this.nameList, this.onChanged, this.currentValue})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    if (widget.currentValue != null && widget.nameList.contains(widget.currentValue)) {
      dropdownValue = widget.currentValue as String;
    } else {
      dropdownValue = widget.nameList.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      isExpanded: true,
      items: widget.nameList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onChanged!(value);
      },
    );
  }
}
