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
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrine/app.dart';
import 'package:shrine/product.dart';

class AddProductPage extends StatefulWidget {
  final ApplicationLoginState loginState ;
  const AddProductPage({Key? key, required this.loginState}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ApplicationLoginState get loginState => widget.loginState;

  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void upDownScroll(double size){
    _scrollController.animateTo(size,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease
    );
  }

  PickedFile? _image;
  Future getImageFromGallery() async {
    // for gallery
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }

  Future<DocumentReference> addProduct(Product product) {
    if (loginState == ApplicationLoginState.loggedOut) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('product')
        .add(<String, dynamic>{
      'id': product.id,
      'likeNum': product.likeNum,
      'name': product.name,
      'price': product.price,
      'timestamp' : DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _boxContents = ButtonBar(
      children: [
        IconButton(
          onPressed: () {
            getImageFromGallery();
          },
          icon: Icon(
            Icons.camera_alt,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ]
    );

  return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text('Add'),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              print('save') ;
              if(_image == null){
                _image = Image.asset('assets/logo.png') as PickedFile? ;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 250),
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Container(
                color: Colors.grey[300],
                height: 300.0,
                child:  _image == null
                ? const Center(
                    child: Icon(
                      Icons.image_rounded,
                      color: Colors.grey,
                      size: 120,
                    ),
                  )
                : Image.file(
                    File(_image!.path),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              _boxContents,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: TextField(
                  controller : _productNameController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: TextStyle(
                      color : Color(0xff255F99),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  onTap:() => upDownScroll(5.0),
                  onEditingComplete: () => upDownScroll(-5.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: TextField(
                  // style: TextStyle(color: Color(0xff486DAF)),
                  controller : _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Price',
                    hintStyle: TextStyle(color : Color(0xff96A5B0)),
                  ),
                  onTap:() => upDownScroll(55.0),
                  onEditingComplete: () => upDownScroll(-55.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color : Color(0xff96A5B0)),
                  ),
                  onTap:() => upDownScroll(150.0),
                  onEditingComplete: () => upDownScroll(-150.0),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}