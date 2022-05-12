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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'applicationState.dart';
import 'product.dart';
import 'app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
            onPressed: () => Navigator.pushNamed(
              context,
              routeAddProduct,
            ),
          ),
        ],
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _) => Product(
          addProduct: (name, price, description, path) =>
              appState.addProduct(name, price, description, path),
          editProduct: (docId, name, price, description, path) =>
              appState.editProduct(docId, name, price, description, path),
          deleteProductInServer: (docId) => appState.deleteProductInServer(docId),
          products: appState.productList,
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}