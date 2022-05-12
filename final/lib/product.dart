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

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app.dart';


class ProductElement {
  const ProductElement({
    required this.docId,
    required this.userId,
    required this.likeNum,
    required this.name,
    required this.price,
    required this.description,
    required this.creationTime,
    required this.updateTime,
    required this.path,
  });

  final String docId;
  final String userId;
  final int likeNum;
  final String name;
  final int price;
  final String description;
  final Timestamp creationTime;
  final Timestamp updateTime;
  final String path;
}

class Product extends StatefulWidget{
  const Product({
    required this.addProduct,
    required this.products,
    required this.editProduct,
    required this.deleteProductInServer,
    required this.alreadyLikeCheck,
    required this.increaseLike,
    required this.getCurrentUserId,
  });

  final FutureOr<void> Function(String name, int price, String description, String path) addProduct;
  final FutureOr<void> Function(String docId, String name, int price, String description, String path) editProduct;
  final FutureOr<void> Function(String docId) deleteProductInServer;
  final FutureOr<void> Function(String docId) alreadyLikeCheck;
  final FutureOr<void> Function(String docId) increaseLike;
  final FutureOr<void> Function() getCurrentUserId;
  final List<ProductElement> products;

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String userId = FirebaseAuth.instance.currentUser!.uid ;
  String dropdownValue = 'ASC';

  Card getProductCard(int i){
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
      decimalDigits: 0
    );
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 6.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 15 / 10,
            child: Hero(
              tag: 'product-${widget.products[i].docId}',
              child: Image.file(
                File(widget.products[i].path),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 6),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.products[i].name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            alignment: Alignment.centerLeft,
            child: Text(
              formatter.format(widget.products[i].price),
              // '\$ ${widget.products[i].price}',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.bottomRight,
              width: 300,
              height: 200,
              margin: const EdgeInsets.only(right: 8.0, bottom: 5.0),
              child: TextButton(
                child: const Text('more'),
                style: TextButton.styleFrom(
                  minimumSize: Size.zero, // Set this
                  padding: EdgeInsets.zero, // and this
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    routeDetail,
                    arguments: widget.products[i],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(fontSize: 13, color: Colors.black),
            underline: Container(
              height: 0.5,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['ASC', 'DESC']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                // Create a grid with 2 columns in portrait mode, or 3 columns in
                // landscape mode.
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                // Generate 100 widgets that display their index in the List.
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                childAspectRatio: 8.0 / 9.0,
                children: [
                  if(dropdownValue == 'ASC')...[
                    for(var i = 0 ; i < widget.products.length ; i++)...[
                      getProductCard(i)
                    ]
                  ]
                  else...[
                    for(var i = widget.products.length -1 ; 0 <= i ; i--)...[
                      getProductCard(i)
                    ]
                  ]
                ]
              );
            },
          ),
        )
      ],
    );
  }
}
