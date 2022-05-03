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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shrine/app.dart';

import 'firebase_options.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // List<Card> _buildGridCards(BuildContext context) {
  //   if (hotels.isEmpty) {
  //     return const <Card>[];
  //   }
  //   final ThemeData theme = Theme.of(context);
  //   return hotels.map((hotel) {
  //     return Card(
  //       margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(10.0)
  //       ),
  //       elevation: 4.0,
  //       clipBehavior: Clip.antiAlias,
  //       child: Column(
  //         children: [
  //           AspectRatio(
  //             aspectRatio: 15 / 10,
  //             child: Hero(
  //               tag: 'hotels-${hotel.id}',
  //               child: Image.asset(
  //                 'assets/hotels-${hotel.id}.jpg',
  //                 fit: BoxFit.fill,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 6),
  //           Row(
  //             children: [
  //               const SizedBox(width: 25.0),
  //               if(hotel.star == 3) ... [_starIcon, _starIcon, _starIcon]
  //               else if(hotel.star == 2) ... [_starIcon, _starIcon, _starOutlineIcon]
  //               else if(hotel.star == 1) ... [_starIcon, _starOutlineIcon, _starOutlineIcon]
  //                 else ... [_starOutlineIcon, _starOutlineIcon, _starOutlineIcon],
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               const SizedBox(width: 25.0),
  //               Expanded(
  //                 child: Text(
  //                   hotel.name,
  //                   style: theme.textTheme.titleSmall,
  //                   maxLines: 1,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Expanded(
  //             child: Row(
  //               children: [
  //                 const SizedBox(width: 5.0),
  //                 const Icon(Icons.location_on, color: Colors.blue, size: 15),
  //                 const SizedBox(width: 5.0),
  //                 Text(
  //                   hotel.address,
  //                   style: const TextStyle(fontSize: 8),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.bottomRight,
  //             width: 300,
  //             margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
  //             child: TextButton(
  //               child: const Text('more'),
  //               style: TextButton.styleFrom(
  //                 minimumSize: Size.zero, // Set this
  //                 padding: EdgeInsets.zero, // and this
  //                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //               ),
  //               onPressed: () {
  //                 Navigator.pushNamed(
  //                   context,
  //                   routeDetail,
  //                   arguments: hotel,
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => Navigator.pushNamed(context, routeProfile),
        ),
        centerTitle: true,
        title: const Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, routeAddProduct),
          ),
        ],
      ),
      body: Center(
        child: Text('You did it!'),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}