// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.


library coinbase.base;

import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  new Coinbase().accounts().then((s) => print(s['accounts'][0]['name']));
  new Coinbase().sell(0.001).then((s) => print(s.toString()));
}

class Coinbase {
  final String token = '82afb75fd4be127df024deb2be2827c7d2c81a7fd107ffa0cd532fa3d28ed69b';
  final String root = 'https://api.sandbox.coinbase.com/v1';

  
  Future<Map> accounts() {
    return get('/accounts');
  }
  
  Future<Map> buy(num amount, String currency) {
    return post('/buys', { 'qty': amount.toString(), 'currency': currency }); 
  }
  
  Future<Map> sell(num amount) {
    return post('/sells', { 'qty': amount.toString() });
  }
  
  Future<Map> get(String path) {
    String url = "${root}${path}?access_token=${token}";
    print(url);
    return http.get(url).then((response) => JSON.decode(response.body));
  }
  
  Future<Map> post(String path, Map body) {
    String postBody = JSON.encode(body);
    String url = "${root}${path}?access_token=${token}";
    return http.post(url, body: postBody).then((response) => JSON.decode(response.body));
  }
}
