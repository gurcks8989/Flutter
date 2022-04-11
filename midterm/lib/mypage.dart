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
import 'package:lottie/lottie.dart';
import 'model/hotels_repository.dart';
import 'model/hotel.dart';
import 'app.dart';
import 'package:intl/intl.dart';

class MyPage extends StatefulWidget {
  final List<Hotel> hotels ;
  const MyPage({Key? key, required this.hotels}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  List<Card> _buildCards(BuildContext context) {
    return widget.hotels.map((hotel) {
      if(!hotel.isFavorite) {
        return const Card(margin: EdgeInsets.zero) ;
      }
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 18 / 10,
              child: Hero(
                tag: 'hotels-${hotel.id}',
                child: Material(
                  child: InkWell(
                    child: Image.asset(
                      'assets/hotels-${hotel.id}.jpg',
                      fit: BoxFit.fill,
                    ),
                    onTap: () =>
                      Navigator.pushNamed(
                        context,
                        routeDetail,
                        arguments: hotel,
                      ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: AspectRatio(
                aspectRatio: 18 / 10,
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  alignment: Alignment.bottomLeft,
                  child: ListTile(
                    title: Text(
                      hotel.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      hotel.address,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context) ;
                Navigator.pushNamed(
                  context,
                  routeDetail,
                  arguments: hotel,
                ) ;
              }
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: ClipOval(
                child: Container(
                  width: 150,
                  color: Colors.redAccent,
                  child: Lottie.asset('assets/lf20_kd5rzej5.json'),
                ),
              ),
            ),
            const ListTile(
              title: Center(child: Text('Hyeokchan Kwon', style: TextStyle(fontWeight: FontWeight.bold))),
              subtitle: Center(child: Text('21700057')),
            ),
            const ListTile(
              title: Text(
                'My Favorite Hotel List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                children: _buildCards(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}