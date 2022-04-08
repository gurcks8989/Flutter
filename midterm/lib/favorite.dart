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

class FavoritePage extends StatefulWidget {
  final List<Hotel> hotels ;
  const FavoritePage({Key? key, required this.hotels}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favorite Hotels'),
      ),
      body: ListView.builder(
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          if(!widget.hotels[index].isFavorite) {
            return Container() ;
          }
          final _hotel = widget.hotels[index];
          return Dismissible(
            key: Key(_hotel.name),
            onDismissed: (direction) {
              setState(() {
                widget.hotels[index].isFavorite = false ;
              });
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(_hotel.name),
            ),
          );
        },
      ),
    );
  }
}