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
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final isExpanded = false ;
  List<Hotel> hotels = HotelsRepository.loadHotels();

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
            ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return const ListTile(
                  title: Text(
                    'Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              body: const ListTile(
                title: Text('select fitters'),
                subtitle:
                Text('To delete this panel, tap the trash can icon'),
                trailing: Icon(Icons.delete),
                // onTap: () {
                //   setState(() {
                //     //_data.removeWhere((Item currentItem) => item == currentItem);
                //   });
                // }
              ),
              isExpanded: isExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
