import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

import '../utilities/constants.dart';
import '../utilities/custom_loader.dart';
import '../utilities/recommended.dart';
import 'checkout.dart';


class ProductDetailsScreen extends StatefulWidget {
  String? fromPage;
  int? listingId;

  final Function()? callBackFunction;

  ProductDetailsScreen(
      {this.fromPage, this.listingId, this.callBackFunction, Key? key})
      : super(key: key);

  @override
  _ProductDetailsScreen createState() => _ProductDetailsScreen();
}

 class _ProductDetailsScreen extends State<ProductDetailsScreen>
     with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  GlobalKey? _dropdownButtonKey2 = GlobalKey();

  void openDropdown2() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext? element) {
      element?.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
        } else {
          searchForGestureDetector(element);
        }
      });
    }

    searchForGestureDetector(_dropdownButtonKey2?.currentContext);
    assert(detector != null);

    detector?.onTap?.call();
  }

  //final Function() dataDidUpdated;

  List<Map> specificationList = [];

  bool isBookmarked = false;

  List<int>? bookmarkIDs = [];

  List<String> imageSliders = [
    "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg",
    "https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg",
//add your items here
  ];
  int _current = 0;
  int currentPos = 0;

  bool isDescriptionVisible = true;
  bool isSpecificationsVisible = false;
  bool isRelatedListVisible = false;

  String description = "• DESCRIPTION";
  String specifications = "SPECIFICATIONS";

  String _dropDownValue2 = "Choose an option";
  TextEditingController businessTextFieldController =
      new TextEditingController(text: "");

  List<String> statusList = [
    "Draft",
    "In Review",
  ];

  List<String> markAsList = [
    "Latest",
    "Price DESC",
    "Price ASC",
    "Discount Price ASC"
  ];

  ScrollController _scrollController = ScrollController();
  bool reachedAtBottom = false;

  void _scrollListener() {
    if (widget.fromPage == "profile") {
      return;
    }

    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 1) {
      if (!reachedAtBottom) {
        print("reachedAtBottom");
        setState(() {
          reachedAtBottom = true;
        });
      }
    } else if (_scrollController.position.extentAfter > 10) {
      if (reachedAtBottom) {
        print("reachedAtTop");
        setState(() {
          reachedAtBottom = false;
        });
      }
    }
  }

  bool _loading = false;

  void _showProgressHud() {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _hideProgressHud() {
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  List<String> _fetchGalleryList() {
    List<String> dataList = [];
    dataList = imageSliders;
    return dataList;
  }


  @override
  void initState() {
    // TODO: implement initState

    _scrollController = new ScrollController()..addListener(_scrollListener);
    // _requestToListingDetails();
    // _requestAdminListSync();

    Future.delayed(Duration(milliseconds: 500), () {
      // Do something
      isRelatedListVisible = true;
      setState(() {});
    });

    super.initState();
  }

   @override
   Widget build(BuildContext context) {

     var size = MediaQuery.of(context).size;
     return Scaffold(
       backgroundColor: AppColors.AppBarColor,
       body: SingleChildScrollView(
         child: Column(
           children: [
             SizedBox(
               height: size.height * 0.15,
               child: Padding(
                 padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     // back button
                     Container(
                       alignment: Alignment.center,
                       height: 40,
                       decoration: ShapeDecoration(
                         color: Colors.white70,
                         shape: CircleBorder(),
                       ),
                       child: IconButton(
                         onPressed: () {
                           Navigator.pop(context);
                         },
                         icon: Icon(
                           Icons.arrow_back_ios_new,
                         ),
                       ),
                     ),

                     // cart button
                     GestureDetector(
                       onTap: (){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => CheckOut()),
                         );
                       },
                       child: Container(
                         alignment: Alignment.center,
                         width: 65,
                         height: 35,
                         decoration: BoxDecoration(
                           color: Colors.lime,
                           borderRadius: BorderRadiusDirectional.circular(10),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(
                               UniconsLine.shopping_cart,
                               color: AppColors.colorSiji,
                             ),
                             SizedBox(width: 2),
                             Text(
                               '9',
                               style: GoogleFonts.poppins(
                                 color: AppColors.colorSiji,
                                 fontSize: 20,
                                 fontWeight: FontWeight.w500,
                               ),
                             )
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ),

             // main image content
             SizedBox(
               height: size.height * 0.42,
               width: size.width,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(35),
                     topRight: Radius.circular(35),
                   ),
                   color: Colors.white70,
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.network(
                     '${gridContentRecommended.elementAt(0)['images']}',
                   ),
                 ),
               ),
             ),

             // sub content
             SizedBox(
               height: size.height * 0.43,
               width: size.width,
               child: Container(
                 decoration: BoxDecoration(
                   color: Colors.white,
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                       child: Text(
                         "${gridContentRecommended.elementAt(0)["subjudul"]}",
                         style: GoogleFonts.poppins(
                           fontSize: 24,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(left: 20, right: 20),
                       child: Text(
                         "${gridContentRecommended.elementAt(0)["harga"]}",
                         style: GoogleFonts.poppins(
                           color: Colors.deepOrange,
                           fontSize: 26,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                    ),

                     // // category
                     // Padding(
                     //   padding:
                     //   const EdgeInsets.only(top: 10, left: 20, right: 20),
                     //   child: Row(
                     //     children: [
                     //       GestureDetector(
                     //         onTap: () {},
                     //         child: Container(
                     //           height: 45,
                     //           width: 105,
                     //           decoration: BoxDecoration(
                     //             color: AppColors.colorTelu,
                     //             borderRadius: BorderRadius.circular(10),
                     //           ),
                     //           child: Row(
                     //             mainAxisAlignment: MainAxisAlignment.center,
                     //             children: [
                     //               Icon(
                     //                 Icons.local_drink_sharp,
                     //                 color: Colors.brown,
                     //               ),
                     //               SizedBox(width: 5),
                     //               Text(
                     //                 'Coffe',
                     //                 style: GoogleFonts.poppins(
                     //                   fontSize: 16,
                     //                   fontWeight: FontWeight.w600,
                     //                 ),
                     //               ),
                     //             ],
                     //           ),
                     //         ),
                     //       ),
                     //       SizedBox(width: 10),
                     //       GestureDetector(
                     //         onTap: () {},
                     //         child: Container(
                     //           height: 45,
                     //           width: 145,
                     //           decoration: BoxDecoration(
                     //             color: AppColors.colorTelu,
                     //             borderRadius: BorderRadius.circular(10),
                     //           ),
                     //           child: Row(
                     //             mainAxisAlignment: MainAxisAlignment.center,
                     //             children: [
                     //               Icon(
                     //                 FontAwesomeIcons.fire,
                     //                 color: Colors.deepOrange,
                     //               ),
                     //               SizedBox(width: 5),
                     //               Text(
                     //                 'Few Sugar',
                     //                 style: GoogleFonts.poppins(
                     //                   fontSize: 16,
                     //                   fontWeight: FontWeight.w600,
                     //                 ),
                     //               ),
                     //             ],
                     //           ),
                     //         ),
                     //       ),
                     //     ],
                     //   ),
                     // ),
                     //
                     // // choose size
                     // Padding(
                     //   padding:
                     //   const EdgeInsets.only(top: 20, left: 20, right: 20),
                     //   child: Text(
                     //     "Choose cup size glass",
                     //     style: GoogleFonts.poppins(
                     //       color: Colors.grey,
                     //       fontSize: 16,
                     //       fontWeight: FontWeight.w500,
                     //     ),
                     //   ),
                     // ),
                     // Padding(
                     //   padding: const EdgeInsets.only(top: 10, left: 20),
                     //   child: SizedBox(
                     //     height: 35,
                     //     width: size.width,
                     //     child: ListView(
                     //       scrollDirection: Axis.horizontal,
                     //       physics: BouncingScrollPhysics(),
                     //       children: [
                     //         Row(
                     //           children: [
                     //             Container(
                     //               alignment: Alignment.center,
                     //               width: 75,
                     //               decoration: BoxDecoration(
                     //                 color: AppColors.colorLoro,
                     //                 borderRadius: BorderRadius.circular(10),
                     //               ),
                     //               child: Text(
                     //                 'Short',
                     //                 style: GoogleFonts.poppins(
                     //                     fontWeight: FontWeight.w600),
                     //               ),
                     //             ),
                     //             SizedBox(width: 10),
                     //             Container(
                     //               alignment: Alignment.center,
                     //               width: 75,
                     //               decoration: BoxDecoration(
                     //                 color: AppColors.colorLoro,
                     //                 borderRadius: BorderRadius.circular(10),
                     //               ),
                     //               child: Text(
                     //                 'Tall',
                     //                 style: GoogleFonts.poppins(
                     //                     fontWeight: FontWeight.w600),
                     //               ),
                     //             ),
                     //             SizedBox(width: 10),
                     //             Container(
                     //               alignment: Alignment.center,
                     //               width: 75,
                     //               decoration: BoxDecoration(
                     //                 color: AppColors.colorLoro,
                     //                 borderRadius: BorderRadius.circular(10),
                     //               ),
                     //               child: Text(
                     //                 'Grande',
                     //                 style: GoogleFonts.poppins(
                     //                     fontWeight: FontWeight.w600),
                     //               ),
                     //             ),
                     //             SizedBox(width: 10),
                     //             Container(
                     //               alignment: Alignment.center,
                     //               width: 75,
                     //               decoration: BoxDecoration(
                     //                 color: AppColors.colorLoro,
                     //                 borderRadius: BorderRadius.circular(10),
                     //               ),
                     //               child: Text(
                     //                 'Venti',
                     //                 style: GoogleFonts.poppins(
                     //                     fontWeight: FontWeight.w600),
                     //               ),
                     //             ),
                     //             SizedBox(width: 10),
                     //             Container(
                     //               alignment: Alignment.center,
                     //               width: 75,
                     //               decoration: BoxDecoration(
                     //                 color: AppColors.colorLoro,
                     //                 borderRadius: BorderRadius.circular(10),
                     //               ),
                     //               child: Text(
                     //                 'Trenta',
                     //                 style: GoogleFonts.poppins(
                     //                     fontWeight: FontWeight.w600),
                     //               ),
                     //             ),
                     //             SizedBox(width: 10),
                     //           ],
                     //         ),
                     //       ],
                     //     ),
                     //   ),
                     // ),

                     // checkout button
                     Padding(
                       padding: const EdgeInsets.only(top: 30),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                             height: 50,
                             width: size.width * 0.34,
                             decoration: BoxDecoration(
                               color: Colors.grey.shade300,
                               borderRadius: BorderRadius.circular(15),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 25, right: 25),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     '-',
                                     style: GoogleFonts.averiaSerifLibre(
                                         fontSize: 22,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   Text(
                                     '1',
                                     style: GoogleFonts.averiaSerifLibre(
                                         fontSize: 22,
                                         fontWeight: FontWeight.bold),
                                   ),
                                   Text(
                                     '+',
                                     style: GoogleFonts.averiaSerifLibre(
                                         fontSize: 22,
                                         fontWeight: FontWeight.bold),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: size.width * 0.03),
                           Container(
                             height: 50,
                             width: size.width * 0.53,
                             decoration: BoxDecoration(
                                 color: AppColors.colorSiji,
                                 borderRadius: BorderRadius.circular(15)),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 25, right: 25),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     'Add to Cart',
                                     style: GoogleFonts.poppins(
                                       color: Colors.white,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                   Text(
                                     '${gridContentRecommended.elementAt(0)['harga']}',
                                     style: GoogleFonts.poppins(
                                       fontSize: 18,
                                       color: Colors.white,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     )
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     );
   // return Scaffold(
   //    backgroundColor: AppColors.appBackground,
   //    body: Container(
   //      // decoration: BoxDecoration(
   //      //   image: DecorationImage(
   //      //     image: AssetImage("assets/images/example_eight.png"),
   //      //     fit: BoxFit.cover,
   //      //   ),
   //      // ),
   //      child: Stack(
   //        fit: StackFit.expand,
   //        clipBehavior: Clip.none,
   //        alignment: Alignment.center,
   //        children: [
   //       Container()
   //         ,
   //          Visibility(
   //            visible: _loading,
   //            child: CustomLoader(
   //              title: "Listing Details...",
   //            ),
   //          ),
   //        ],
   //      ),
   //    ),
   //  );
  }

  Widget _headerSection() {
    return Container(
      height: 300,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          child: Image.asset("assets/images/back.png"),
        ),
      ),
    );
  }

  // Widget _mainBodySection() {
  //   return Container(
  //     child: Stack(
  //       clipBehavior: Clip.none,
  //       children: [
  //         Positioned(
  //             top: -20,
  //             right: 0,
  //             left: 0,
  //             child: Container(
  //               height: 100,
  //               decoration: new BoxDecoration(
  //                 color: AppColors.whiteColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20)),
  //               ),
  //             )),
  //         Container(
  //           decoration: new BoxDecoration(
  //             color:
  //                 !reachedAtBottom ? AppColors.whiteColor : Colors.transparent,
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //           ),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height:
  //                     (listingDetailsResponseModel.listing!.allowPartial == 1 ||
  //                             widget.fromPage == "profile")
  //                         ? 50
  //                         : 30,
  //               ),
  //               SizedBox(
  //                 height:
  //                     (listingDetailsResponseModel.listing!.name!.length > 30)
  //                         ? 20
  //                         : 0,
  //               ),
  //               _companyDescriptionAndSpecificationsSection(),
  //               widget.fromPage == "profile"
  //                   ? SizedBox(
  //                       height: 250.h,
  //                     )
  //                   : SizedBox(
  //                       height: 30.h,
  //                     ),
  //               widget.fromPage != "profile" && isRelatedListVisible
  //                   ? Container(
  //                       color: AppColors.color5E0010,
  //                       child: Column(
  //                         children: [
  //                           // listingDetailsResponseModel
  //                           //         .moreListingSameCompany!.isNotEmpty
  //                           //     ? _gridLayout(
  //                           //         "More from this seller",
  //                           //         listingDetailsResponseModel
  //                           //             .moreListingSameCompany)
  //                           //     : Container(),
  //                           listingDetailsResponseModel
  //                                   .relatedListings!.isNotEmpty
  //                               ? _gridLayout("Related listings",
  //                                   listingDetailsResponseModel.relatedListings)
  //                               : SizedBox(),
  //                           // SizedBox(
  //                           //   height: 100.h,
  //                           // ),
  //                         ],
  //                       ),
  //                     )
  //                   : SizedBox(),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //             top: -90,
  //             right: 0,
  //             left: 0,
  //             child: _totalBookmarkedAndViewSection()),
  //         Visibility(
  //           visible: listingDetailsResponseModel.listing!.starBuyComment != null
  //               ? true
  //               : false,
  //           child: Positioned(
  //               top: -99,
  //               right: 15,
  //               child: Container(
  //                   width: 25,
  //                   height: 25,
  //                   child: Image.asset("assets/images/iconStarYellow@3x.png"))),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _companyDescriptionAndSpecificationsSection() {
  //   var _crossAxisSpacing = 1;
  //   var _screenWidth = MediaQuery.of(context).size.width;
  //   var _crossAxisCount = 2;
  //   var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
  //       _crossAxisCount;
  //   var cellHeight = 120.h;
  //   var _aspectRatio = _width / cellHeight;
  //
  //   return Container(
  //     //color: Colors.red,
  //     //constraints: BoxConstraints(minHeight: 200.h, minWidth: double.infinity),
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(left: 45.w, right: 45.w, top: 20.h),
  //           child: Row(
  //             children: [
  //               InkWell(
  //                 onTap: () {
  //                   isSpecificationsVisible = false;
  //                   isDescriptionVisible = true;
  //                   description = "• DESCRIPTION";
  //                   specifications = "SPECIFICATIONS";
  //
  //                   setState(() {});
  //                 },
  //                 child: Container(
  //                   child: Text(
  //                     // "• Description",
  //                     description,
  //                     style: TextStyle(
  //                         fontFamily: AppFonts.quicksand,
  //                         fontWeight: FontWeight.w600,
  //                         letterSpacing: 1,
  //                         color: isDescriptionVisible
  //                             ? AppColors.blueDetails
  //                             : AppColors.hintColor,
  //                         fontSize: 16.0.sp),
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   isDescriptionVisible = false;
  //                   isSpecificationsVisible = true;
  //                   description = "DESCRIPTION";
  //                   specifications = "• SPECIFICATIONS";
  //
  //                   setState(() {});
  //                 },
  //                 child: Container(
  //                   margin: EdgeInsets.only(left: 20.w),
  //                   child: Text(
  //                     specifications,
  //                     style: TextStyle(
  //                         fontFamily: AppFonts.quicksand,
  //                         fontWeight: FontWeight.w600,
  //                         letterSpacing: 1,
  //                         color: isSpecificationsVisible
  //                             ? AppColors.blueDetails
  //                             : AppColors.hintColor,
  //                         fontSize: 16.0.sp),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Visibility(
  //             visible: isDescriptionVisible,
  //             maintainState: true,
  //             maintainAnimation: true,
  //             // maintainSize: true,
  //             child: Align(
  //               alignment: Alignment.centerLeft,
  //               child: Container(
  //                 margin: EdgeInsets.only(left: 45.w, right: 45.w, top: 20.h),
  //                 child: Text(
  //                   "${listingDetailsResponseModel.listing!.description}",
  //                   textAlign: TextAlign.start,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.quicksand,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.color001122,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //             )),
  //         Visibility(
  //           visible: isDescriptionVisible,
  //           maintainState: true,
  //           maintainAnimation: true,
  //           // maintainSize: true,
  //           child: Container(
  //             child: FutureBuilder(
  //                 future: _fetchDescriptionListData(),
  //                 builder: (context, AsyncSnapshot snapshot) {
  //                   if (!snapshot.hasData) {
  //                     return Container();
  //                   } else {
  //                     return (snapshot.data.length > 0)
  //                         ? Container(
  //                             margin: EdgeInsets.only(
  //                                 left: 45.w, right: 45.w, top: 15.h),
  //                             child: GridView.builder(
  //                               physics: ScrollPhysics(),
  //                               shrinkWrap: true,
  //                               itemCount: snapshot.data.length,
  //                               scrollDirection: Axis.vertical,
  //                               padding: EdgeInsets.all(0),
  //                               itemBuilder: (BuildContext context, int index) {
  //                                 return _descriptionItem(snapshot.data[index]);
  //                               },
  //                               gridDelegate:
  //                                   new SliverGridDelegateWithFixedCrossAxisCount(
  //                                       crossAxisCount: _crossAxisCount,
  //                                       childAspectRatio: _aspectRatio,
  //                                       crossAxisSpacing: 5),
  //                             ))
  //                         : Container();
  //                   }
  //                 }),
  //           ),
  //         ),
  //         Visibility(
  //           visible: isSpecificationsVisible,
  //           maintainState: true,
  //           maintainAnimation: true,
  //           // maintainSize: true,
  //           child: Container(
  //             child: FutureBuilder(
  //                 future: _fetchSpecificationsListData(),
  //                 builder: (context, AsyncSnapshot snapshot) {
  //                   if (!snapshot.hasData) {
  //                     return Container();
  //                   } else {
  //                     if (listingDetailsResponseModel.listing == null) {
  //                       return SizedBox();
  //                     }
  //
  //                     print(
  //                         "_fetchSpe_fetchSpecificationsListDatacificationsListData ${listingDetailsResponseModel.listing!.currencyId}");
  //
  //                     String currentPriceUpdated =
  //                         "${listingDetailsResponseModel.listing!.pricePerTon}";
  //
  //                     if (listingDetailsResponseModel.listing!.currencyId !=
  //                         Utils.session_currency_id) {
  //                       print(
  //                           "_fetchSpecificationsListData ${Utils.session_currency_id}");
  //                       String originlsCurrencyCode = Utils().checkCurrencyCode(
  //                           listingDetailsResponseModel.listing!.currencyId!);
  //
  //                       print(
  //                           "_fetchSpecificationsListData ${originlsCurrencyCode}");
  //
  //                       String currentCurrencyCode = Utils()
  //                           .checkCurrencyCode(Utils.session_currency_id);
  //
  //                       print(
  //                           "_fetchSpecificationsListData ${currentCurrencyCode}");
  //
  //                       double originalRates = Utils()
  //                           .checkRatesPerCurrencyCode(originlsCurrencyCode);
  //                       double rates = Utils()
  //                           .checkRatesPerCurrencyCode(currentCurrencyCode);
  //
  //                       var ratio = rates / originalRates;
  //
  //                       print("_fetchSpecificationsListData ${ratio}");
  //
  //                       var currentPrice = listingDetailsResponseModel
  //                           .listing!.pricePerTon!
  //                           .replaceAll(',', '');
  //
  //                       var convertedPriceDouble =
  //                           double.parse(currentPrice) * ratio * Utils.modifier;
  //
  //                       NumberFormat appFormat =
  //                           NumberFormat.decimalPattern('en_us');
  //
  //                       var newPrice = convertedPriceDouble.toStringAsFixed(2);
  //
  //                       String convertedPrice =
  //                           appFormat.format(double.parse(newPrice));
  //
  //                       //     (listingDetailsResponseModel.listing!.currencyId !=
  //                       //         Utils.session_currency_id)
  //                       //         ? "~$currentCurrencyCode $convertedPrice/ton"
  //                       //         : "S\$ ${data!.pricePerTon}/ton"
  //                       // ,
  //
  //                       var _formattedNumber = NumberFormat.compactCurrency(
  //                         decimalDigits: 2,
  //                         symbol:
  //                             '', // if you want to add currency symbol then pass that in this else leave it empty.
  //                       );
  //
  //                       String originalPrice =
  //                           _formattedNumber.format(double.parse(currentPrice));
  //
  //                       // currentPriceUpdated = "~$currentCurrencyCode $convertedPrice/ton ($originlsCurrencyCode ${listingDetailsResponseModel.listing!.pricePerTon})";
  //                       currentPriceUpdated =
  //                           "~$currentCurrencyCode $convertedPrice/ton ($originlsCurrencyCode $originalPrice)";
  //
  //                       print(
  //                           "_fetchSpecificationsListData ${currentPriceUpdated}");
  //                     } else {
  //                       print(
  //                           "_fetchSpecificationsListData ### ${Utils.session_currency_id}");
  //                       String currentCurrencyCode =
  //                       Utils().checkCurrencyCode(Utils.session_currency_id);
  //                       var formatableValue = double.parse(currentPriceUpdated.replaceAll(',', ''));
  //                       var formatter = NumberFormat('###,000.00');
  //
  //                       if (formatableValue < 100) {
  //                         formatter = NumberFormat('###,00.00');
  //                       }
  //
  //                       currentPriceUpdated = formatter.format(formatableValue);
  //
  //                       currentPriceUpdated = "$currentCurrencyCode $currentPriceUpdated/ton ";
  //                     }
  //
  //                     var titles = [
  //                       "Price per ton",
  //                       "Total Weight (tons)",
  //                       "Quantity (pieces)"
  //
  //                     ];
  //                     var values = [
  //                       currentPriceUpdated,
  //                       "${listingDetailsResponseModel.listing!.total_weight}",
  //                       "${listingDetailsResponseModel.listing!.total_quantity}"
  //
  //                     ];
  //                     return Container(
  //                         margin: EdgeInsets.only(
  //                             left: 10.w, right: 10.w, top: 15.h),
  //                         child: ListView.builder(
  //                           physics: ScrollPhysics(),
  //                           shrinkWrap: true,
  //                           itemCount: snapshot.data.length + 4,
  //                           scrollDirection: Axis.vertical,
  //                           padding: EdgeInsets.all(0),
  //                           itemBuilder: (BuildContext context, int index) {
  //                             if (index < 3) {
  //                               String currentValue = values[index];
  //
  //                               // if (index > 0) {
  //                               if (index == 1) {
  //                                 var formatableValue =
  //                                     double.parse(currentValue);
  //                                 var formatter = NumberFormat('###,000.00');
  //
  //                                 if (formatableValue < 100) {
  //                                   formatter = NumberFormat('###,00.00');
  //                                 }
  //
  //                                 currentValue =
  //                                     formatter.format(formatableValue);
  //                               }
  //
  //                               return _staticSpecificationsItem(
  //                                   titles[index], currentValue);
  //                             } else if(index == snapshot.data.length + 4 - 1){
  //
  //                               return listingDetailsResponseModel.listing!.remarks != null?_staticSpecificationsItem(
  //                                   "Condition",   "${listingDetailsResponseModel.listing!.remarks}"):Container();
  //                             }
  //
  //                             else {
  //                               return _specificationsItem(
  //                                   snapshot.data[(index - 3)]);
  //                             }
  //                           },
  //                         ));
  //                   }
  //                 }),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // // Widget _descriptionItem(ListingSpecification data) {
  // Widget _descriptionItem(Specifications data) {
  //   String icon = "type.png";
  //
  //   if (data.name!.contains("Side 1")) {
  //     icon = "side_1.png";
  //   } else if (data.name!.contains("Side 2")) {
  //     icon = "side_2.png";
  //   } else if (data.name!.contains("Diameter")) {
  //     icon = "diameter.png";
  //   } else if (data.name!.contains("Total Weight")) {
  //     icon = "total_weight.png";
  //   } else if (data.name!.contains("Quantity")) {
  //     icon = "quantity.png";
  //   } else if (data.name!.contains("Length")) {
  //     icon = "length.png";
  //   } else if (data.name!.contains("Grade")) {
  //     icon = "grade.png";
  //   } else if (data.name!.contains("Weight")) {
  //     icon = "weight.png";
  //   } else if (data.name!.contains("Thickness")) {
  //     icon = "thickness.png";
  //   } else if (data.name!.contains("Height")) {
  //     icon = "height.png";
  //   } else if (data.name!.contains("Width")) {
  //     icon = "width.png";
  //   }
  //
  //   return Container(
  //     margin: EdgeInsets.only(top: 10.h),
  //     decoration: new BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(
  //         color: AppColors.appBackground,
  //         width: 1.0,
  //       ),
  //     ),
  //     child: Stack(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(left: 20.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               Container(
  //                 width: 110.w,
  //                 padding: EdgeInsets.only(right: 25),
  //                 child: Text(
  //                   "${data.name}",
  //                   textAlign: TextAlign.left,
  //                   maxLines: 2,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.hintColor,
  //                       fontSize: 14.0.sp),
  //                 ),
  //               ),
  //               Container(
  //                 child: Text(
  //                   "${data.pivot?.value}",
  //                   textAlign: TextAlign.justify,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w700,
  //                       color: AppColors.color001122,
  //                       fontSize: 20.0.sp),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //           right: 8,
  //           top: 8,
  //           child: Container(
  //             height: 20.w,
  //             width: 20.w,
  //             child: Image.asset(
  //               "assets/images/$icon",
  //               fit: BoxFit.fitWidth,
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _staticSpecificationsItem(String title, String value) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 35.0.w, right: 35.0.w, top: 15.h),
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(top: 1),
  //           color: AppColors.whiteColor,
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //                 color: Colors.transparent,
  //                 child: Text(
  //                   title,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w600,
  //                       color: AppColors.color001122,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //               //Spacer(),
  //               Container(
  //                 //color: Colors.red,
  //                 width: 130.w,
  //                 child: Text(
  //                   //"${data.defaultValue!.first.text}",
  //                   value,
  //                   textAlign: TextAlign.start,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.color001122,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 15.w),
  //           height: .5.h,
  //           width: MediaQuery.of(context).size.width,
  //           color: AppColors.appBackground,
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _specificationsItem(Specifications data) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 35.0.w, right: 35.0.w, top: 15.h),
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.only(top: 1),
  //           color: AppColors.whiteColor,
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: (MediaQuery.of(context).size.width - 40) / 2,
  //                 color: Colors.transparent,
  //                 child: Text(
  //                   "${data.name}",
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w600,
  //                       color: AppColors.color001122,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //               //Spacer(),
  //               GestureDetector(
  //                 onTap: () {},
  //                 child: Text(
  //                   //"${data.defaultValue!.first.text}",
  //                   "${data.pivot!.value.toString()}",
  //                   textAlign: TextAlign.start,
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w400,
  //                       color: AppColors.color001122,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 15.w),
  //           height: .5.h,
  //           width: MediaQuery.of(context).size.width,
  //           color: AppColors.appBackground,
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _gridLayout(String title, List<Listings>? list) {
  //   var _crossAxisSpacing = 1;
  //   var _screenWidth = MediaQuery.of(context).size.width;
  //   var _crossAxisCount = 2;
  //   var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
  //       _crossAxisCount;
  //   var cellHeight = 320.h;
  //   var _aspectRatio = _width / cellHeight;
  //   // var _aspectRatio = 177.w / cellHeight;
  //   return Container(
  //     color: AppColors.color5E0010,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SizedBox(
  //           height: 20.0.h,
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(left: 20.0.w),
  //           child: Row(
  //             children: [
  //               Text(
  //                 // "$title",
  //                 "Related listings",
  //                 style: TextStyle(
  //                     fontFamily: AppFonts.nunitoSans,
  //                     fontWeight: FontWeight.w700,
  //                     color: AppColors.whiteColor,
  //                     fontSize: 18.0.sp),
  //               ),
  //               Spacer(),
  //               GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => ProductListScreen(
  //                               search: null,
  //                               company_id: listingDetailsResponseModel
  //                                   .listing!.company!.id,
  //                               title: "Related listings",
  //                               id: 0,
  //                             )),
  //                   );
  //                 },
  //                 child: Text(
  //                   "View more",
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.nunitoSans,
  //                       fontWeight: FontWeight.w600,
  //                       color: AppColors.whiteColor,
  //                       fontSize: 16.0.sp),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 20.0.w,
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 5.0.h,
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(left: 20, right: 20, top: 20),
  //           child: Container(
  //               child: GridView.builder(
  //             physics: ScrollPhysics(),
  //             shrinkWrap: true,
  //             itemCount: list!.length,
  //             padding: EdgeInsets.all(0.0),
  //             scrollDirection: Axis.vertical,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ProductItem(
  //                 listings: list[index],
  //                 dataDidUpdated: () {
  //                   _requestToListingDetails();
  //                 },
  //                 context: context,
  //                 isBookmarked: false,
  //                 // isBookmarked: list[index].bookmarked == 1 ? true : false,
  //                 isVisibleBookmarkedIcon: false,
  //                 fromPage: "",
  //                 marginLeft: 0.0,
  //                 bookmarkIDs: bookmarkIDs!,
  //               );
  //             },
  //             gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: _crossAxisCount,
  //                 childAspectRatio: _aspectRatio,
  //                 crossAxisSpacing: 20.w,
  //                 mainAxisSpacing: 20.h,
  //                 mainAxisExtent: 310.h),
  //           )),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _gridLayoutItem(Listings data) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => ProductDetailsScreen(
  //                   fromPage: "",
  //                   listingId: 1,
  //                 )),
  //       );
  //     },
  //     child: Container(
  //       width: 180.w,
  //       margin: EdgeInsets.only(left: 20.w),
  //       padding: EdgeInsets.all(10.w),
  //       decoration: new BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             child: Utils().builtItemImageContainer(data.mediaFullUrl),
  //             // child: Image.asset(data.mediaFullUrl),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(top: 10.h),
  //             child: Text(
  //               '${data.name}',
  //               style: TextStyle(
  //                   fontFamily: AppFonts.nunitoSans,
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.w700,
  //                   color: AppColors.color001122),
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(top: 10.h),
  //             child: Text(
  //               '\$${data.total_price}',
  //               style: TextStyle(
  //                   fontFamily: AppFonts.nunitoSans,
  //                   fontSize: 16.sp,
  //                   fontWeight: FontWeight.w600,
  //                   color: AppColors.color001122),
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(top: 10.h),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   height: 35.w,
  //                   width: 35.w,
  //                   decoration: new BoxDecoration(
  //                     color: AppColors.whiteColor,
  //                     borderRadius: BorderRadius.circular(17.5),
  //                     border: Border.all(width: 1, color: Colors.grey),
  //                   ),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(17.5),
  //                     // child: Utils().builtItemImageContainer(data["product_image"])
  //                     child: Image.asset("assets/images/example_seven.png"),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 14.w),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         child: Text(
  //                           'John',
  //                           style: TextStyle(
  //                               fontFamily: AppFonts.nunitoSans,
  //                               fontSize: 14.sp,
  //                               fontWeight: FontWeight.w700,
  //                               color: AppColors.blueColor),
  //                         ),
  //                       ),
  //                       Container(
  //                         child: Text(
  //                           'mliongroup',
  //                           style: TextStyle(
  //                               fontFamily: AppFonts.nunitoSans,
  //                               fontSize: 12.sp,
  //                               fontWeight: FontWeight.w400,
  //                               color: AppColors.blueColor),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _totalBookmarkedAndViewSection() {
  //   var formatter = NumberFormat('###,000.00');
  //
  //   if (listingDetailsResponseModel.listing!.total_price! < 100) {
  //     formatter = NumberFormat('###,00.00');
  //   }
  //
  //   // for price conversion ========= start
  //
  //   String originalCurrencyCode = "SGD";
  //
  //   if (listingDetailsResponseModel.listing!.currencyId == 1) {
  //     originalCurrencyCode = "SGD";
  //   } else if (listingDetailsResponseModel.listing!.currencyId == 2) {
  //     originalCurrencyCode = "IDR";
  //   } else if (listingDetailsResponseModel.listing!.currencyId == 3) {
  //     originalCurrencyCode = "MYR";
  //   } else if (listingDetailsResponseModel.listing!.currencyId == 4) {
  //     originalCurrencyCode = "PHP";
  //   } else if (listingDetailsResponseModel.listing!.currencyId == 5) {
  //     originalCurrencyCode = "THB";
  //   } else if (listingDetailsResponseModel.listing!.currencyId == 6) {
  //     originalCurrencyCode = "USD";
  //   }
  //
  //   var originalRates = 0.0;
  //
  //   if (appUtility.rates != null) {
  //     var allRates = appUtility.rates!.keys;
  //
  //     for (var aKey in allRates) {
  //       print("rates   ${appUtility.rates![aKey]}");
  //       print("rates   $aKey");
  //       if (originalCurrencyCode == aKey)
  //         originalRates = double.parse("${appUtility.rates![aKey]}");
  //     }
  //   }
  //
  //   String currencyCode = "SGD";
  //
  //   int currency_id = 1;
  //
  //   (UserModel.isLoggedIn != null && UserModel.isLoggedIn)
  //       ? currency_id = UserModel.currencyId!
  //       : currency_id = Utils.session_currency_id;
  //
  //   if (currency_id == 1) {
  //     currencyCode = "SGD";
  //   } else if (currency_id == 2) {
  //     currencyCode = "IDR";
  //   } else if (currency_id == 3) {
  //     currencyCode = "MYR";
  //   } else if (currency_id == 4) {
  //     currencyCode = "PHP";
  //   } else if (currency_id == 5) {
  //     currencyCode = "THB";
  //   } else if (currency_id == 6) {
  //     currencyCode = "USD";
  //   }
  //
  //   var rates = 0.0;
  //
  //   if (appUtility.rates != null) {
  //     var allRates = appUtility.rates!.keys;
  //
  //     for (var aKey in allRates) {
  //       print("rates   ${appUtility.rates![aKey]}");
  //       print("rates   $aKey");
  //       if (currencyCode == aKey)
  //         rates = double.parse("${appUtility.rates![aKey]}");
  //     }
  //   }
  //
  //   var ratio = rates / originalRates;
  //
  //   var currentPrice =
  //       listingDetailsResponseModel.listing!.pricePerTon!.replaceAll(',', '');
  //   var currentTotalPrice = listingDetailsResponseModel.listing!.total_price!;
  //
  //   //var convertedPriceDouble = double.parse(currentPrice)*ratio*Utils.modifier;
  //   var convertedPriceDouble = currentTotalPrice * ratio * Utils.modifier;
  //
  //   NumberFormat appFormat = NumberFormat.decimalPattern('en_us');
  //
  //   var newPrice = convertedPriceDouble.toStringAsFixed(2);
  //
  //   String convertedPrice = appFormat.format(double.parse(newPrice));
  //
  //   var _formattedNumber = NumberFormat.compactCurrency(
  //     decimalDigits: 2,
  //     symbol:
  //         '', // if you want to add currency symbol then pass that in this else leave it empty.
  //   );
  //
  //   // String originalPrice = _formattedNumber.format(double.parse(currentPrice));
  //   String originalPrice = _formattedNumber.format(currentTotalPrice);
  //
  //   // for price conversion ========= end
  //
  //   //Colors
  //   var bgColors = Colors.white;
  //   var textColors = Colors.black;
  //
  //   if (listingDetailsResponseModel.listing!.status.toString() == "draft") {
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "in review") {
  //     bgColors = Color(0xffEFC100).withOpacity(.50);
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "published") {
  //     bgColors = Color(0xffDCF7A7);
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "archived") {
  //     bgColors = Color(0xff0EC583);
  //   }
  //   else if (listingDetailsResponseModel.listing!.status.toString() == "reserved") {
  //     bgColors = Color(0xff024668);
  //     textColors = Colors.white;
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "sold") {
  //     textColors = Colors.white;
  //     bgColors = Color(0xff001122);
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "delisted") {
  //     textColors = Colors.white;
  //     bgColors = Color(0xffEB5757).withOpacity(.50);
  //   } else if (listingDetailsResponseModel.listing!.status.toString() == "declined") {
  //     textColors = Colors.white;
  //     bgColors = Color(0xffEB5757);
  //   }
  //
  //   return Container(
  //     //height: 130,
  //     padding: EdgeInsets.fromLTRB(25, 20, 20, 20),
  //     margin: EdgeInsets.only(left: 20, right: 20),
  //     width: MediaQuery.of(context).size.width,
  //     decoration: new BoxDecoration(
  //       color: AppColors.blueDetails,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             listingDetailsResponseModel.listing!.status != null &&
  //                     widget.fromPage == "profile"
  //                 // widget.receivedMap!["status"] == "draft"
  //                 ? Container(
  //                     height: 16,
  //                     //width: 105.w,
  //                     padding: EdgeInsets.only(left: 5, right: 5),
  //                     margin: EdgeInsets.only(right: 3),
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(4),
  //                       color: bgColors,
  //                       boxShadow: [
  //                         BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //                       ],
  //                       border: Border.all(
  //                         color: bgColors,
  //                         width: 1.0,
  //                       ),
  //                     ),
  //                     child: Text(
  //                         // listingDetailsResponseModel.listing!.status
  //                         //     .toString()
  //                         listingDetailsResponseModel.listing!.status
  //                             .toString()
  //                             .toUpperCase(),
  //                         style: TextStyle(
  //                             color: textColors,
  //                             fontSize: 8,
  //                             fontWeight: FontWeight.w700,
  //                             fontFamily: AppFonts.nunitoSans)))
  //                 : Container(),
  //             //listingDetailsResponseModel.listing!.allowPartial == 1
  //             listingDetailsResponseModel.listing!.allowPartial == 1
  //                 ? Container(
  //                     height: 16,
  //                     width: 65,
  //                     //margin: EdgeInsets.only(left: 20.w, right: 20.w),
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(4),
  //                       color: Colors.white,
  //                       boxShadow: [
  //                         BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //                       ],
  //                       border: Border.all(
  //                         color: Colors.white,
  //                         width: 1.0,
  //                       ),
  //                     ),
  //                     child: Text("Partial sale".toUpperCase(),
  //                         style: TextStyle(
  //                             color: AppColors.colorE07809,
  //                             fontSize: 8,
  //                             fontWeight: FontWeight.w700,
  //                             fontFamily: AppFonts.nunitoSans)))
  //                 : Container(),
  //           ],
  //         ),
  //         SizedBox(
  //           height:
  //               listingDetailsResponseModel.listing!.allowPartial == 1 ? 5 : 0,
  //         ),
  //         Text(
  //           "${listingDetailsResponseModel.listing!.name}",
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //           style: TextStyle(
  //               fontFamily: AppFonts.nunitoSans,
  //               fontWeight: FontWeight.w600,
  //               color: AppColors.whiteColor,
  //               fontSize: 20.0),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 5.h),
  //           child: Text(
  //             (listingDetailsResponseModel.listing!.currencyId !=
  //                     Utils.session_currency_id)
  //                 ? "~$currencyCode $convertedPrice  ($originalCurrencyCode $originalPrice)"
  //                 : "$originalCurrencyCode ${formatter.format(listingDetailsResponseModel.listing!.total_price)}",
  //             style: TextStyle(
  //                 fontFamily: AppFonts.nunitoSans,
  //                 fontWeight: FontWeight.w600,
  //                 color: AppColors.whiteColor,
  //                 fontSize: 16.0),
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(top: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                 child: Image.asset(
  //                   "assets/images/product_details_bookmark.png",
  //                   height: 12.w,
  //                   width: 12.w,
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(left: 4.w),
  //                 child: Text(
  //                   "${listingDetailsResponseModel.listing!.bookmarked} Bookmarked",
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.quicksand,
  //                       fontWeight: FontWeight.normal,
  //                       color: AppColors.whiteColor,
  //                       fontSize: 12.0),
  //                 ),
  //               ),
  //               // Container(
  //               //   margin: EdgeInsets.only(left: 10, right: 10),
  //               //   height: 12,
  //               //   width: .5,
  //               //   color: AppColors.whiteColor,
  //               // ),
  //               Container(
  //                 margin: EdgeInsets.only(left: 8.w),
  //                 child: Image.asset(
  //                   "assets/images/view.png",
  //                   height: 12.w,
  //                   width: 12.w,
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(left: 4.w),
  //                 child: Text(
  //                   "${listingDetailsResponseModel.listing!.views} Views",
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.quicksand,
  //                       fontWeight: FontWeight.normal,
  //                       color: AppColors.whiteColor,
  //                       fontSize: 12.0),
  //                 ),
  //               ),
  //
  //               Container(
  //                 margin: EdgeInsets.only(left: 8.w),
  //                 child: Image.asset(
  //                   "assets/images/ic_clock.png",
  //                   height: 12.w,
  //                   width: 12.w,
  //                 ),
  //               ),
  //
  //               Container(
  //                 margin: EdgeInsets.only(left: 4.w),
  //                 child: Text(
  //                   // "Created at\n${Utils().formatDate("${listingDetailsResponseModel.listing!.createdAt}", 'd/MM/yyyy')}",
  //                   TimeAgo.timeAgoSinceDate(
  //                       "${listingDetailsResponseModel.listing!.createdAt}"),
  //                   style: TextStyle(
  //                       fontFamily: AppFonts.quicksand,
  //                       fontWeight: FontWeight.normal,
  //                       color: AppColors.whiteColor,
  //                       fontSize: 12),
  //                 ),
  //
  //                 // Text(
  //                 //   "ID: ${listingDetailsResponseModel.listing!.id}",
  //                 //   style: TextStyle(
  //                 //       fontFamily: AppFonts.nunitoSans,
  //                 //       fontWeight: FontWeight.w400,
  //                 //       color: AppColors.whiteColor,
  //                 //       fontSize: 12.0.sp),
  //                 // ),
  //               ),
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _chatWithSeller(Category? category) {
  //   return Container(
  //     height: 88,
  //     //padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
  //       color: AppColors.colorEFAF31,
  //     ),
  //     child: Row(
  //       children: [
  //         InkWell(
  //           onTap: () {
  //             //UserModel.comingFrom = "calculator";
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => CalculatorScreen(
  //                         fromHome: 0,
  //                    // catagory: category?.id,
  //                     categoryObject: category,
  //                       )),
  //             );
  //           },
  //           child: Container(
  //             margin: EdgeInsets.only(left: 20.w),
  //             child: Image.asset(
  //               "assets/images/ic_calculator_white.png",
  //               height: 50,
  //               width: 50,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //         ),
  //         InkWell(
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(builder: (context) => BookMarkedScreen()),
  //             // );
  //
  //             if (UserModel.isLoggedIn != null && UserModel.isLoggedIn) {
  //               if (isBookmarked) {
  //                 showDialog(
  //                   context: context,
  //                   builder: (_) =>
  //                       _showAreYouSureRemoveBookmarkDialog(context),
  //                 );
  //               } else {
  //                 _userBookmarkAddRequest(widget.listingId);
  //               }
  //             } else {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => new SignUpOverlayScreen()));
  //             }
  //           },
  //           child: Container(
  //             margin: EdgeInsets.only(left: 10),
  //             child: Image.asset(
  //               isBookmarked
  //                   ? "assets/images/ic_bookmark_selected.png"
  //                   : "assets/images/ic_bookmark_details.png",
  //               height: 50,
  //               width: 50,
  //               fit: BoxFit.contain,
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           //flex: 4,
  //           child: InkWell(
  //             onTap: () {
  //               if (UserModel.isLoggedIn != null && UserModel.isLoggedIn) {
  //                 /*Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => ChatScreen(
  //                             listingId:
  //                                 listingDetailsResponseModel.listing!.id,
  //                             buyerId:
  //                                 listingDetailsResponseModel.listing!.user!.id,
  //                             sellerId:
  //                                 listingDetailsResponseModel.listing!.user!.id,
  //                           )),
  //                 );*/
  //
  //                 if(widget.fromPage=="chat"){
  //                   Navigator.pop(context);
  //                 }else {
  //                  if (listingDetailsResponseModel.listing!.status.toString() != 'sold' && listingDetailsResponseModel.listing!.status.toString() != 'reserved') {
  //
  //                    print(listingDetailsResponseModel.listing!.status.toString());
  //
  //                    Navigator.push(
  //                      context,
  //                      MaterialPageRoute(
  //                          builder: (context) =>
  //                              ChatScreen(
  //                                listingId:
  //                                listingDetailsResponseModel.listing!.id,
  //                                userId:
  //                                listingDetailsResponseModel.listing!.userId,
  //                                listings: listingDetailsResponseModel.listing,
  //                                from: "details",
  //                              )),
  //                    );
  //                  }
  //                 }
  //               } else {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => new SignUpOverlayScreen()));
  //               }
  //             },
  //             child: Container(
  //                 height: 50,
  //                 margin: EdgeInsets.only(left: 10, right: 20),
  //                 alignment: Alignment.center,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: Colors.white,
  //                   boxShadow: [
  //                     BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //                   ],
  //                   border: Border.all(
  //                     color: Colors.white,
  //                     width: 1.0,
  //                   ),
  //                 ),
  //                 child: Text((listingDetailsResponseModel.listing!.status.toString() != 'sold' && listingDetailsResponseModel.listing!.status.toString() != 'reserved')?"Chat ":"Chat unavailable",
  //                     style: TextStyle(
  //                         color: (listingDetailsResponseModel.listing!.status.toString() != 'sold' && listingDetailsResponseModel.listing!.status.toString() != 'reserved')?AppColors.color001122:AppColors.hintColor,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w700,
  //                         fontFamily: AppFonts.nunitoSans))),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _markAsAndManageListingItem() {
  //   return Container(
  //     padding: EdgeInsets.all(20),
  //     height: 88,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
  //       color: AppColors.color5E0010,
  //       boxShadow: [
  //         BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //       ],
  //     ),
  //     child: Row(
  //       children: [
  //         Visibility(
  //           visible: (listingDetailsResponseModel.listing!.status
  //               .toString() ==
  //               "published" ||listingDetailsResponseModel.listing!.status
  //               .toString() ==
  //               "archived" ||listingDetailsResponseModel.listing!.status
  //               .toString() ==
  //               "reserved" ||listingDetailsResponseModel.listing!.status
  //               .toString() ==
  //               "sold" ||listingDetailsResponseModel.listing!.status
  //               .toString() ==
  //               "in review")?false:true,
  //           child: Expanded(
  //             child: InkWell(
  //           onTap: () async {
  //             //displayMarkAsAndManageListBottomSheet(context);
  //             String status = "Draft";
  //             if (listingDetailsResponseModel.listing!.status.toString() ==
  //                 "draft") {
  //               statusList = [
  //                 "Draft",
  //                 "In Review",
  //               ];
  //               status = "Draft";
  //             } else if (listingDetailsResponseModel.listing!.status
  //                     .toString() ==
  //                 "published") {
  //               statusList = [
  //                 "Published",
  //                 "Sold",
  //               ];
  //               status = "Published";
  //             } else if (listingDetailsResponseModel.listing!.status
  //                     .toString() ==
  //                 "delisted") {
  //               statusList = ["Delisted", "Published"];
  //               status = "Delisted";
  //             } else if (listingDetailsResponseModel.listing!.status
  //                     .toString() ==
  //                 "declined") {
  //               statusList = ["Declined", "Draft"];
  //               status = "Declined";
  //             } else {
  //               status = "In Review";
  //             }
  //
  //             if (status != "In Review") {
  //               //_createHotSpotDialog(status, context);
  //               _dropDownValue2 = status;
  //
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => Material(
  //                   type: MaterialType.transparency,
  //                   child: Center(
  //                     // Aligns the container to center
  //                     child: Container(
  //                       child: _showUpdateStatusListingDialog(context, status),
  //                     ),
  //                   ),
  //                 ),
  //               ).then((_) => setState(() {}));
  //
  //
  //               // currently not in use,dialog can return value after close, for testing code
  //               // final result = await showDialog<bool>();
  //               // if (result!) {
  //               //   // refresh screen}
  //               //   _requestToListingDetails();
  //               // }
  //
  //
  //             } else {
  //               Utils().showToast("Listing in review.", true);
  //             }
  //           },
  //           child: Container(
  //               height: 50.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //                 boxShadow: [
  //                   BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //                 ],
  //                 border: Border.all(
  //                   color: Colors.white,
  //                   //                   <--- border color
  //                   width: 1.0,
  //                 ),
  //               ),
  //               child: Text("Update status",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w700,
  //                       fontFamily: AppFonts.nunitoSans))),
  //         )),
  //         ),
  //         (listingDetailsResponseModel.listing!.status
  //             .toString() ==
  //             "published" ||listingDetailsResponseModel.listing!.status
  //             .toString() ==
  //             "archived"||listingDetailsResponseModel.listing!.status
  //             .toString() ==
  //             "reserved" ||listingDetailsResponseModel.listing!.status
  //             .toString() ==
  //             "sold" ||listingDetailsResponseModel.listing!.status
  //             .toString() ==
  //             "in review")?Container():SizedBox(
  //           width: 10.w,
  //         ),
  //         Expanded(
  //             child: InkWell(
  //           onTap: () {
  //             if (listingDetailsResponseModel.listing!.status.toString() !=
  //                 'draft') {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => Material(
  //                   type: MaterialType.transparency,
  //                   child: Center(
  //                     // Aligns the container to center
  //                     child: Container(
  //                       child: _showAreYouSureEditListingDialog(context),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               showDialog(
  //                 context: context,
  //                 builder: (_) => Material(
  //                   type: MaterialType.transparency,
  //                   child: Center(
  //                     // Aligns the container to center
  //                     child: Container(
  //                       child: _showConfirmEditListingDialog(context),
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }
  //           },
  //           child: Container(
  //               height: 50.h,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.white,
  //                 boxShadow: [
  //                   BoxShadow(color: Colors.transparent, spreadRadius: 3),
  //                 ],
  //                 border: Border.all(
  //                   color: Colors.white,
  //                   //                   <--- border color
  //                   width: 1.0,
  //                 ),
  //               ),
  //               child: Text("Edit Listing / Chat",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w700,
  //                       fontFamily: AppFonts.nunitoSans))),
  //         )),
  //       ],
  //     ),
  //   );
  // }
  //
  // /// When product has variation , then it will be displayed ///
  // void displayMarkAsAndManageListBottomSheet(BuildContext context) {
  //   showCupertinoModalPopup(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           height: MediaQuery.of(context).size.height * .7,
  //           child: MarkAsBottomSheet(
  //             dataDidUpdated: (data) {},
  //             markAsList: markAsList,
  //           ),
  //         );
  //       });
  // }
  //
  // void _createHotSpotDialog(String status, BuildContext myContext) {
  //   showModalBottomSheet(
  //       context: context,
  //       isDismissible: false,
  //       backgroundColor: Colors.transparent,
  //       useRootNavigator: true,
  //       builder: (context) {
  //         return Container(
  //             height: 250.h,
  //             color: Colors.transparent,
  //             child: Column(
  //               children: <Widget>[
  //                 //Text("data"),
  //                 Container(
  //                     margin: EdgeInsets.all(10),
  //                     decoration: BoxDecoration(
  //                         color: AppColors.appBackground,
  //                         borderRadius: BorderRadius.circular(15)),
  //                     child: Column(
  //                       children: <Widget>[
  //                         Container(
  //                           alignment: Alignment.center,
  //                           height: 45.h,
  //                           child: Center(
  //                             child: Container(
  //                               child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: <Widget>[
  //                                   Container(
  //                                       child: Text(
  //                                     "Update status",
  //                                     style: TextStyle(
  //                                         fontSize: 14.sp,
  //                                         color: AppColors.hintColor,
  //                                         fontFamily: AppFonts.quicksand),
  //                                   )),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                             height: .5.h,
  //                             margin: EdgeInsets.only(left: 20.w, right: 20.w),
  //                             color: AppColors.hintColor),
  //                         // _buildHotspotDialogOptionItem(status),
  //                         InkWell(
  //                           onTap: () {
  //                             // widget.onTap(type);
  //                             // Navigator.pop(context);
  //                             _requestToChangeStatusListing(
  //                                 status.toLowerCase(), context);
  //                           },
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             height: 45.h,
  //                             child: Center(
  //                               child: Container(
  //                                 child: Row(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   children: <Widget>[
  //                                     Container(
  //                                         child: Text(
  //                                       (status.contains("Review")
  //                                           ? status
  //                                           : "Mark as $status"),
  //                                       style: TextStyle(
  //                                           fontSize: 16.sp,
  //                                           color: AppColors.blackColor,
  //                                           fontWeight: FontWeight.w700,
  //                                           fontFamily: AppFonts.quicksand),
  //                                     )),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     )),
  //                 SizedBox(height: 5),
  //                 GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Container(
  //                         margin: EdgeInsets.all(10),
  //                         alignment: Alignment.center,
  //                         height: 45,
  //                         decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(15)),
  //                         child: Text(
  //                           "Cancel",
  //                           style: TextStyle(
  //                               fontSize: 16.sp,
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.w700,
  //                               fontFamily: AppFonts.quicksand),
  //                         ))),
  //                 SizedBox(
  //                   height: 5,
  //                 )
  //               ],
  //             ));
  //       });
  // }
  //
  // Widget _buildHotspotDialogOptionItem(String optionText) {
  //   return InkWell(
  //     child: Container(
  //       alignment: Alignment.center,
  //       height: 45.h,
  //       child: Center(
  //         child: Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               Container(
  //                   child: Text(
  //                 optionText,
  //                 style: TextStyle(
  //                     fontSize: 16.sp,
  //                     color: AppColors.blackColor,
  //                     fontWeight: FontWeight.w700,
  //                     fontFamily: AppFonts.quicksand),
  //               )),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     onTap: () {
  //       // widget.onTap(type);
  //
  //       //  _requestToChangeStatusListing(optionText.toLowerCase());
  //     },
  //   );
  // }
  //
  // _requestToChangeStatusListing(String status, BuildContext myContext) async {
  //   _showProgressHud();
  //
  //   Map<String, dynamic> parameters = Map<String, dynamic>();
  //   parameters["id"] = "${listingDetailsResponseModel.listing?.id}";
  //   parameters["status"] =
  //       (status == "submit for review") ? "in review" : "$status".toLowerCase();
  //
  //   //  parameters["company_id"] = "1";
  //   //  parameters["photos"] = "";
  //
  //   print(parameters.toString());
  //
  //   ResponseObject responseObject =
  //       await repository.listingsChangeStatusRequest(parameters);
  //
  //   switch (responseObject.id) {
  //     case ResponseCode.SUCCESSFUL:
  //       _hideProgressHud();
  //
  //       // ListingsCreateResponseModel listingsCreateResponseModel =
  //       // responseObject.object as ListingsCreateResponseModel;
  //
  //       final snackBar = SnackBar(
  //         backgroundColor: AppColors.color1C8047,
  //         content: const Text(
  //           'Listing Updated',
  //           style: TextStyle(
  //             fontFamily: AppFonts.nunitoSans,
  //             fontWeight: FontWeight.w700,
  //             color: AppColors.whiteColor,
  //           ),
  //         ),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => BottomBarRootScreen()),
  //       // );
  //       // Navigator.pop(myContext);
  //
  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       _requestToListingDetails();
  //       if (widget.callBackFunction != null) {
  //         widget.callBackFunction!();
  //       }
  //       // Navigator.popAndPushNamed(context, '/ProductDetailsScreen');
  //       // widget.callBackFunction!;
  //       break;
  //     case ResponseCode.FAILED:
  //       _hideProgressHud();
  //       Utils().showToast("Listing update failed.", false);
  //       break;
  //     case ResponseCode.AUTHORIZATION_FAILED:
  //       _hideProgressHud();
  //       break;
  //   }
  // }
  //
  // _requestToListingDetails() async {
  //   print("Listing Details called.");
  //   _showProgressHud();
  //
  //   Map<String, dynamic> parameters = Map<String, dynamic>();
  //   parameters["id"] = "${widget.listingId}";
  //
  //   ResponseObject responseObject =
  //       await repository.listingDetailsRequest(parameters);
  //
  //   switch (responseObject.id) {
  //     case ResponseCode.SUCCESSFUL:
  //       listingDetailsResponseModel =
  //           responseObject.object as ListingDetailsResponseModel;
  //       bookmarkIDs = listingDetailsResponseModel.bookmarkIDs;
  //
  //       if (bookmarkIDs != null &&
  //           bookmarkIDs!.isNotEmpty &&
  //           bookmarkIDs!.contains(widget.listingId)) {
  //         isBookmarked = true;
  //       }
  //
  //       _hideProgressHud();
  //       break;
  //     case ResponseCode.FAILED:
  //       _hideProgressHud();
  //       Utils().showToast("Listing Details Failed.", false);
  //       break;
  //     case ResponseCode.AUTHORIZATION_FAILED:
  //       _hideProgressHud();
  //       break;
  //   }
  // }
  //
  // Widget _showAreYouSureRemoveBookmarkDialog(BuildContext context) {
  //   return AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  //     content: Container(
  //         height: 235.h,
  //         child: AreYouSureDialog(
  //             dataDidUpdated: () {
  //               // widget.dataDidUpdated();
  //               final snackBar = SnackBar(
  //                 backgroundColor: AppColors.color1C8047,
  //                 content: const Text(
  //                   'Bookmark successfully removed.',
  //                   style: TextStyle(
  //                     fontFamily: AppFonts.nunitoSans,
  //                     fontWeight: FontWeight.w700,
  //                     color: AppColors.whiteColor,
  //                   ),
  //                 ),
  //               );
  //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //
  //               isBookmarked = false;
  //               setState(() {});
  //             },
  //             title: 'Are you sure?',
  //             listingId: widget.listingId)),
  //   );
  // }
  //
  // _userBookmarkAddRequest(int? listingId) async {
  //   Map<String, dynamic> parameters = Map<String, dynamic>();
  //   parameters["listing_id"] = "${listingId}";
  //
  //   ResponseObject responseObject =
  //       await repository.userBookmarkAddRequest(parameters);
  //
  //   switch (responseObject.id) {
  //     case ResponseCode.SUCCESSFUL:
  //       //widget.dataDidUpdated();
  //       //Utils().showToast("Listing bookmarked.", false);
  //       final snackBar = SnackBar(
  //         backgroundColor: AppColors.color1C8047,
  //         content: const Text(
  //           'Bookmark saved.',
  //           style: TextStyle(
  //             fontFamily: AppFonts.nunitoSans,
  //             fontWeight: FontWeight.w700,
  //             color: AppColors.whiteColor,
  //           ),
  //         ),
  //         // behavior: SnackBarBehavior.floating,
  //         // // shape: RoundedRectangleBorder(
  //         // //   borderRadius: BorderRadius.circular(24),
  //         // // ),
  //         // margin: EdgeInsets.only(
  //         //     bottom: MediaQuery.of(context).size.height - 150,
  //         //     right: 0,
  //         //     left: 0),
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       isBookmarked = true;
  //       setState(() {});
  //       break;
  //     case ResponseCode.FAILED:
  //       Utils().showToast("Listing Bookmarked Failed.", false);
  //       break;
  //     case ResponseCode.AUTHORIZATION_FAILED:
  //       break;
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  // }
  //
  // Widget _showAreYouSureEditListingDialog(BuildContext context) {
  //   return Container(
  //     width: 334.w,
  //     height: 455.h,
  //     child: Stack(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(.5),
  //                 spreadRadius: 0,
  //                 blurRadius: 0,
  //                 offset: Offset(0, 0), // changes position of shadow
  //               ),
  //             ],
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //             border: Border.all(
  //               color: Colors.white,
  //               width: 1.0,
  //             ),
  //           ),
  //           padding: EdgeInsets.only(left: 40.w, right: 40.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: 40.h),
  //                 child: Text(
  //                   "Edit listing",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 25.sp,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: AppFonts.quicksand),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               SizedBox(
  //                 child: Text(
  //                   "Please chat with us to edit your listing. ",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: AppFonts.nunitoSans),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30.h,
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //
  //                   Future.delayed(Duration(microseconds: 500), () {
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => ChatScreen(
  //                                 listingId:
  //                                     listingDetailsResponseModel.listing!.id,
  //                                 userId: listingDetailsResponseModel
  //                                     .listing!.userId,
  //                                 listings: listingDetailsResponseModel.listing,
  //                                 from: "details",
  //                               )),
  //                     );
  //                   });
  //
  //                   //_userBookmarkRemoveRequest(widget.listingId);
  //                   /*Navigator.of(context, rootNavigator: true).pop();
  //
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => SellScreen(
  //                             fromPage: "",
  //                             listingId: widget.listingId,
  //                             dataDidUpdated: () {
  //                               _requestToListingDetails();
  //
  //                               if (widget.callBackFunction != null) {
  //                                 widget.callBackFunction!();
  //                               }
  //                             })),
  //                   );*/
  //                   // Navigator.pushReplacement(
  //                   //   context,
  //                   //   MaterialPageRoute(
  //                   //       builder: (context) => BottomBarRootScreen()),
  //                   // );
  //                 },
  //                 child: Container(
  //                   child: CommonButton(
  //                     title: "Go to chat",
  //                     titleTextSize: 16.sp,
  //                     titleTextColor: AppColors.whiteColor,
  //                     backgroundColor: AppColors.color3B7497,
  //                     borderColor: AppColors.color3B7497,
  //                     height: 39.h,
  //                     width: MediaQuery.of(context).size.width,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     isBottomPadding: false,
  //                     context: context,
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                 },
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 10.h),
  //                   child: CommonButton(
  //                     title: "Cancel",
  //                     titleTextSize: 16.sp,
  //                     titleTextColor: AppColors.color001122,
  //                     backgroundColor: Colors.white,
  //                     borderColor: AppColors.hintColor,
  //                     height: 39.h,
  //                     width: MediaQuery.of(context).size.width,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     isBottomPadding: false,
  //                     context: context,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 40.h,
  //               ),
  //               SizedBox(
  //                 child: Text(
  //                   "Why chat with us?",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                       fontFamily: AppFonts.nunitoSans),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               SizedBox(
  //                 child: Text(
  //                   "We verify all the listings infromation on our platform in order give you the best browsing experience and keep you away from fake and spam listings.",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: AppFonts.nunitoSans),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //             right: 20,
  //             top: 20,
  //             child: InkWell(
  //               onTap: () {
  //                 Navigator.of(context, rootNavigator: true).pop();
  //               },
  //               child: Container(
  //                 child: Icon(
  //                   Icons.clear,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _showConfirmEditListingDialog(BuildContext context) {
  //   return Container(
  //     width: 334.w,
  //     height: 312.h,
  //     child: Stack(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(.5),
  //                 spreadRadius: 0,
  //                 blurRadius: 0,
  //                 offset: Offset(0, 0), // changes position of shadow
  //               ),
  //             ],
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //             border: Border.all(
  //               color: Colors.white,
  //               width: 1.0,
  //             ),
  //           ),
  //           padding: EdgeInsets.only(left: 40.w, right: 40.w),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(top: 40.h),
  //                 child: Text(
  //                   "Edit listing",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 25.sp,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: AppFonts.quicksand),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.h,
  //               ),
  //               SizedBox(
  //                 child: Text(
  //                   "You listing will be delisted while we are reviewing your listing.",
  //                   style: TextStyle(
  //                       color: AppColors.color001122,
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.w400,
  //                       fontFamily: AppFonts.nunitoSans),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30.h,
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => EditListingScreen(
  //                             fromPage: "",
  //                             listingId: widget.listingId,
  //                             dataDidUpdated: () {
  //                              // _requestToListingDetails();
  //
  //                               if (widget.callBackFunction != null) {
  //                                 widget.callBackFunction!();
  //                               }
  //                             })),
  //                   ).then((value){  _requestToListingDetails();});
  //                   /*Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                         builder: (context) => SellScreen(
  //                             fromPage: "",
  //                             listingId: widget.listingId,
  //                             dataDidUpdated: () {
  //                               _requestToListingDetails();
  //
  //                               if (widget.callBackFunction != null) {
  //                                 widget.callBackFunction!();
  //                               }
  //                             })),
  //                   );*/
  //                 },
  //                 child: Container(
  //                   child: CommonButton(
  //                     title: "Yes, I’m sure",
  //                     titleTextSize: 16.sp,
  //                     titleTextColor: AppColors.whiteColor,
  //                     backgroundColor: AppColors.color3B7497,
  //                     borderColor: AppColors.color3B7497,
  //                     height: 39.h,
  //                     width: MediaQuery.of(context).size.width,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     isBottomPadding: false,
  //                     context: context,
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                 },
  //                 child: Container(
  //                   margin: EdgeInsets.only(top: 10.h),
  //                   child: CommonButton(
  //                     title: "Cancel",
  //                     titleTextSize: 16.sp,
  //                     titleTextColor: AppColors.color001122,
  //                     backgroundColor: Colors.white,
  //                     borderColor: AppColors.hintColor,
  //                     height: 39.h,
  //                     width: MediaQuery.of(context).size.width,
  //                     borderRadius: BorderRadius.all(Radius.circular(10)),
  //                     isBottomPadding: false,
  //                     context: context,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 30.h,
  //               )
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //             right: 20,
  //             top: 20,
  //             child: InkWell(
  //               onTap: () {
  //                 Navigator.of(context, rootNavigator: true).pop();
  //               },
  //               child: Container(
  //                 child: Icon(
  //                   Icons.clear,
  //                   color: Colors.black,
  //                 ),
  //               ),
  //             )),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _showUpdateStatusListingDialog(BuildContext context, String status) {
  //   return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter setState) {
  //     return Container(
  //       width: 334.w,
  //       height: 312.h,
  //       child: Stack(
  //         children: [
  //           Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(.5),
  //                   spreadRadius: 0,
  //                   blurRadius: 0,
  //                   offset: Offset(0, 0), // changes position of shadow
  //                 ),
  //               ],
  //               borderRadius: BorderRadius.all(Radius.circular(10)),
  //               border: Border.all(
  //                 color: Colors.white,
  //                 width: 1.0,
  //               ),
  //             ),
  //             padding: EdgeInsets.only(left: 40.w, right: 40.w),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(top: 40.h),
  //                   child: Text(
  //                     "Select a status",
  //                     style: TextStyle(
  //                         color: AppColors.color001122,
  //                         fontSize: 25.sp,
  //                         fontWeight: FontWeight.w600,
  //                         fontFamily: AppFonts.quicksand),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 20.h,
  //                 ),
  //                 // _buildDropEditTextBox2("Select status",
  //                 //     true,
  //                 //     businessTextFieldController,
  //                 //     _dropDownValue2),
  //
  //                 Container(
  //                   padding: EdgeInsets.only(left: 20.w),
  //
  //                   // borderColor: AppColors.hintColor,
  //                   height: 40.h,
  //                   //width: MediaQuery.of(context).size.width - 100,
  //                   decoration: new BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(10),
  //                     border: Border.all(
  //                       color: AppColors.hintColor,
  //                       width: 1.0,
  //                     ),
  //                   ),
  //                   child: Row(
  //                     children: <Widget>[
  //                       Expanded(
  //                         child: DropdownButton(
  //                           key: _dropdownButtonKey2,
  //                           underline: SizedBox(),
  //                           iconSize: 0.0,
  //                           hint: _dropDownValue2 == null
  //                               ? Text(
  //                                   "Select status",
  //                                   style: TextStyle(
  //                                       fontFamily: AppFonts.nunitoSans,
  //                                       fontWeight: FontWeight.w400,
  //                                       color: AppColors.color3B7497,
  //                                       fontSize: 16.sp),
  //                                 )
  //                               : Text(
  //                                   _dropDownValue2,
  //                                   style: TextStyle(
  //                                       fontFamily: AppFonts.nunitoSans,
  //                                       fontWeight: FontWeight.w400,
  //                                       color: AppColors.color3B7497,
  //                                       fontSize: 16.sp),
  //                                 ),
  //                           isExpanded: true,
  //                           //iconSize: 30.0,
  //                           style: TextStyle(
  //                               fontFamily: AppFonts.nunitoSans,
  //                               fontWeight: FontWeight.w400,
  //                               color: AppColors.color3B7497,
  //                               fontSize: 16.sp),
  //                           items: statusList.map(
  //                             (val) {
  //                               return DropdownMenuItem<String>(
  //                                 value: val,
  //                                 child: Text(val),
  //                               );
  //                             },
  //                           ).toList(),
  //                           onChanged: (val) {
  //                             setState(
  //                               () {
  //                                 _dropDownValue2 = val.toString();
  //                                 status = val.toString();
  //                               },
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           openDropdown2();
  //                         },
  //                         child:
  //                       Container(
  //                         margin: EdgeInsets.only(right: 10),
  //                         child: Icon(
  //                           Icons.keyboard_arrow_down,
  //                           color: AppColors.color3B7497,
  //                         ),
  //                       ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     _requestToChangeStatusListing(
  //                         status.toLowerCase(), context);
  //
  //                     Navigator.of(context, rootNavigator: true).pop(true);
  //                   },
  //                   child: Container(
  //                     child: CommonButton(
  //                       title: "Save changes",
  //                       titleTextSize: 16.sp,
  //                       titleTextColor: AppColors.whiteColor,
  //                       backgroundColor: AppColors.color3B7497,
  //                       borderColor: AppColors.color3B7497,
  //                       height: 39.h,
  //                       width: MediaQuery.of(context).size.width,
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                       isBottomPadding: false,
  //                       context: context,
  //                     ),
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Navigator.of(context, rootNavigator: true).pop();
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.only(top: 10.h),
  //                     child: CommonButton(
  //                       title: "Cancel",
  //                       titleTextSize: 16.sp,
  //                       titleTextColor: AppColors.color001122,
  //                       backgroundColor: Colors.white,
  //                       borderColor: AppColors.hintColor,
  //                       height: 39.h,
  //                       width: MediaQuery.of(context).size.width,
  //                       borderRadius: BorderRadius.all(Radius.circular(10)),
  //                       isBottomPadding: false,
  //                       context: context,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 30.h,
  //                 )
  //               ],
  //             ),
  //           ),
  //           Positioned(
  //               right: 20,
  //               top: 20,
  //               child: InkWell(
  //                 onTap: () {
  //                   Navigator.of(context, rootNavigator: true).pop();
  //                 },
  //                 child: Container(
  //                   child: Icon(
  //                     Icons.clear,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               )),
  //         ],
  //       ),
  //     );
  //   });
  // }
  //
  // Widget _buildDropEditTextBox2(String hint, bool obscureText,
  //     TextEditingController _textController, String _dropDownValue) {
  //   return Container(
  //     padding: EdgeInsets.only(left: 20.w),
  //
  //     // borderColor: AppColors.hintColor,
  //     height: 40.h,
  //     //width: MediaQuery.of(context).size.width - 100,
  //     decoration: new BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(
  //         color: AppColors.hintColor,
  //         width: 1.0,
  //       ),
  //     ),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: DropdownButton(
  //             underline: SizedBox(),
  //             iconSize: 0.0,
  //             hint: _dropDownValue2 == null
  //                 ? Text(
  //                     hint,
  //                     style: TextStyle(
  //                         fontFamily: AppFonts.nunitoSans,
  //                         fontWeight: FontWeight.w400,
  //                         color: AppColors.color3B7497,
  //                         fontSize: 16.sp),
  //                   )
  //                 : Text(
  //                     _dropDownValue2,
  //                     style: TextStyle(
  //                         fontFamily: AppFonts.nunitoSans,
  //                         fontWeight: FontWeight.w400,
  //                         color: AppColors.color3B7497,
  //                         fontSize: 16.sp),
  //                   ),
  //             isExpanded: true,
  //             //iconSize: 30.0,
  //             style: TextStyle(
  //                 fontFamily: AppFonts.nunitoSans,
  //                 fontWeight: FontWeight.w400,
  //                 color: AppColors.color3B7497,
  //                 fontSize: 16.sp),
  //             items: statusList.map(
  //               (val) {
  //                 return DropdownMenuItem<String>(
  //                   value: val,
  //                   child: Text(val),
  //                 );
  //               },
  //             ).toList(),
  //             onChanged: (val) {
  //               setState(
  //                 () {
  //                   _dropDownValue2 = val.toString();
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         Container(
  //           margin: EdgeInsets.only(right: 10),
  //           child: Icon(
  //             Icons.keyboard_arrow_down,
  //             color: AppColors.color3B7497,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // _requestAdminListSync() async {
  //   //  _showProgressHud();
  //
  //   // Map<String, dynamic> parameters = Map<String, dynamic>();
  //   // parameters["code"] = code;
  //   // parameters["token"] = token;
  //
  //   ResponseObject responseObject = await repository.getAdminsListRequest();
  //
  //   switch (responseObject.id) {
  //     case ResponseCode.SUCCESSFUL:
  //       //_hideProgressHud();
  //
  //       AdminsResponseModel adminsResponseModel =
  //           responseObject.object as AdminsResponseModel;
  //       if (adminsResponseModel.error == 0) {
  //         Utils.adminList = adminsResponseModel.data!.users!;
  //       }
  //
  //       setState(() {});
  //
  //       break;
  //     case ResponseCode.FAILED:
  //       // _hideProgressHud();
  //       break;
  //     case ResponseCode.AUTHORIZATION_FAILED:
  //       // _hideProgressHud();
  //       break;
  //   }
  //  }
 }
