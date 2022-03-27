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

import 'package:MobileAppDevelopment/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

const handongUrl = 'https://www.handong.edu/';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isSelected = <bool>[false, true];

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) {
      return const <Card>[];
    }
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Column(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: theme.textTheme.headline6,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }


  List<Card> _buildListCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);
    if (products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Row(
          // TODO: Center items on the card (103)
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 20,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // TODO: Align labels to the bottom and center (103)
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // TODO: Change innermost Column (103)
                  children: <Widget>[
                    // TODO: Handle overflowing labels (103)
                    Text(
                      product.name,
                      style: theme.textTheme.headline6,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
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
        title: const Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.push(
                context,
                // TODO search page
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          const IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'language',
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              child: Text(
                'Pages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              padding: EdgeInsets.only(top: 110.0, left: 40),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.home,
                  color: Colors.blue,
                ),
              ),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.search,
                  color: Colors.blue,
                ),
              ),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.location_city,
                  color: Colors.blue,
                ),
              ),
              title: Text('Favorite Hotel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.person,
                  color: Colors.blue,
                ),
              ),
              title: Text('My page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.logout,
                  color: Colors.blue,
                ),
              ),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerRight,
              child: ToggleButtons(
                color: Colors.black.withOpacity(0.60),
                selectedColor: const Color(0xFF6200EE),
                selectedBorderColor: const Color(0xFF6200EE),
                fillColor: const Color(0xFF6200EE).withOpacity(0.08),
                splashColor: const Color(0xFF6200EE).withOpacity(0.12),
                hoverColor: const Color(0xFF6200EE).withOpacity(0.04),
                borderRadius: BorderRadius.circular(4.0),
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    if(isSelected[index==1 ? 0 : 1]){
                      isSelected[index==1 ? 0 : 1] = false ;
                      isSelected[index] = true ;
                    }
                    print(isSelected[1]) ;
                  }
                  );
                },
                children: const [
                  Icon(Icons.list),
                  Icon(Icons.grid_view),
                ],
              ),
            ),
            Expanded(
              child: isSelected[1] ?
              OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.count(
                    // Create a grid with 2 columns in portrait mode, or 3 columns in
                    // landscape mode.
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    // Generate 100 widgets that display their index in the List.
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    childAspectRatio: 8.0 / 9.0,
                    children: _buildGridCards(context),
                  );
                },
              )
              : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: _buildListCards(context),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

void _launchURL() async {
  if (!await launch(handongUrl)) throw 'Could not launch $handongUrl';
}