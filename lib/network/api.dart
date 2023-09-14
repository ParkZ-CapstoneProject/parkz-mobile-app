import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:parkz/model/ekyc_response.dart';
import 'package:parkz/model/floors_response.dart';
import 'package:parkz/model/login_response.dart';
import 'package:parkz/model/nearest_response.dart';
import 'package:parkz/model/parking_detail_response.dart';
import 'package:parkz/model/rating_home_response.dart';
import 'package:parkz/model/register.dart';

import 'package:http/http.dart' as http;
import 'package:parkz/utils/loading/loading.dart';

import '../model/balanceResponse.dart';
import '../model/booking_detail_response.dart';
import '../model/booking_response.dart';
import '../model/createVehicleRespnse.dart';
import '../model/ecpected_price_response.dart';
import '../model/location_response.dart';
import '../model/profile_response.dart';
import '../model/search_parking_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/slots_response.dart';
import '../model/transaction_response.dart';
import '../model/upcoming_response.dart';
import '../model/vehicles_response.dart';
import '../model/violation_count_response.dart';
import '../model/wallet_deposit_response.dart';


// Create storage
const storage = FlutterSecureStorage();



const String host = 'https://parkzserver-001-site1.btempurl.com';

Future ekycRegister(frontID, backID) async {
  String username = 'sst-tester';
  String password = 'be0b966de533';
  String basicAuth =
      'Basic ${base64.encode(utf8.encode('$username:$password'))}';
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
  final Register register =  Register.fromJson(responseJson);
  if(register.data != null ){
    // Write value
    await storage.write(key: 'token', value: register.data);
    String normalizedSource = base64Url.normalize(register.data!.split(".")[1]);
    String jsonString= utf8.decode(base64Url.decode(normalizedSource));
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    int userID = int.parse(jsonMap['_id']);

    await storage.write(key: 'userID', value: userID.toString());
    updateDeviceToken();
  }
  return register;
}

Future<LoginResponse> login(phone) async {
  try{
    debugPrint('--------- Login with: $phone ---------');
    var response = await http.post(
        Uri.parse('$host/api/mobile/customer-authentication/login'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode({"phone": phone}));

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
      final LoginResponse loginResponse = LoginResponse.fromJson(responseJson);
      if(loginResponse.data != null ){
        // Write value
        await storage.write(key: 'token', value: loginResponse.data);
        String normalizedSource = base64Url.normalize(loginResponse.data!.split(".")[1]);
        String jsonString= utf8.decode(base64Url.decode(normalizedSource));
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        int userID = int.parse(jsonMap['_id']);

        await storage.write(key: 'userID', value: userID.toString());
        updateDeviceToken();
      }
      return loginResponse;
    } else {
      if(response.statusCode >= 400 && response.statusCode <500){
        final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        final LoginResponse loginResponse = LoginResponse.fromJson(responseJson);
        return loginResponse;
      }

      throw Exception('Failed to login. Status code: ${response.statusCode}');
    }
  }catch (e) {
    throw Exception('Fail to login: $e');
  }



}

// Lấy bãi xe gần bạn
Future<NearestParkingResponse> getNearestParking(double? lat, double? long) async {
  try {
    if(lat != null && long != null){
      debugPrint('------Get Nearest Parking ------------');
      debugPrint('------lat: $lat ------------');
      debugPrint('------long: $long ------------');
      final response = await http.get(
        Uri.parse('$host/api/parking-nearest?currentLatitude=$lat&currentLongtitude=$long'),
        headers: {'accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        return NearestParkingResponse.fromJson(responseJson);
      } else {
        throw Exception(
            'Failed to fetch nearest parking list. Status code: ${response.statusCode}');
      }
    }
    throw Exception('Fail to get nearest parking list: null');
  } catch (e) {
    throw Exception('Fail to get nearest parking list: $e');
  }
}

// Lấy danh sách bãi xe nổi bật
Future<RatingHomeResponse> getParkingListHome(int pageSize) async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/parkings-for-cus/ratings?PageNo=1&PageSize=$pageSize'),
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
    debugPrint('-------------- Get Parking ID : $id ---------------');
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
  try{
    if(query.trim() != '' ){
      final response = await http.get(Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=${query.trim()},Ho%20Chi%20Minh&format=json&countrycodes=VN'));
      if (response.statusCode == 200) {
        final List<dynamic> responseJson = jsonDecode(utf8.decode(response.bodyBytes));
        return responseJson
            .map((json) => LocationSuggestion.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to fetch Location list. Status code: ${response.statusCode}');
      }
    }
    throw Exception('Failed to fetch Location list');
  }catch(e){
    throw Exception ('Failed to fetch Location list. Status code: $e}');
  }

}

// Lấy bãi xe theo địa điểm search
Future<SearchParkingResponse?> getParkingNearbyDestination(lat, long, range) async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/parking-nearest/distance?currentLatitude=$lat&currentLongtitude=$long&distance=$range'),
      headers: {'accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return SearchParkingResponse.fromJson(responseJson);
    }
    if(response.statusCode >= 400 && response.statusCode <500){
      throw Exception('Fail to get parking list nearby: Status code ${response.statusCode} Message ${response.body}');
    }
    return null;
  } catch (e) {
    throw Exception('Fail to get parking list nearby destination : $e');
  }
}
//Lấy danh sách tầng của 1 bãi xe
Future<List<Floor>> getFloorsByParking(id, context) async {
  try {
    String? token = await storage.read(key: 'token');
    if(token != null){
      final response = await http.get(Uri.parse('$host/api/floors/parking/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'bearer $token',
          });

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        FloorsResponse floorsResponse = FloorsResponse.fromJson(responseJson);
        return floorsResponse.data!;
      }
      if (response.statusCode == 401){
        Utils(context).showErrorSnackBar('Bạn phải đăng nhập để có thể đặt chỗ');
        throw Exception(
            'Failed to fetch parking list. Status code: ${response.statusCode}');
      }
      else {
        throw Exception(
            'Failed to fetch parking list. Status code: ${response.statusCode}');
      }
    }
    Utils(context).showErrorSnackBar('Bạn phải đăng nhập để có thể đặt chỗ');
    throw Exception('Chưa đăng nhập');
  } catch (e) {
    throw Exception('Fail to get parking detail: $e');
  }
}

// Lâý danh sách slots cho bãi xe đật theo tầng
Future<SlotsResponse> getSlotsParkingByFloor(id, startDateTime, endDateTime) async {
  try {
    // Print the request body before sending
    debugPrint('---Request Get Parking Slot---');
    debugPrint('FloorId : $id');
    debugPrint('StartTimeBooking : $startDateTime');
    debugPrint('EndTimeBooking : $endDateTime');

    final response = await http.get(
      Uri.parse('$host/api/parking-slots/floors/floorId/parking-slots?FloorId=$id&StartTimeBooking=$startDateTime&EndTimeBooking=$endDateTime'),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return SlotsResponse.fromJson(responseJson);
    } else {
      throw Exception('Failed to fetch parking list. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get parking detail: $e');
  }
}

// Lấy giá tạm tính cho khách hàng tại trang xác nhận thanh toán
Future<ExpectedPriceResponse> getExpectedPrice(parkingID, startDateTime, duration) async {
  try {
    debugPrint('---------Get expected price-------- ');
    debugPrint('Parking ID : $parkingID');
    debugPrint('Start Time : $startDateTime');
    debugPrint('Duration: $duration');

    final response = await http.get(
      Uri.parse('$host/api/customer-booking/get-expected-price?ParkingId=$parkingID&StartimeBooking=$startDateTime&DesiredHour=$duration'),
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return ExpectedPriceResponse.fromJson(responseJson);
    } else {
      throw Exception('Failed to fetch expected price. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get  expected price: $e');
  }
}

//Lấy danh sách phương tiện của customer
Future<VehicleListResponse> getVehicleList(userId) async {
  try {
    String? token = await storage.read(key: 'token');
    debugPrint('-------- Get vehicle list with user id: $userId ------------');
    final response = await http.get(
      Uri.parse('$host/user/$userId/vehicle-infor?pageSize=100'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        }
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return VehicleListResponse.fromJson(responseJson);
    } else {
      throw Exception('Failed to fetch Vehicle List. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get Vehicle List: $e');
  }
}
//Update deviceToken
Future <void> updateDeviceToken() async {
  String? deviceToken = await storage.read(key: 'DeviceToken');
  String? userID = await storage.read(key: 'userID');
  try{
    if(deviceToken != null && userID != null){
      int userId = int.parse(userID);
      var response = await http.put(
          Uri.parse('$host/api/DeviceToken'),
          headers : {
            'Content-Type': ' application/json',
            'accept': ' */*'
          },
          body:
          jsonEncode({
            "userId": userId,
            "devicetoken": deviceToken.toString()
          })
      );
      if( response.statusCode == 204){
        debugPrint('--------- UpdatedDeviceToken ------------');
      }
    }
  } catch (e){
    throw Exception('Fail to update device token: $e');
  }
}

// Booking
Future<int?> createPostPayBooking(slotId, startTime, endTime, dateBook, vehicleInforId,int payment, guessName, guessPhone, context) async {
  String paymentMethod = payment == 1 ? 'tra_sau' : 'tra_truoc';

  String? deviceToken = await storage.read(key: 'DeviceToken');
  String? userID = await storage.read(key: 'userID');

  try {
    Utils(context).startLoading();
    if (deviceToken != null && userID != null){
      Map<String, dynamic> requestBody = {
        'bookingDto': {
          'parkingSlotId': slotId,
          'startTime': startTime,
          'endTime': endTime,
          'dateBook': dateBook,
          if (guessName != null) 'guestName': guessName,
          if (guessPhone != null) 'guestPhone': guessPhone,
          'paymentMethod': paymentMethod,
          'vehicleInforId': vehicleInforId,
          'userId': int.parse(userID),
        },
        'deviceToKenMobile': deviceToken,
      };
      // Print the request body before sending
      debugPrint('---Request Body Booking---');
      debugPrint(jsonEncode(requestBody));

      var response = await http.post(
        Uri.parse('$host/api/customer-booking'),
        headers : {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        BookingResponse bookingResponse =  BookingResponse.fromJson(responseJson);
        Utils(context).stopLoading();
        return bookingResponse.data;
      } else {
        if(response.statusCode >= 400 && response.statusCode <500){
          final responseJson = jsonDecode(response.body);
          BookingResponse bookingResponse =  BookingResponse.fromJson(responseJson);
          Utils(context).stopLoading();
          Utils(context).showWarningSnackBar('${bookingResponse.message}');
          return null;
        }else{
          Utils(context).stopLoading();
          Utils(context).showWarningSnackBar('Không thể đồng bộ Device token ${response.statusCode}');
          throw Exception('Fail to create booking: Status code ${response.statusCode} Message ${response.body}');
        }
      }
    }else {
      Utils(context).showWarningSnackBar('Cần đăng nhập');
    }
    Utils(context).stopLoading();
    return null;
  }catch (e){
    throw Exception('Fail to create booking: $e');
  }
}

// Tạo mới phương tiện cho customer
Future<CreateVehicleResponse?> createVehicle(licensePlate, vehicleName, color) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');

    if(userID != null && token != null){
      Map<String, dynamic> requestBody = {
        "licensePlate": licensePlate,
        "vehicleName": vehicleName,
        "color": color,
        "userId": int.parse(userID),
        "trafficId": 1,
      };
      final response = await http.post(
          Uri.parse('$host/api/vehicle-infor'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'bearer $token',
          },
        body: jsonEncode(requestBody)
      );
      if (response.statusCode == 201) {
        debugPrint('Tạo mới phương tiện Thành công');
        final responseJson = jsonDecode(response.body);
        return CreateVehicleResponse.fromJson(responseJson);
      }
    }
    debugPrint('Tạo mới phương tiện thất bại');
    return null;
  } catch (e) {
    throw Exception('Fail to create vehicle: $e');
  }
}

// Tạo mới phương tiện cho guest
Future<CreateVehicleResponse?> createVehicleGuest(licensePlate, vehicleName, color) async {
  try {
    String? token = await storage.read(key: 'token');

    if(token != null){
      Map<String, dynamic> requestBody = {
        "licensePlate": licensePlate,
        "vehicleName": vehicleName,
        "color": color,
        "trafficId": 1,
      };
      final response = await http.post(
          Uri.parse('$host/api/vehicle-infor-guest'),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'bearer $token',
          },
          body: jsonEncode(requestBody)
      );
      if (response.statusCode == 201) {
        debugPrint(' Thành công');
        final responseJson = jsonDecode(response.body);
        return CreateVehicleResponse.fromJson(responseJson);
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to create vehicle: $e');
  }
}

//Nạp tiền vào ví customer
Future<String?> depositWallet(int amount) async {
  try {
    String? userID = await storage.read(key: 'userID');
    if(userID != null){
      Map<String, dynamic> requestBody = {
        "totalPrice": amount,
        "userId": userID,
      };
      debugPrint('----Call API deposit wallet----');
      debugPrint('totalPrice $amount');
      debugPrint('userId $userID');
      final response = await http.post(
          Uri.parse('$host/api/wallet/deposit'),
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(requestBody)
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        WalletDepositResponse depositResponse = WalletDepositResponse.fromJson(responseJson);
        if(depositResponse.data != null){
          return depositResponse.data!;
        }else{
          // không tìm thấy user
          throw Exception('Fail to deposit wallet: Status code ${response.statusCode} Message ${response.body}');
        }
      }else {
        if(response.statusCode >= 400 && response.statusCode <500){
          throw Exception('Fail to deposit wallet: Status code ${response.statusCode} Message ${response.body}');
        }else{
          throw Exception('Fail to deposit wallet: Status code ${response.statusCode} Message ${response.body}');
        }
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to deposit wallet: $e');
  }
}

// Lấy chi tết đơn
Future<BookingDetailResponse> getBookingDetail(id) async {
  try {
    final response = await http.get(
      Uri.parse('$host/api/customer-booking/getbooked-booking-detail?BookingId=$id'),
      headers: {'accept': 'text/plain'},
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return BookingDetailResponse.fromJson(responseJson);
    } else {
      throw Exception(
          'Failed to fetch parking detail. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Fail to get parking detail: $e');
  }
}

// Lấy danh sách upcoming
Future<UpcomingResponse?> getBookingUpcoming(context) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    if(userID != null && token != null){
      final response = await http.get(
        Uri.parse('$host/api/customer-booking/upcomming/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return UpcomingResponse.fromJson(responseJson);
      } else {
          throw Exception('Fail to get upcoming booking.: Status code ${response.statusCode} Message ${response.body}');
        }
      }
    return null;
  } catch (e) {
    throw Exception('Fail to get upcoming booking: $e');
  }
}

//Lấy history
Future<UpcomingResponse?> getBookingHistory(context) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    debugPrint('--------- Get booking history list ---------');
    debugPrint('User ID: $userID');
    debugPrint('Tokken: $token');
    if(userID != null && token != null){
      final response = await http.get(
        Uri.parse('$host/api/customer-booking/activities/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return UpcomingResponse.fromJson(responseJson);
      } else {
        throw Exception('Fail to get history booking.: Status code ${response.statusCode} Message ${response.body}');
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to get history booking: $e');
  }
}

// Lấy số dư
Future<BalanceResponse?> getBalance(context) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    if(userID != null && token != null){
      final response = await http.get(
        Uri.parse('$host/api/customer/wallet/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return BalanceResponse.fromJson(responseJson);
      } else {
        if(response.statusCode >= 400 && response.statusCode <500){
          final responseJson = jsonDecode(response.body);
          BalanceResponse depositResponse = BalanceResponse.fromJson(responseJson);
          Utils(context).showWarningSnackBar('${depositResponse.message}');
        }else{
          throw Exception('Fail to get balance wallet: Status code ${response.statusCode} Message ${response.body}');
        }
        throw Exception(
            'Failed to fetch balance wallet. Status code: ${response.statusCode}');
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to balance wallet: $e');
  }
}

//Lấy lịch sử giao dịch
Future<TransactionResponse?> getTransactionHistory(context) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    if(userID != null && token != null){
      final response = await http.get(
        Uri.parse('$host/api/customer/transactions/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return TransactionResponse.fromJson(responseJson);
      } else {
        if(response.statusCode >= 400 && response.statusCode <500){
          final responseJson = jsonDecode(response.body);
          TransactionResponse depositResponse = TransactionResponse.fromJson(responseJson);
          Utils(context).showWarningSnackBar('${depositResponse.message}');
        }else{
          throw Exception('Fail to get balance wallet: Status code ${response.statusCode} Message ${response.body}');
        }
        throw Exception(
            'Failed to fetch balance wallet. Status code: ${response.statusCode}');
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to balance wallet: $e');
  }
}

//Hủy đơn
Future<void> cancelBooking(int bookingId, context) async {
  try {
      Map<String, dynamic> requestBody = {
        "bookingId": bookingId
      };

      final response = await http.post(
          Uri.parse('$host/api/customer-booking/cancel-booking'),
          headers: {
            'accept': 'text/plain',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(requestBody)
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        Utils(context).showSuccessSnackBar('Hủy đơn thành công');
      }else {
        if(response.statusCode >= 400 && response.statusCode <500){
          Utils(context).showWarningSnackBar('Hủy đơn thất bại ${response.statusCode}');
        }else{
          throw Exception('Fail to cancel booking: Status code ${response.statusCode} Message ${response.body}');
        }
      }
  } catch (e) {
    throw Exception('Fail to cancel booking: $e');
  }
}

// Lấy profile
Future<ProfileResponse?> getProfile(context) async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    if(userID != null && token != null){
      final response = await http.get(
        Uri.parse('$host/api/mobile/account/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token'
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return ProfileResponse.fromJson(responseJson);
      } else {
        if(response.statusCode >= 400 && response.statusCode <500){
          final responseJson = jsonDecode(response.body);
          ProfileResponse depositResponse = ProfileResponse.fromJson(responseJson);
          Utils(context).showWarningSnackBar('${depositResponse.message}');
        }else{
          throw Exception('Fail to get profile info: Status code ${response.statusCode} Message ${response.body}');
        }
        throw Exception(
            'Failed to fetch profile info. Status code: ${response.statusCode}');
      }
    }
    return null;
  } catch (e) {
    throw Exception('Fail to profile info:: $e');
  }
}

//Đánh gia rating
Future<bool> ratingBooking(int bookingId, int stars, int parkingId) async {
  try {
    Map<String, dynamic> requestBody = {
      "bookingId": bookingId,
      "parkingId": parkingId,
      "stars": stars
    };
    String? token = await storage.read(key: 'token');

    debugPrint('---Request rating Booking---');
    debugPrint(jsonEncode(requestBody));

    final response = await http.put(
        Uri.parse('$host/api/rating-stars'),
        headers: {
          'accept': '*/*',
          'Authorization': 'bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(requestBody)
    );
    if(response.statusCode >= 200 && response.statusCode <300){
      return true;
    }else {
      return false;
    }
  } catch (e) {
    throw Exception('Fail to rating booking: $e');
  }
}

// Xóa xe
Future<bool> deleteVehicle(int id) async {
  try {
    String? token = await storage.read(key: 'token');

    debugPrint('---Request delete vehicle : $id---');

    final response = await http.delete(
        Uri.parse('$host/api/vehicle-infor/$id'),
        headers: {
          'accept': '*/*',
          'Authorization': 'bearer $token',
        },
    );
    if(response.statusCode >= 200 && response.statusCode <300){
      return true;
    }else {
      return false;
    }
  } catch (e) {
    throw Exception('Fail to rating booking: $e');
  }
}

// Lấy  Ban count
Future<int> getNumberOfViolations() async {
  try {
    String? userID = await storage.read(key: 'userID');
    String? token = await storage.read(key: 'token');
    if(userID != null && token != null){
      debugPrint('--------Call ban count -------');
      debugPrint('User ID: $userID');
      debugPrint('User Token $token');
      final response = await http.get(
        Uri.parse('$host/api/mobile/account/ban-count/$userID'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token'
        },
      );
      if (response.statusCode >= 200 && response.statusCode <300) {
        final responseJson = jsonDecode(response.body);
        return ViolationCountResponse.fromJson(responseJson).data!.banCount!;
      } else {
        if(response.statusCode >= 400 && response.statusCode <500){
          return 0;
        }else{
          throw Exception('Fail to get number of Violations: Status code ${response.statusCode} Message ${response.body}');
        }
      }
    }
    return 0;
  } catch (e) {
    throw Exception('Fail to get number of Violations: $e');
  }
}



