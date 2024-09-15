import 'package:http/http.dart' as http;
import 'dart:convert';


class BackendService{
  final String _baseUrl = "http://192.168.178.129:8080";

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

  Future<http.Response> addServices(String petID, List<String> services) async {
    final Map<String, dynamic> requestBody = {
      "petID": petID,
      "services": services,
    };

    final response = await http.post(
      Uri.parse("$_baseUrl/api/service/add"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    return response;
  }

  Future<String?> getOwnerIDByEmail(String email) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/api/petowner/getID/${Uri.encodeComponent(email)}"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Returning owner id:${data['ownerID']}');
        return data['ownerID']; // Return the owner ID from the response
      } else {
        print('Failed to retrieve owner ID: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
    return null; // Return null if the request fails
  }

  Future<String?> getPetIDByOwnerID(String ownerID) async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/api/pet/getID/${Uri.encodeComponent(ownerID)}"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['petID']; // Return the pet ID from the response
      } else {
        print('Failed to retrieve pet ID: ${response.body}');
      }
    } catch (e) {
      print(e);
    }
    return null; // Return null if the request fails
  }

  Future<http.Response> addBooking({
    required String ownerID,
    required String petID,
    required String bedType,
    required DateTime checkIn,
    required DateTime checkOut,
  }) async {
    final Map<String, dynamic> requestBody = {
      "ownerID": ownerID,
      "petID": petID,
      "bedType": bedType,
      "check_in": checkIn.toIso8601String(),
      "check_out": checkOut.toIso8601String(),
    };
    final response = await http.post(
      Uri.parse("$_baseUrl/api/booking/add"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );
    return response;
  }
}