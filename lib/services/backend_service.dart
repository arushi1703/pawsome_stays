import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class BackendService{
  final String _baseUrl = "http://192.168.10.103:8080";

  Future<http.Response> registerPet(Map<String, dynamic> petData) async {
    final response = await http.post(
      Uri.parse("$_baseUrl/api/pet/add"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(petData),
    );
    return response;
  }
}