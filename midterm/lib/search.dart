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


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with RestorationMixin {
  final _checked = <bool>[false, false, false];
  bool isExpanded = false ;
  var dayData = ["dummy", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"] ;

  List<Hotel> hotels = HotelsRepository.loadHotels();

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
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

  final RestorableTimeOfDay _selectedTime = RestorableTimeOfDay(const TimeOfDay(hour: 0, minute: 0)) ;
  late final RestorableRouteFuture<TimeOfDay?> _restorableTimePickerRouteFuture =
  RestorableRouteFuture<TimeOfDay?>(
    //onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _timePickerRoute,
        arguments: _selectedTime.value,
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
        return const TimePickerDialog(
          restorationId: 'time_picker_dialog',
          initialEntryMode: TimePickerEntryMode.dial,
          initialTime: TimeOfDay(hour: 0, minute: 0),
        );
      }
    ) ;
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
      _restorableDatePickerRouteFuture, 'date_selectDate_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate ;
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
      body: Center(
        child: ListView(
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
                      title: Text(
                        'Filter',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: Text('select fitters'),
                    );
                  },
                  isExpanded: isExpanded,
                  body: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text("No Kids Zone",),
                        value: _checked[0],
                        onChanged: (bool? value) {
                          setState(() {
                            _checked[0] = value! ;
                          });
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text("Pet-Friendly"),
                        value: _checked[1],
                        onChanged: (bool? value) {
                          setState(() {
                            _checked[1] = value! ;
                          });
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CheckboxListTile(
                        title: const Text("Free breakfast"),
                        value: _checked[2],
                        onChanged: (bool? value) {
                          setState(() {
                            _checked[2] = value! ;
                          });
                        },
                        contentPadding: const EdgeInsets.symmetric(horizontal: 100),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const ListTile(
                    title: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text('🗓️check-in'),
                    subtitle: Text(
                      '${_selectedDate.value.year}.${_selectedDate.value.month}.${_selectedDate.value.day} (${dayData[_selectedDate.value.weekday]})'
                      '\n${_selectedTime.value.hour}:${_selectedTime.value.minute} am'
                    ),
                    trailing: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                      },
                      child: const Text('select date'),
                    ),
                  ),
                  // Text(
                  //   '결과 : $_selectedDate',
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
