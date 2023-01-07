import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zigy/api_details.dart';

class Fetcher {
  String query;
  Fetcher({required this.query});

  Future getData() async {
    http.Response response = await http.get(Uri.parse("$baseUrl?$query"));
    if (response.statusCode == 200) {
      var fetchedData = response.body;
      print("Fetched Data = $fetchedData");
      Map<String, dynamic> decodedData = jsonDecode(fetchedData);
      print("\n");
      print("Decoded Data = ${decodedData}");
      return decodedData;
    }
    throw Exception(response.statusCode);
  }
}
