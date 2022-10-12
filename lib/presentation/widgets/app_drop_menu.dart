import 'package:flutter/material.dart';
import 'app_text.dart';

class AppDropMenu<T> extends StatefulWidget {
  final List<T> items;
  final Function(T?) onChanged;
  final String hint;
  final T? initialValue;
  final bool isBordered;
  final double radius;
  final bool expanded;
  final Color? backgroundColor;
  final bool centerHint;

  const AppDropMenu({
    this.initialValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isBordered = false,
    this.radius = 8,
    this.expanded = false,
    Key? key,
    this.backgroundColor,
    this.centerHint = false,
  }) : super(key: key);

  @override
  State<AppDropMenu<T>> createState() => AppDropMenuState<T>();
}

class AppDropMenuState<T> extends State<AppDropMenu<T>> {
  T? selectedItem;

  @override
  void initState() {
    selectedItem = widget.initialValue;
    super.initState();
  }

  void clearSelection() {
    setState(() {
      selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: widget.isBordered
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              border: Border.all(color: Colors.black),
              color: widget.backgroundColor ?? Colors.white,
            )
          : BoxDecoration(color: widget.backgroundColor ?? Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<T>(
        value: selectedItem,
        hint: Align(
          alignment:
              widget.centerHint ? AlignmentDirectional.center : AlignmentDirectional.centerStart,
          child: AppText(
            selectedItem == null ? widget.hint : selectedItem.toString(),
            fontSize: 14,
            maxLines: 2,
            centerText: true,
          ),
        ),
        isExpanded: widget.expanded,
        iconEnabledColor: Colors.black,
        iconSize: 25,
        icon: Icon(Icons.keyboard_arrow_down),
        // iconEnabledColor: Theme.of(context).primaryColor,
        underline: const SizedBox(),
        items: widget.items.isEmpty
            ? []
            : widget.items
                .map(
                  (e) => DropdownMenuItem<T>(
                    child: AppText(e.toString(), fontSize: 14, fontWeight: FontWeight.w700),
                    value: widget.items[widget.items.indexOf(e)],
                  ),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            selectedItem = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}
