import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';



import 'constants.dart';



class Utils {
  Map? conditions;
  Map? rates;
  Map? datesKey;

  static int session_currency_id = 1;
  static int marketing_consent = 1;
  static var modifier = 1.0;
  static var makeSpecificationMandatory = false;

  static String goToPage ="";


  void showLog(String printString) {
    if (DEBUG_MODE) {
      print("$printString");
    }
  }


  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode next){
    current.unfocus();

    FocusScope.of(context).requestFocus(next);

  }


  void showToast(String message, bool isError) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: isError ? Colors.red[900] : Colors.grey[700],
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    // printLog('getDeviceType(): ${data.size.shortestSide}');
    return data.size.shortestSide < 600 ? phone : tablet;
  }



  String checkCurrencyCode(int currencyId) {
    String originalCurrencyCode = "SGD";

    if(currencyId==1 ){
      originalCurrencyCode = "SGD";
    }else if(currencyId==2 ) {
      originalCurrencyCode = "IDR";
    }else if(currencyId==3 ) {
      originalCurrencyCode = "MYR";
    }else if(currencyId==4 ) {
      originalCurrencyCode = "PHP";
    }else if(currencyId==5 ) {
      originalCurrencyCode = "THB";
    }else if(currencyId==6 ) {
      originalCurrencyCode = "USD";
    }

    return originalCurrencyCode;
  }

  String checkCurrencyFlag(String currencyId) {
    String image = "assets/images/singapore.png";

    // if(currencyId==1 ){
    //   image ="assets/images/singapore.png";
    // }else if(currencyId==2 ) {
    //   image ="assets/images/indonesia.png";
    // }else if(currencyId==3 ) {
    //   image ="assets/images/malaysia.png";
    // }else if(currencyId==4 ) {
    //   image ="assets/images/philipine.png";
    // }else if(currencyId==5 ) {
    //   image ="assets/images/thailand.png";
    // }else if(currencyId==6 ) {
    //   image ="assets/images/usa.png";
    // }

    if(currencyId=="SGD") {
      image ="assets/images/singapore.png";
    }else if(currencyId =="IDR") {
      image ="assets/images/indonesia.png";
    }else if(currencyId =="MYR") {
      image ="assets/images/malaysia.png";
    }else if(currencyId =="THB") {
      image ="assets/images/thailand.png";
    }else if(currencyId =="PHP") {
      image ="assets/images/philipine.png";
    }else if(currencyId =="USD") {
      image ="assets/images/usa.png";
    }

    return image;
  }



  double checkRatesPerCurrencyCode(String currencyCode) {
    var rates = 0.0;

    if (appUtility.rates != null) {
      var allRates = appUtility.rates!.keys;

      for (var aKey in allRates) {
        // print("rates   ${appUtility.rates![aKey]}");
        // print("rates   $aKey");
        if(currencyCode == aKey) {
          rates = double.parse("${appUtility.rates![aKey]}");
          break;
        }
      }
    }

    // NumberFormat appFormat = NumberFormat.decimalPattern('en_us');
    //
    // var newPrice = rates.toStringAsFixed(2);
    //
    // rates = double.parse(newPrice);

    return rates;
  }



  String deviceName() {
    String deviceName = "";
    if (Platform.isAndroid) {
      deviceName = "android";
    } else if (Platform.isIOS) {
      deviceName = "iphone";
    }

    return deviceName;
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true,
        unicode: true
    );

    return htmlText.replaceAll(exp, '');
  }

  Future<bool> internetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  String formatDate(String date, String formatType) {
    print("for formating date $date");
    final deliveryDate = date;
    var deliveryAt = DateTime.parse(deliveryDate);
    return DateFormat(formatType).format(deliveryAt);
  }

  String formatDoubleValue(String value) {
    var formatableValue = double.parse(value);
    var formatter = NumberFormat('###,000.00');

    if (formatableValue < 100) {
      formatter = NumberFormat('###00.00');
    }
   // ScurrentOfferPriceUpdated = formatter.format(formatableValue);
    return formatter.format(formatableValue);
  }



  Widget builtItemImageContainer(String? imageName) {
    String imageUrl = "";

    if (imageName != null && imageName.length > 0) {
      imageUrl = "$imageName";
    }

    bool _validURL = Uri.parse(imageUrl).isAbsolute;

    try {
      return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: (_validURL && imageUrl.length > 0)
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        padding: EdgeInsets.all(0),
                        child: Center(child: CupertinoActivityIndicator())),
                    errorWidget: (context, url, error) => Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.all(0),
                        child: Image.asset("assets/images/login_logo.png")),
                  )
                : Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      border: Border(
                        top:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        left:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        right:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        bottom:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/login_logo.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
          ));
    } catch (error) {
      print("error : $error");
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          border: Border(
            top: BorderSide(width: 1.0, color: AppColors.whiteColor),
            left: BorderSide(width: 1.0, color: AppColors.whiteColor),
            right: BorderSide(width: 1.0, color: AppColors.whiteColor),
            bottom: BorderSide(width: 1.0, color: AppColors.whiteColor),
          ),
          image: DecorationImage(
              image: AssetImage("assets/images/login_logo.png"),
              fit: BoxFit.contain),
        ),
      );
    }
  }

  Widget builtItemRoundImageContainer(String? imageName) {
    String imageUrl = "";

    if (imageName != null && imageName.length > 0) {
      imageUrl = "$imageName";
    }

    bool _validURL = Uri.parse(imageUrl).isAbsolute;

    try {
      return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: (_validURL && imageUrl.length > 0)
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        padding: EdgeInsets.all(0),
                        child: Center(child: CupertinoActivityIndicator())),
                    errorWidget: (context, url, error) => Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.all(0),
                        child: Image.asset("assets/images/login_logo.png")),
                  )
                : Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      border: Border(
                        top:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        left:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        right:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        bottom:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/login_logo.png"),
                          fit: BoxFit.contain),
                    ),
                  ),
          ));
    } catch (error) {
      print("error : $error");
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          border: Border(
            top: BorderSide(width: 1.0, color: AppColors.whiteColor),
            left: BorderSide(width: 1.0, color: AppColors.whiteColor),
            right: BorderSide(width: 1.0, color: AppColors.whiteColor),
            bottom: BorderSide(width: 1.0, color: AppColors.whiteColor),
          ),
          image: DecorationImage(
              image: AssetImage("assets/images/login_logo.png"),
              fit: BoxFit.contain),
        ),
      );
    }
  }

  Widget builtHomeItemImageContainer(String imageName) {
    String imageUrl = "";

    if (imageName != null && imageName.length > 0) {
      imageUrl = "$imageName";
    }

    bool _validURL = Uri.parse(imageUrl).isAbsolute;

    try {
      return Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: (_validURL && imageUrl.length > 0)
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        padding: EdgeInsets.all(0),
                        child: Center(child: CupertinoActivityIndicator())),
                    errorWidget: (context, url, error) => Container(
                        height: 25,
                        width: 25,
                        margin: EdgeInsets.all(0),
                        child: Image.asset("assets/images/login_logo.png")),
                  )
                : Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(2),
                      ),
                      border: Border(
                        top:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        left:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        right:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                        bottom:
                            BorderSide(width: 1.0, color: AppColors.whiteColor),
                      ),
                      image: DecorationImage(
                          image: AssetImage("assets/images/login_logo.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
          ));
    } catch (error) {
      print("error : $error");
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
          border: Border(
            top: BorderSide(width: 1.0, color: AppColors.whiteColor),
            left: BorderSide(width: 1.0, color: AppColors.whiteColor),
            right: BorderSide(width: 1.0, color: AppColors.whiteColor),
            bottom: BorderSide(width: 1.0, color: AppColors.whiteColor),
          ),
          image: DecorationImage(
              image: AssetImage("assets/images/login_logo.png"),
              fit: BoxFit.cover),
        ),
      );
    }
  }

  Widget emptyScreenPlaceholder(bool _loading, String title, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: _loading
            ? Container()
            : Text(
                _loading ? "" : "$title",
                style: TextStyle(
                    fontFamily: AppFonts.nunitoSans,
                    fontSize: 25.0,
                    color: color,
                    fontWeight: FontWeight.normal),
              ),
      ),
    );
  }

  String getValue(String value) {
    if (value != null && !value.contains("null")) {
      return value;
    }

    return "";
  }

  // launchSliderURL(String urlString) async {
  //   String url = urlString;
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }



  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{8,}$)';
    RegExp regExp = new RegExp(pattern);

    if (value.length == 0) {
      return 'Please enter your contact number';
    } else if (value.length < 8) {
      return 'Contact no must be 8-12 digit';
    } else if (value.length > 12) {
      return 'Contact no must be 8-12 digit';
    }

    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid contact number';
    }

    return "";
  }






}



Utils appUtility = Utils();
