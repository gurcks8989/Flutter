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

  @override
  Widget build(BuildContext context) {
    Widget _boxContents = IconButton(
      onPressed: () {
        getImageFromGallery();
      },
      icon: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
          child: Icon(
            Icons.camera,
            color: Theme.of(context).colorScheme.primary,
          )
      ),
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
            onPressed: () => Navigator.pushNamed(context, routeAddProduct),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              height: 300.0,
              child: Center(
                child: _image == null
                  ? const Icon(
                    Icons.image_rounded,
                    color: Colors.grey,
                    size: 120,
                  )
                  : Image.file(
                    File(_image!.path)
                  ),
                ),
              ),
            _boxContents,
          ],
        )
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}