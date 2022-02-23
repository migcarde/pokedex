import 'dart:convert';
import 'dart:io';

import 'package:data/network/repository_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

const badRequest = 400;
const unauthorized = 401;
const internalServerError = 500;

void printResponse(Response response) {
  debugPrint('Request: ${response.request.toString()}');
  debugPrint('Headers: ${response.headers}');
  debugPrint('Response-body: ${response.statusCode}');
  debugPrint(response.body);
}

List<dynamic> parsedResponse(Response response) {
  if (response.statusCode == badRequest) {
    throw RepositoryException();
  } else if (response.statusCode == unauthorized) {
    throw Unauthorized();
  } else if (response.statusCode >= internalServerError) {
    throw Unknown();
  } else {
    return jsonDecode(response.body);
  }
}

Future<List<dynamic>> requestServer(
    Future<List<dynamic>> Function() request) async {
  try {
    return await request();
  } on SocketException {
    throw NoInternet;
  } on HttpException {
    throw RepositoryException;
  } on FormatException {
    throw RepositoryException;
  } catch (e) {
    throw Unknown();
  }
}
