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

class Hotel {
  Hotel({
    required this.id,
    required this.isFavorite,
    required this.star,
    required this.name,
    required this.address,
    required this.phone,
    required this.content,
  });

  final int id;
  bool isFavorite;
  final int star ;
  final String name;
  final String address;
  final String phone;
  final String content;
}
