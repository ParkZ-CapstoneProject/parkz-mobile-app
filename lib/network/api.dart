import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:parkz/model/ekyc_response.dart';
import 'package:parkz/model/login_response.dart';
import 'package:parkz/model/nearest_response.dart';
import 'package:parkz/model/parking_detail_response.dart';
import 'package:parkz/model/rating_home_response.dart';
import 'package:parkz/model/register.dart';

import 'package:http/http.dart' as http;

import '../model/location_response.dart';
import '../model/search_parking_response.dart';

const String host = 'http://parkzwebapiver2-001-site1.ctempurl.com';

Future ekycRegister(frontID, backID) async {
  String username = 'sst-tester';
  String password = 'be0b966de533';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));
  EkycResponse error = EkycResponse(
      documentType: '',
      id: '',
      linkedFileIds: [''],
      message: '',
      recognizedData: null,
      resultCode: 999);
  var response = await http.post(
      Uri.parse('https://api-uat.unicloud.ai/ekyc/kyc-documents-sides'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
        'accept': 'application/json'
      },
      body: jsonEncode({
        "image1": frontID,
        "name1": "CCCD_front",
        "image2": backID,
        "name2": "CCCD_back"
      }));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    var userInfo = EkycResponse.fromJson(responseJson);
    return userInfo;
  } else if (response.statusCode == 400) {
    return error;
  } else {
    return error;
  }
}

Future<Register> authentication(phone, name, dateOfBirth, idCardDate, gender,
    idCardNo, idCardIssuedBy, address) async {
  final inputDateFormat = DateFormat('dd/MM/yyyy');
  final outputDateFormat = DateFormat('yyyy-MM-dd');

  final inputBirthDay = inputDateFormat.parse(dateOfBirth);
  final inputIdCardDate = inputDateFormat.parse(idCardDate);

  final birthDay = outputDateFormat.format(inputBirthDay);
  final idCardDateConverted = outputDateFormat.format(inputIdCardDate);

  var response = await http.post(
      Uri.parse('$host/api/mobile/customer-authentication/register'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode({
        "phone": phone,
        "name": name,
        "dateOfBirth": birthDay,
        "gender": gender,
        "idCardNo": idCardNo,
        "idCardDate": idCardDateConverted,
        "idCardIssuedBy": idCardIssuedBy,
        "address": address
      }));
  final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return Register.fromJson(responseJson);
}

Future<LoginResponse> login(phone) async {
  var response = await http.post(
      Uri.parse('$host/api/mobile/customer-authentication/login'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json'
      },
      body: jsonEncode({"phone": phone}));
  final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
  return LoginResponse.fromJson(responseJson);
}

// Lấy bãi xe gần bạn
Future<NearestParkingResponse> getNearestParking(
    double? lat, double? long) async {
  try {
    final response = await http.get(Uri.parse(
        '$host/api/parking-nearest?currentLatitude=$lat&currentLongtitude=$long'));

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return NearestParkingResponse.fromJson(responseJson);
    } else {
      throw Exception(
          'Failed to fetch nearest parking list. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get nearest parking list: $e');
  }
}

// Lấy danh sách bãi xe nổi bật
Future<RatingHomeResponse> getParkingListHome() async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/parkings-for-cus/ratings?PageNo=1&PageSize=10'),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return RatingHomeResponse.fromJson(responseJson);
    } else {
      throw Exception(
          'Failed to fetch parking sort by rating list. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch parking sort by list. Error: $e');
  }
}

// Lấy chi tiết bãi xe
Future<ParkingDetailResponse> getParkingDetail(id) async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/parkings/mobile/parking-details?ParkingId=$id'),
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return ParkingDetailResponse.fromJson(responseJson);
    } else {
      throw Exception(
          'Failed to fetch parking list. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get parking detail: $e');
  }
}

//Lấy danh sách địa điểm đến khi search
Future<List<LocationSuggestion>> fetchSuggestions(String query) async {
  final response = await http.get(Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query,Ho%20Chi%20Minh%20City&format=json&countrycodes=VN'));

  if (response.statusCode == 200) {
    final List<dynamic> responseJson = jsonDecode(response.body);
    return responseJson
        .map((json) => LocationSuggestion.fromJson(json))
        .toList();
  } else {
    throw Exception(
        'Failed to fetch Location list. Status code: ${response.statusCode}');
  }
}

// Lấy bãi xe theo địa điểm search
Future<SearchParkingResponse> getParkingNearbyDestination(lat, long, range) async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/parking-nearest/distance?currentLatitude=$lat&currentLongtitude=$long&distance=$range'),
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return SearchParkingResponse.fromJson(responseJson);
    } else {
      throw Exception(
          'Failed to fetch parking list nearby destination. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get parking list nearby destination : $e');
  }
}
