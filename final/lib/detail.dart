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

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';
import 'product.dart';
import 'app.dart';

class DetailPage extends StatelessWidget {
  final ProductElement product ;
  DetailPage({Key? key, required this.product}) : super(key: key);
  final dateFormate = DateFormat("yy.MM.dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString(),
        decimalDigits: 0
    );
    var isExist = 0 ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Detail'),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => ButtonBar(
              children : [
                if(product.userId == appState.getCurrentUserId())...[
                  IconButton(
                    icon: const Icon(Icons.create),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      routeEditProduct,
                      arguments: product,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => {
                      Navigator.pop(context),
                      appState.deleteProductInServer(product.docId),
                    }
                  ),
                ]
                else...[Container()]
              ]
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'product-${product.docId}',
              child: Material(
                child: InkWell(
                  child: Image.file(
                    File(product.path),
                    width: 600,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      color : Color(0xff255F99),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      children: [
                        IconButton(
                          onPressed: (){
                            appState.alreadyLikeCheck(product.docId)
                              .then((value) => value != 0
                              ? ScaffoldMessenger
                                .of(context)
                                .showSnackBar(const SnackBar(content: Text('You can only do it once !!')))
                              : {
                                ScaffoldMessenger
                                .of(context)
                                .showSnackBar(
                                const SnackBar(content: Text('I LIKE IT !'))),
                                appState.increaseLike(product.docId),
                                isExist = 1,
                              }
                            );
                        },
                        icon: const Icon(
                          Icons.thumb_up,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${product.likeNum + isExist}',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
              child: Text(
                formatter.format(product.price),
                style: const TextStyle(
                  color : Color(0xff96A5D1),
                  fontSize: 20,
                )
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 55.0),
              child: Divider(color: Colors.grey),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 10),
              child: Text(
                product.description,
                softWrap: true,
                style: const TextStyle(
                  color : Color(0xff96A5D1),
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 130,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
              child: Text(
                'creator : <${product.userId}>\n'
                '${dateFormate.format(product.creationTime.toDate())} Created\n'
                '${dateFormate.format(product.updateTime.toDate())} Modified',
                softWrap: true,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      // Container(
      //   padding: const EdgeInsets.all(10.0),
      //   alignment: Alignment.topRight,
      //   child: Icon(
      //     widget.hotel.isFavorite ? Icons.favorite : Icons.favorite_border ,
      //     color: Colors.red[700],
      //     size: 30,
      //   ),
      // ),
    );
  }
}