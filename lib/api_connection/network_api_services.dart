


import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:my_foodhub/data/app_exceptions.dart';
import '../utilities/utils.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices{

  @override
  Future getApi(String url) async{

    dynamic responseJson;

    try {
      var response =   await http.get(
        Uri.parse(url)
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException{
      throw InternetException("");
    }on RequestTimeOut{
    throw RequestTimeOut("");
    }
    catch (e) {
      Utils().showToast("$e",true);
    }

 return responseJson;
  }


  @override
  Future postApi(dynamic data,String url) async{

    dynamic responseJson;

    try {
      var response =   await http.post(
          Uri.parse(url),
        body:jsonEncode(data)
      ).timeout(const Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException{
      throw InternetException("");
    }on RequestTimeOut{
      throw RequestTimeOut("");
    }
    catch (e) {
      Utils().showToast("$e",true);
    }

    return responseJson;
  }


  dynamic returnResponse(http.Response response){
    switch (response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException();
        default:
          throw FetchDataException();



    }

  }

}