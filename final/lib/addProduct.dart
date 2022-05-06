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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shrine/app.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  PickedFile? _image;
  Future getImageFromGallery() async {
    // for gallery
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image!;
    });
  }
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

              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
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
            TextField(
              controller : _productNameController,
              decoration: InputDecoration(
                hintText: 'Product Name',
              ),
              onTap: (){
                //120만큼 500milSec 동안 뷰를 올려줌
                _scrollController.animateTo(500.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
            TextField(
              controller : _priceController,
              decoration: InputDecoration(
                hintText: 'Price',
              ),
              onTap: (){
                //120만큼 500milSec 동안 뷰를 올려줌
                _scrollController.animateTo(500.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease);
              },
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
              ),
              onTap: (){
                //120만큼 500milSec 동안 뷰를 올려줌
                _scrollController.animateTo(500.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}