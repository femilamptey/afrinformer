
import 'package:afrinformer/virustracker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class SelectCountryDialog extends StatefulWidget {

  @override
  _SelectCountryDialogState createState() => _SelectCountryDialogState();

  LocalStorage storage = LocalStorage("countries");

}

class _SelectCountryDialogState extends State<SelectCountryDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Select a country.',
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: Theme
                .of(context)
                .textTheme
                .caption
                .color),
          ),
          SizedBox(height: 30),
          _buildCountryPicker(context)
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Done'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );;
  }

  double _kPickerItemHeight = 32.0;

  Widget _buildCountryPicker(BuildContext context) {
    List<String> countries = [];

    VirusTracker.countries.forEach((key, value) {
      if (value != -1) {
        countries.add(key);
      }
    });

    int _selectedCountryIndex = countries.indexOf(widget.storage.getItem("country"));

    final FixedExtentScrollController scrollController =
    FixedExtentScrollController(initialItem: _selectedCountryIndex);

    return GestureDetector(
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoPicker(
                scrollController: scrollController,
                itemExtent: _kPickerItemHeight,
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (int index) async {
                  await widget.storage.setItem("country", "${countries[index]}");
                  print(widget.storage.getItem("country"));
                  setState(() {
                    _selectedCountryIndex = index;
                  });
                },
                children: List<Widget>.generate(
                    countries.length, (int index) {
                  return Center(
                    child: Text(countries[index],
                  ),
                  );
                }),
              ),
            );
          },
        );
      },
      child: _buildMenu(
        <Widget>[
          SizedBox(
            width: 200,
            height: 25,
            child: Text(
              countries[_selectedCountryIndex],
              style: TextStyle( color: CupertinoColors.inactiveGray),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    double _kPickerSheetHeight = 216.0;

    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoTheme
            .of(context)
            .scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
          bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
        ),
      ),
      height: 44.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: children,
          ),
        ),
      ),
    );
  }


}