import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropdownButtonList extends StatefulWidget {
  final List<String> savedSymptoms;
  final Function(String) onSymptomSelected; // Callback function

  DropdownButtonList(
      {Key? key, required this.savedSymptoms, required this.onSymptomSelected})
      : super(key: key);

  @override
  State<DropdownButtonList> createState() => _DropdownButtonListState();
}

class _DropdownButtonListState extends State<DropdownButtonList> {
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text('Select Item'),
          items: widget.savedSymptoms
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              widget.onSymptomSelected(value!); // Call the callback function
            });
          },
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
