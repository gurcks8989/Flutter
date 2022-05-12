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
import 'package:provider/provider.dart';
import 'package:shrine/app.dart';
import 'package:shrine/home.dart';
import 'package:shrine/product.dart';

import 'applicationState.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _productNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  late ScrollController _scrollController;
  late String defaultImage ;

  @override
  void initState() {
    print('init') ;
    _scrollController = ScrollController();
    getDefaultImage() ;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _productNameController.dispose() ;
    _priceController.dispose() ;
    _descriptionController.dispose() ;
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

  Future<String> getDefaultImage() {
    return FirebaseFirestore.instance
        .collection('initialize')
        .doc('productDefaultImage')
        .get().then(
          (doc) => defaultImage = doc['logo'] as String,
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {

    const _productNameStyle =  TextStyle(
      color : Color(0xff255F99),
      fontWeight: FontWeight.w900,
    ) ;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        leadingWidth: 70,
        centerTitle: true,
        title: const Text('Add'),
        actions: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => TextButton(
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                print(appState.loginState);
                _image == null
                ? appState.addProduct(_productNameController.text, int.parse(_priceController.text), _descriptionController.text, defaultImage)
                : appState.addProduct(_productNameController.text, int.parse(_priceController.text), _descriptionController.text, _image!.path)
                .then((value) => Navigator.pop(context)) ;
              },
            ),
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
                child: _image == null
                ? const Center(
                    child: Icon(
                      Icons.image_rounded,
                      color: Colors.grey,
                      size: 120,
                    ),
                  )
                : Image.file(
                  File(_image!.path),
                  width: 600,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              ButtonBar(
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: TextField(
                  controller : _productNameController,
                  decoration: const InputDecoration(
                    hintText: 'Product Name',
                    hintStyle: _productNameStyle,
                  ),
                  style: _productNameStyle,
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
                    prefixText: '\$ ',
                    hintText: 'Price',
                    hintStyle: TextStyle(color : Color(0xff96A5D1)),
                  ),
                  style: const TextStyle(
                    color : Color(0xff96A5D1),
                    fontSize: 20,
                  ),
                  onTap:() => upDownScroll(55.0),
                  onEditingComplete: () => upDownScroll(-55.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: TextField(
                  minLines: 1,
                  maxLines: 10,
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color : Color(0xff96A5D1)),
                  ),
                  style: const TextStyle(color : Color(0xff96A5D1)),
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