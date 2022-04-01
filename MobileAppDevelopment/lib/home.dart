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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/products_repository.dart';
import 'model/product.dart';
import 'app.dart';

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
        margin: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        elevation: 4.0,
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
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.location_on,
                    color: Colors.lightBlue,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 6),
                        Row(
                          children: const [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 13,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3.0),
                        Text(
                          product.name,
                          style: theme.textTheme.subtitle2,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          formatter.format(product.price),
                          style: theme.textTheme.bodySmall,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 300,
                          child: TextButton(
                            child: const Text('more'),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.zero, // and this
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, routeDetail);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
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
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(width: 0.5, color: Colors.grey),
        ),
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(width: 12.0),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              width: 100,
              height: 100,
              alignment: Alignment.centerLeft,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                    product.assetName,
                    package: product.assetPackage,
                    fit: BoxFit.fill
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    Text(
                      product.name,
                      style: theme.textTheme.subtitle2,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.bodySmall,
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      width: 300,
                      child: TextButton(
                        child: const Text('more'),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero, // and this
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, routeDetail);
                        },
                      ),
                    )
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
              // TODO search
              Navigator.pushNamed(context, routeSearch);
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
                color: Colors.lightBlue,
              ),
              padding: EdgeInsets.only(top: 110.0, left: 40),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              leading: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: const Icon(Icons.home,
                  color: Colors.lightBlue,
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
                  color: Colors.lightBlue,
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
                  color: Colors.lightBlue,
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
                  color: Colors.lightBlue,
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
                  color: Colors.lightBlue,
                ),
              ),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, routeLogin);
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
                selectedColor: Colors.lightBlue,
                selectedBorderColor: Colors.lightBlue,
                fillColor: Colors.lightBlue.withOpacity(0.08),
                splashColor: Colors.lightBlue.withOpacity(0.12),
                hoverColor: Colors.lightBlue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(4.0),
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    if(isSelected[index==1 ? 0 : 1]){
                      isSelected[index==1 ? 0 : 1] = false ;
                      isSelected[index] = true ;
                    }
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
              child: isSelected[1]
              ? OrientationBuilder(
                builder: (context, orientation) {
                  return GridView.count(
                    // Create a grid with 2 columns in portrait mode, or 3 columns in
                    // landscape mode.
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    // Generate 100 widgets that display their index in the List.
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    childAspectRatio: 8.0 / 9.0,
                    children: _buildGridCards(context),
                  );
                },
              )
              : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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