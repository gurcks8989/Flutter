// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'model/hotels_repository.dart';
import 'model/hotel.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with RestorationMixin {
  final _checked = <bool>[false, false, false];
  final _filtersName = <String>['No Kids Zone', 'Pet-Friendly', 'Free breakfast'];
  bool isExpanded = false ;
  var dayData = ["dummy", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"] ;

  List<Hotel> hotels = HotelsRepository.loadHotels();

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  ) ;

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021, 1, 1),
          lastDate: DateTime(2022, 9, 9),
        );
      },
    );
  }

  late final RestorableRouteFuture<TimeOfDay?> _restorableTimePickerRouteFuture =
  RestorableRouteFuture<TimeOfDay?>(
    onComplete: _selectTime,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _timePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  ) ;

  static Route<TimeOfDay> _timePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return TimePickerDialog(
          restorationId: 'time_picker_dialog',
          initialEntryMode: TimePickerEntryMode.dial,
          initialTime: TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(arguments! as int)),
        );
      }
    ) ;
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_selectDate_picker_route_future');
    registerForRestoration(
        _restorableTimePickerRouteFuture, 'date_selectTime_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate ;
      });
    }
  }

  void _selectTime(TimeOfDay? newSelectedTime) {
    if (newSelectedTime != null) {
      setState(() {
        _selectedDate.value = _selectedDate.value.add(
          Duration(
            hours: newSelectedTime.hour,
            minutes: newSelectedTime.minute
          )
        ) ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Search'),
      ),
      body: ListView(
        children: <Widget> [
          ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded){
              setState(() {this.isExpanded = !isExpanded ;});
            },
            expandedHeaderPadding: EdgeInsets.zero,
            animationDuration: const Duration(milliseconds: 1000),
            children : [
              ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    contentPadding: EdgeInsets.only(left: 15, right: 120),
                    title: Text('Filter', style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Text('select fitters'),
                  );
                },
                isExpanded: isExpanded,
                body: Column(
                  children: List.generate(3, (index) =>
                    CheckboxListTile(
                      title: Text(_filtersName[index]),
                      value: _checked[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[index] = value!;
                        });
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  )
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const ListTile(
                  title: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                  title: const Text('🗓️check-in'),
                  subtitle: Text(
                    '${_selectedDate.value.year}.${_selectedDate.value.month}.${_selectedDate.value.day} (${dayData[_selectedDate.value.weekday]})'
                    '\n${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(_selectedDate.value.millisecondsSinceEpoch))}'
                  ),
                  trailing: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.blue[300];
                        } else {
                          return Colors.blue[100];
                        }
                      }),
                    ),
                    onPressed: () {
                      _restorableTimePickerRouteFuture.present() ;
                      _restorableDatePickerRouteFuture.present() ;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: const Text('select date',
                        style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 130.0, vertical: 5.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))
            ),
          ),
          child: const Text('Search', style: TextStyle(fontSize: 20)),
          onPressed: () =>
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    title: Column(
                      children: <Widget>[
                        Text("Dialog Title"),
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Dialog Content",
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text("확인"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
