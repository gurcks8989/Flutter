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

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'model/hotel.dart';


class DetailPage extends StatefulWidget {
  final Hotel hotel ;
  const DetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _starIcon = const Icon(Icons.star, color: Colors.yellow, size: 30) ;
  final _starOutlineIcon = const Icon(Icons.star_outline, color: Colors.yellow, size: 30) ;

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if(widget.hotel.star == 3) ... [_starIcon, _starIcon, _starIcon]
              else if(widget.hotel.star == 2) ... [_starIcon, _starIcon, _starOutlineIcon]
              else if(widget.hotel.star == 1) ... [_starIcon, _starOutlineIcon, _starOutlineIcon]
              else ... [_starOutlineIcon, _starOutlineIcon, _starOutlineIcon],
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  widget.hotel.name,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2068a8),
                  ),
                  speed: const Duration(milliseconds: 300),
                ),
              ],

              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 500),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            )
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue[300],
              ),
              const SizedBox(width: 10.0),
              Text(
                widget.hotel.address,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              Icon(
                Icons.phone_enabled,
                color: Colors.blue[300],
              ),
              const SizedBox(width: 10.0),
              Text(
                widget.hotel.phone,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    Widget textSection = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        widget.hotel.content,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Hero(
                tag: 'hotels-${widget.hotel.id}',
                child: Material(
                  child: InkWell(
                    child: Image.asset(
                      'assets/hotels-${widget.hotel.id}.jpg',
                      width: 600,
                      height: 270,
                      fit: BoxFit.cover,
                    ),
                    onDoubleTap: (){
                      setState(() {
                        widget.hotel.isFavorite = !widget.hotel.isFavorite ;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              titleSection,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Divider(color: Colors.grey),
              ),
              textSection,
              const SizedBox(height: 20.0),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.topRight,
            child: Icon(
              widget.hotel.isFavorite ? Icons.favorite : Icons.favorite_border ,
              color: Colors.red[700],
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}