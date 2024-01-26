import 'dart:ui';



const String DATABASE_NAME = "foodhub.sqlite";
const String DATABASE_LAST_VERSION = "APR 13, 2023";

//const String talkJSAppID = "tyXawsPr";
const int DATABASE_VERSION = 1;
const bool DEBUG_MODE = false;

String DEVICE_TOKEN = "";
int mealQuantity= 0;

/// Device Types
 const tablet = "tablet";
 const phone = "phone";



class AppColors {
  static const Color AppBarColor = const Color(0xff356845);
  static const Color primaryColor = const Color(0xff356845);
  static const Color appBackGroundColor = const Color(0xffFBF5F3);
  static const Color appBackgroungColor = const Color(0xffFBF5F3);
  static const Color textFieldBackgroundCommonColor = const Color(0xffF4F3FF);
  static const Color whiteColor = const Color(0xffFFFFFF);
  static const Color hintTextColor = const Color(0xff595959);
  static const Color signUpPopupBgColor = const Color(0xffF7D0C7);
 // static const Color greenTextColor = const Color(0xff3B6B4A);
  static const Color greenTextColor = const Color(0xffBE202E);

  static const Color blackTextColor = const Color(0xff000000);
  static const Color themeBlackTextColor = const Color(0xff000000);
  static const Color greyButtonColor = const Color(0xff676767);
  static const Color themeGrayTextColor = const Color(0xff676767);
  static const Color greenButtonColor = const Color(0xff487155);
  static const Color borderColor = const Color(0xffDDDDDD);

  static const Color BgWhite = const Color(0xffffffff);
  static const Color BgWhite2 = const Color(0xfff5f5f5);
  static const Color BgGreen = const Color(0xff1ED85F);
  static const Color BgYellow = const Color(0xffFF9E02);
  static const Color textColorGreen = const Color(0xff0d860b);
  static const Color textColorGrey = const Color(0xffc4c4c4);
  static const Color textColorDarkGrey = const Color(0xff6c6c6c);
  static const Color textColorBlue = const Color(0xff292b66);
  static const Color blackTextColor2 = const Color(0xff212121);
  static const Color AppTextColorGrey = const Color(0xff7a7a7a);
  static const Color AppTextColorGrey2 = const Color(0xff505050);
  static const Color AppTextColorGrey3 = const Color(0xff838383);
  static const Color gradient1 = const Color(0xffEE964B);
  static const Color gradient2 = const Color(0xffF95738);
  static const Color blueDetails = const Color(0xff3B7497);
  static const Color themeBlueButtonColor = const Color(0xff3B7497);
  static const Color themeBlueTextColor = const Color(0xff3B7497);
  static const Color blueGradient1 = const Color(0xff2471BC);
  static const Color blueGradient2 = const Color(0xff00006B);
  static const Color blueGradient3 = const Color(0xff1D5C9A);
  static const Color appBackground = const Color(0xffE5E5E5);

  static const Color blackColor = const Color(0xff1B1B1B);
  static const Color yellowColor = const Color(0xffF4D35E);
  static const Color blueColor = const Color(0xff2471BC);
  static const Color color001122 = const Color(0xff001122);
  static const Color colorF7F7F7 = const Color(0xffF7F7F7);
  static const Color color00AADF = const Color(0xff00AADF);
  static const Color hintColor = const Color(0xff969696);
  static const Color coffeeColor = const Color(0xff6f4e37);
  static const Color colorEAF1F9 = const Color(0xffEAF1F9);

  static const Color color020202 = const Color(0xff020202);
  static const Color dialogRedButton = const Color(0xffBE202E);
  static const Color color0EC583 = const Color(0xff0EC583);
  static const Color color00006E = const Color(0xff00006E);
  static const Color color3C3C43 = const Color(0xff3C3C43);
  static const Color color024668 = const Color(0xff024668);
  static const Color colorE07809 = const Color(0xffE07809);
  static const Color colorEFAF31 = const Color(0xffEFAF31);
  static const Color color3B7497 = const Color(0xff3B7497);
  static const Color color5E0010 = const Color(0xff5E0010);
  static const Color color50000E = const Color(0xff50000E);
  static const Color color1C8047 = const Color(0xff1C8047);

  static const Color nebula = Color(0xFF5468FF);
  static const Color darkBlue = Color(0xFF21243D);
  static const Color darkPink = Color(0xFFAA086C);
  static const Color vividOrange = Color(0xFFE8600A);
  static const Color darkRed = Color(0xFFB00020);
  static const Color neutralDark = Color(0XFF91929D);
  static const Color neutralLightest = Color(0XFFF4F4F5);

  static const colorSiji = Color.fromARGB(255, 26, 26, 26);
  static const colorSijiSetengah = Color.fromARGB(255, 56, 56, 56);
  static const colorLoro = Color.fromARGB(255, 175, 234, 13);
  static const colorTelu = Color.fromARGB(255, 237, 237, 237);

  static const Color scaffoldBgColor = const Color(0xFFF3F2DF);
  static const Color primaryTextColor = const Color(0xFF0F1918);
  static const Color primaryColor2 = const Color(0xFF0F1918);
  static const Color onSurfaceTextColor = const Color(0xFF0F1918);
  static const Color greyColor = const Color(0xFF98A3A2);
  static const Color greyColor1 = const Color(0xFFD9D9D9);
  static const Color lightAmberColor = const Color(0xFFEDEBC0);
  static const Color pinkColor = const Color(0xFFF30E5C);

  static const Color kcBackgroundColor = Color(0xFF000000);
  static const Color kcWhiteColor = Color(0xFFFFFFFF);
  static const Color kcSecondaryLightColor = Color(0xFFE4E4E4);
  static const Color kcSecondaryDarkColor = Color(0xFF303030);
  static const Color kcFontColor = Color(0xFFE3C086);
  static const Color themeLightPurpleButtonColor = Color(0xFFE5E3FF);
}

class AppFonts {
  static const String nunitoSans = "Quicksand";
  static const String helvetica = "Quicksand";
  static const String quicksand = "Quicksand";

  static const String comfortaaRegular = "comfortaa";

  static const String regularFontFamilyName = "comfortaa";
  static const String boldFontFamilyName = "comfortaa";

  static const String appBarText = "comfortaa";
  static const String appText = "comfortaa";
}



class AppBool {
  static const bool isMembershipShow = true;
  static const bool isBidShow = true;
}

class AppInts {
  static int payLaterEnableValue = 0;
}

class APIResponseCode {
  static const int OK = 200;
  static const int CREATED = 201;
  static const int BAD_REQUEST = 400;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;
  static const int UNAUTHORIZED_ERROR = 900;
}

class ResponseCode {
  static const int NO_INTERNET_CONNECTION = 0;
  static const int AUTHORIZATION_FAILED = 900;
  static const int SUCCESSFUL = 500;
  static const int FAILED = 501;
  static const int NOT_FOUND = 502;
}






class APIConstants {
  // DEBUG_MODE?Test:Live Server
  static const String API_BASE_URL = DEBUG_MODE?"https://sss2.inspireo.co/api/v1.1/":"https://golistid.com/api/v1.1/";
  static const String BASE_URL = "https://golistid.com/";

  //Test Server
  // static const String API_BASE_URL = "https://sss2.inspireo.co/api/v1.1/";
  // static const String BASE_URL = "https://golistid.com/";


  //Live Server
  // static const String API_BASE_URL = "https://golistid.com/api/v1.1/";
  // static const String BASE_URL = "https://golistid.com/";

  static const String commonSync = API_BASE_URL + "commonsync";
  static const String admins = API_BASE_URL + "admins";
  static const String algloia = API_BASE_URL + "algloia/categories";
  static const String offers = API_BASE_URL + "offers";
  static const String checkEmail = API_BASE_URL + "check-email";
  static const String phoneVerification =
      API_BASE_URL + "phone-verification/resend";

  static const String codeVerification = API_BASE_URL + "phone-verification";

  static const String emailLogin = API_BASE_URL + "login";
  static const String updateProfile = API_BASE_URL + "update/profile";
  static const String signUp = API_BASE_URL + "signup";
  static const String profile = API_BASE_URL + "profile";
  static const String loginSocial = API_BASE_URL + "social/login";
  static const String logout = API_BASE_URL + "logout";
  static const String forgetPassword = API_BASE_URL + "forget/password";
  static const String updatePassword = API_BASE_URL + "update/password";
  static const String listings = API_BASE_URL + "listings";
  static const String myListings = API_BASE_URL + "my-listings";
  // static const String listingDetails = API_BASE_URL + "listing/details";
  static const String listingDetails = API_BASE_URL + "listings/details";
  static const String home = API_BASE_URL + "home";
//  static const String userBookmarkAdd = API_BASE_URL + "user/bookmark/add";
  static const String userBookmarkAdd = API_BASE_URL + "bookmarks/create";
  static const String userBookmarkIds = API_BASE_URL + "bookmarks/ids";
  // static const String userBookmarkRemove =
  //     API_BASE_URL + "user/bookmark/remove";
  static const String userBookmarkRemove = API_BASE_URL + "bookmarks/delete";
  static const String passwordChange = API_BASE_URL + "password/change";
  //static const String userBookmarks = API_BASE_URL + "user/bookmarks";
  static const String userBookmarks = API_BASE_URL + "bookmarks";
  static const String companyProfile = API_BASE_URL + "company/profile";
  static const String userProfile = API_BASE_URL + "user/profile";
  static const String categoryDetails = API_BASE_URL + "category/details";
  static const String companySubscription =
      API_BASE_URL + "company/subscription";
  static const String listingRemove = API_BASE_URL + "listing/remove";
  static const String messages = API_BASE_URL + "messages";
  static const String messageSend = API_BASE_URL + "message/send";

  static const String messageArchive = API_BASE_URL + "message/archive";
  static const String allMessages = API_BASE_URL + "all/messages";
  static const String allArchives = API_BASE_URL + "all/archives";
  static const String chatHistories = API_BASE_URL + "chat-histories";
  static const String chatHistoryUpdate = API_BASE_URL + "chat-histories/update";
  static const String chatHistoryCreate = API_BASE_URL + "chat-histories/chat-create";
  static const String chatHistoryArchive = API_BASE_URL + "chat-histories/archive";
  static const String chatHistoryUnarchive = API_BASE_URL + "chat-histories/unarchive";
  static const String chatHistoryDetails = API_BASE_URL + "chat-histories/details";
  static const String messageReport = API_BASE_URL + "message/report";

  static const String offerCreate = API_BASE_URL + "offers/create";
  static const String offerUpdate = API_BASE_URL + "offers/update";
  static const String offerDelete = API_BASE_URL + "offers/delete";
  static const String offerChangeStatus = API_BASE_URL + "offers/change-status";
  static const String offerDetailsList = API_BASE_URL + "offers";


  static const String currencyRates = API_BASE_URL + "currency/rates";
  static const String currencyUpdate = API_BASE_URL + "update/currency";

  static const String listingStatusUpdate =
      API_BASE_URL + "listing/status/update";
  static const String sellerProfile = API_BASE_URL + "seller/profile";
  static const String listingsCreate = API_BASE_URL + "my-listings/create";
  static const String listingsDelete = API_BASE_URL + "my-listings/delete";
  static const String changeStatus = API_BASE_URL + "my-listings/change-status";
  static const String listingsUpdate = API_BASE_URL + "my-listings/update";
  static const String feedbacksCreate = API_BASE_URL + "feedbacks/create";
  static const String deleteAccount = API_BASE_URL + "deleteaccounts/create";

  static const String calculatorAnnotations =
      API_BASE_URL + "calculator/annotations";
  static const String calculatorList = API_BASE_URL + "calculators";
  static const String calculatorsCreate = API_BASE_URL + "calculators/create";
  static const String calculatorsRemarks = API_BASE_URL + "calculators/remarks";
  static const String calculatorsPin = API_BASE_URL + "calculators/pin";
  static const String calculatorsDelete = API_BASE_URL + "calculators/delete";


  static const String registerDeviceToken = API_BASE_URL + "register/device-tokens";
  static const String deregisterDeviceToken  = API_BASE_URL + "deregister/device-tokens";


  static const String pusherRegisterDeviceToken = API_BASE_URL + "pusher/register/device-tokens";
  static const String pusherDeregisterDeviceToken  = API_BASE_URL + "pusher/deregister/device-tokens";
}

class SharedPrefsKeys {
  static const String apiToken = "api_token";
  static const String deviceToken = "device_token";
  static const String membershipToken = "membership_token";
  static const String cdnUrl = "cdn_url";
  static const String userName = "user_name";
  static const String userEmail = "user_email";
  static const String userPhone = "user_phone";
  static const String userCompanyId = "user_company_id";
  static const String userCountryId = "user_country_id";
  static const String userCurrencyId = "user_currency_id";
  static const String userCountryCode = "user_country_code";
  static const String userPhoto = "user_photo";
  static const String userGender = "user_gender";
  static const String userId = "user_id";
  static const String isLoggedIn = "isLoggedIn";
  static const String cartList = "my_cart";
  static const String companyId = "companyId";
  static const String marketingConsent = "marketing_consent";
  static const String businessType = "businessType";
  static const String DB_VERSION = "db_version";
  static const String PUSHER_INIT = "PUSHER_INIT";
}

class AppStrings {
  static const String district = "District";
  static const String thana = "Thana";
  static const String city = "City";
}

class FromPage {
  static const String bookmark = "bookmark";
}

class ChooseOptionType {
  static const String CATEGORY = "category";
  static const String STATUS = "status";
  static const String SPECIFICATIONS = "specification";
  static const String CONDITIONS = "conditions";
}


