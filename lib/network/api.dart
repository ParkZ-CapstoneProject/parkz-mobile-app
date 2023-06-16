import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:parkz/model/ekyc_response.dart';
import 'package:parkz/model/login_response.dart';
import 'package:parkz/model/register.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const String host = 'http://parkzwebapiver2-001-site1.ctempurl.com';


Future ekycRegister(frontID, backID) async {
  String username = 'sst-tester';
  String password = 'be0b966de533';
  String basicAuth = 'Basic ' + base64.encode(utf8.encode('$username:$password'));
  EkycResponse error = EkycResponse(documentType: '', id: '', linkedFileIds: [''], message: '', recognizedData: null, resultCode: 999);
  var response = await http.post(
      Uri.parse('https://api-uat.unicloud.ai/ekyc/kyc-documents-sides'),
      headers : {'Content-Type': 'application/json', 'Authorization' : basicAuth, 'accept': 'application/json'},
      body:
      jsonEncode({
        "image1": frontID,
        "name1":"CCCD_front",
        "image2": backID,
        "name2":"CCCD_back"
      })
  );
  if(response.statusCode == 200){
    final responseJson =jsonDecode(utf8.decode(response.bodyBytes));
    var userInfo = EkycResponse.fromJson(responseJson);
    return userInfo;

  }
  else if (response.statusCode == 400){
    return error;
  } else {
    return error;
  }
}

Future<Register> authentication(phone, name, dateOfBirth,idCardDate, gender, idCardNo, idCardIssuedBy, address) async {
  final inputDateFormat = DateFormat('dd/MM/yyyy');
  final outputDateFormat = DateFormat('yyyy-MM-dd');

  final inputBirthDay = inputDateFormat.parse(dateOfBirth);
  final inputIdCardDate = inputDateFormat.parse(idCardDate);

  final birthDay = outputDateFormat.format(inputBirthDay);
  final idCardDateConverted = outputDateFormat.format(inputIdCardDate);

  var response = await http.post(
      Uri.parse('$host/api/mobile/customer-authentication/register'),
      headers : {'Content-Type': 'application/json',  'accept': 'application/json'},
      body:
      jsonEncode(
          {
            "phone": phone,
            "name": name,
            "dateOfBirth": birthDay,
            "gender": gender,
            "idCardNo": idCardNo,
            "idCardDate": idCardDateConverted,
            "idCardIssuedBy": idCardIssuedBy,
            "address": address
          }
      )
  );
    final responseJson =jsonDecode(utf8.decode(response.bodyBytes));
    return Register.fromJson(responseJson);

}

Future<LoginResponse> login(phone) async {
  var response = await http.post(
      Uri.parse('$host/api/mobile/customer-authentication/login'),
      headers : {'Content-Type': 'application/json',  'accept': 'application/json'},
      body:
      jsonEncode(
          {
            "phone": phone
          }
      )
  );
  final responseJson =jsonDecode(utf8.decode(response.bodyBytes));
  return LoginResponse.fromJson(responseJson);

}


