import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_foodhub/pages/ProductDetailsScreen.dart';


import '../utilities/constants.dart';
import '../utilities/utils.dart';
import '../utilities/recommended.dart';
import 'checkout.dart';


class CategoryDetailsScreen extends StatefulWidget {
  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen>
    with TickerProviderStateMixin {


 // late ProgressHUD _progressHUD;
  bool _loading = false;
  List<int> selectedAddIndexes = <int>[];
  List<int> selectedRemoveIndexes = <int>[];
  List<int> selectedIndexes = <int>[];
  bool _showPopupMenu = false;
  int selectedCategoryIndexes = 1;

  bool showAddView = false;
  bool showRemoveView = true;

  late AnimationController _controllerRemove;
  late AnimationController _controllerAdd;
  late Animation<double> _animationRemove;
  late Animation<double> _animationAdd;

  int itemCounter = 0;

  Map? selectedCategory;
  TabController? _tabController;
  List<Widget> _tabs = [];
  List<Map> _categories = [];

  Future<List<Map>> _fetchCategoryList() async {
    List<Map> categories = <Map>[];

    //   final tempCategories = await getShopCategoryList(widget.shopId);

    // if (tempCategories != null) {
    //   categories.addAll(tempCategories);
    // }
    //print("categories : $categories");

    var newCategory = new Map();
    newCategory['id'] = 0;
    newCategory['name'] = 'All';
    newCategory['process_id'] = '5656565';

    print(newCategory);

    categories.insert(0, newCategory);

    newCategory = new Map();
    newCategory['id'] = 1;
    newCategory['name'] = 'Coffee,s';
    newCategory['process_id'] = '5656565';

    print(newCategory);

    categories.insert(1, newCategory);

    newCategory = new Map();
    newCategory['id'] = 2;
    newCategory['name'] = 'Pastries';
    newCategory['process_id'] = '5656565';

    print(newCategory);

    categories.insert(2, newCategory);
    //print("categories 2: $categories");

    if (categories.isNotEmpty) {
      int index = 0;
      for (var aCategory in categories) {
        _tabs.add(_buildMenuItemCell(aCategory, index));
        _categories.add(aCategory);
        index++;
      }
    }

    _tabController = _makeNewTabController();

    print("_categories.length :");
    print(_categories.length);

    _hideProgressHud();
    setState(() {});

    return categories;
  }

  TabController _makeNewTabController() => TabController(
    vsync: this,
    length: _tabs.length,
    initialIndex: 0,
  );

  // Sliver appbar
  bool scroll_visibility = true;
  late ScrollController scrollcontroller;
  bool isAppBarExpanded = false;

  // final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 2),
  //   vsync: this,
  // )..repeat(reverse: true);
  // final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeIn,
  // );

  @override
  void dispose() {
    _controllerRemove.dispose();
    _controllerAdd.dispose();
    super.dispose();
  }

  bool visibilityTag = false;




  @override
  void initState() {
    super.initState();

    mealQuantity= 0;

    // _progressHUD = new ProgressHUD(
    //   backgroundColor: Colors.black12,
    //   color: Colors.white,
    //   containerColor: AppColors.AppBarColor,
    //   borderRadius: 5.0,
    //   text: 'Loading...', child: null,
    // );

    _fetchCategoryList();

    // scrollcontroller.addListener(() {
    //   if (scrollcontroller.position.pixels > 0 ||
    //       scrollcontroller.position.pixels <
    //           scrollcontroller.position.maxScrollExtent)
    //     scroll_visibility = false;
    //   else
    //     scroll_visibility = true;
    //
    //   setState(() {});
    // });

    scrollcontroller = ScrollController()
      ..addListener(() => setState(() {
        print(
            'Scroll view Listener is called offset ${scrollcontroller.offset}');
      }));

    _controllerRemove = AnimationController(
      value: 0,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
      vsync: this,
    );
    _controllerAdd = AnimationController(
      value: 0,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
      vsync: this,
    );

    _animationRemove = CurvedAnimation(
      parent: _controllerRemove,
      curve: Curves.easeInOut,
    );
    _animationAdd = CurvedAnimation(
      parent: _controllerAdd,
      curve: Curves.easeInOut,
    );
    _animationRemove =
        Tween<double>(begin: 0.0, end: 0.5).animate(_controllerRemove);
    _animationAdd = Tween<double>(begin: 0.0, end: 0.5).animate(_controllerAdd);
  }

  Widget _buildTabSection() {
    return Column(children: <Widget>[
      Container(
        height: 50,
        child: (_tabs.length > 0)
            ? TabBar(
          controller: _tabController,
          indicatorColor: AppColors.AppBarColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          isScrollable: true,
          tabs: _tabs,
        )
            : Container(),
      ),
      Container(height: 1, color: AppColors.whiteColor),
    ]);
  }

  Widget _buildMenuItemCell(Map categoryInfo, int index) {
    bool isSelected = false;

    if (selectedCategory != null &&
        categoryInfo['id'] == selectedCategory!['id']) {
      setState(() {
        isSelected = true;
      });
    }
    return Tab(
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 15),
        height: 30,
        child: Center(
            child: Text(
              "${categoryInfo['name'].toString().toUpperCase()}",
              style: TextStyle(
                  color: isSelected
                      ? AppColors.AppBarColor
                      : AppColors.AppTextColorGrey2,
                  fontFamily: "Josefin Sans",
                  fontSize: 16),
            )),
      ),
    );
  }

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

  bool get _changecolor {
    return scrollcontroller.hasClients &&
        scrollcontroller.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child:    _appBar(),
      ),


      body: Stack(children: <Widget>[
        Container(
            color: AppColors.appBackGroundColor,
            child: CustomScrollView(
              //  controller: scrollcontroller,
                slivers: <Widget>[
                  // SliverPersistentHeader(
                  //   delegate: MySliverAppBar(expandedHeight: 200),
                  //   pinned: true,
                  // ),
                  // SliverPersistentHeader(
                  //   delegate: Delegate(
                  //       selectedCategoryIndexes: selectedCategoryIndexes,
                  //       didCategoryChange: (id) {
                  //         selectedCategoryIndexes = id;
                  //         setState(() {});
                  //       }, selected: 0),
                  //   pinned: true,
                  // ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        // margin: EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            _buildRecomendedList(),
                          ],
                        ),
                      )
                    ]),
                  ),
                ])),
        Visibility(
          visible: _loading,
          child: Container(),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: Visibility(
            visible: _showPopupMenu,
            child: _buildPopupMenu(),
          ),
        ),
      ]),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CheckOut()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //padding: EdgeInsets.all(10),

          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(width: 1, color: AppColors.textColorGrey),
            color: AppColors.AppBarColor,
          ),
          width: 100,
          height: 60,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child:      const Icon(
          Icons.shopping_basket,
          color: AppColors.whiteColor,
        ),

                  // Text(
                  //   'Checkout ^',
                  //   style: TextStyle(
                  //       fontSize: 14,
                  //       color: AppColors.whiteColor,
                  //       fontFamily: AppFonts.comfortaaRegular,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: Text(
                    '4.99',
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontFamily: AppFonts.comfortaaRegular,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
        ),
      ),
    );
  }


  Widget _buildPopupMenu() {
    return Container(
        height: 195,
        width: 200,
        color: AppColors.AppBarColor,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _showPopupMenu = !_showPopupMenu;
                  setState(() {});
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => AccountScreen()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Account',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.BgWhite,
                                fontFamily: AppFonts.comfortaaRegular,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/images/icon-account.png"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 1,
                  color: AppColors.BgWhite),
              InkWell(
                onTap: () {
                  _showPopupMenu = !_showPopupMenu;
                  setState(() {});
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => OrdersScreen()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Orders',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.BgWhite,
                                fontFamily: AppFonts.comfortaaRegular,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/images/icon-orders.png"),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 1,
                  color: AppColors.BgWhite),
              InkWell(
                onTap: () {
                  _showPopupMenu = !_showPopupMenu;
                  setState(() {});
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SupportScreen()));
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Text(
                            'Support',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.BgWhite,
                                fontFamily: AppFonts.comfortaaRegular,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(5),
                        child: Image.asset("assets/images/icon-support.png"),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }

  Widget _buildSearchBox() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      height: 45,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: AppColors.textColorGrey, width: 1)),
      child: Row(children: <Widget>[
        Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            height: 20,
            width: 20,
            child: Image.asset("assets/images/icon-searchPurple.png")),
        SizedBox(width: 10),
        Expanded(
            child: Center(
              child: TextFormField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Search For Item",
                      border: InputBorder.none,
                      isDense: true)),
            ))
      ]),
    );
  }



  Widget _buildListItem2(Map data, int index) {
    int eventId = data['id'];
    bool showOverlay = (selectedIndexes.contains(eventId)) ? true : false;
    double value = 0.0;
    bool showAddAnimation =
    (selectedAddIndexes.contains(data['id'])) ? true : false;
    bool showRemoveAnimation =
    (selectedRemoveIndexes.contains(data['id'])) ? true : false;

    return InkWell(
      onTap: () {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => GroceryProductListScreen()));

        _createQuickViewDialog();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
        // );
      },
      child: GestureDetector(

        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //padding: EdgeInsets.all(10),

          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            // border: Border.all(width: 1, color: AppColors.textColorGrey),
            color: Colors.white,
          ),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    //alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    decoration: new BoxDecoration(
                      // border: Border.all(
                      //     width: 1, color: AppColors.textColorGrey),
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.asset(
                        data['imageLink'],
                        fit: BoxFit.cover,
                      ),

                      // CachedNetworkImage(
                      //   fit: BoxFit.fitWidth,
                      //   imageUrl: "${globals.image_base_url}${data['image']}",
                      //   placeholder: (context, url) => Container(
                      //       padding: EdgeInsets.all(5),
                      //       child: Center(child: CupertinoActivityIndicator())),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                    ),
                  ),
                ]),
                // SizedBox(height: 10),
                // Text(
                //   data['description'],
                //   style: TextStyle(
                //       fontSize: 16,
                //       color: AppColors.AppTextColorGrey2,
                //       fontFamily: "Poppins"),
                // )
              ],
            ),




            Positioned(
              left: 10,
              top: 10,
              child: Container(
                // width: 100,

                  height: 31,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        data['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.AppTextColorGrey2,
                            fontFamily: AppFonts.comfortaaRegular),
                      ),
                    ),
                  )),
            ),

            Positioned(
              right: 10,
              top: 10,
              child: Container(
                  width: 70,
                  height: 31,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "4.5",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.AppTextColorGrey2,
                          fontFamily: AppFonts.comfortaaRegular),
                    ),
                  )),
            ),

            data['isAvailable']
                ? Positioned(
              left: 10,
              bottom: 10,
              child: itemCounter > 0
                  ? Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "$itemCounter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.AppTextColorGrey2,
                          fontFamily: AppFonts.comfortaaRegular),
                    ),
                  ))
                  : Container(),
            )
                : Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                  height: 31,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.red,
                        width: 1.0,
                        style: BorderStyle.solid),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Currently Unavalible",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontFamily: AppFonts.comfortaaRegular),
                      ),
                    ),
                  )),
            ),


          ]),
        ),
      ),
    );
  }


  Widget _buildListItem(Map data, int index) {
    int eventId = data['id'];
    bool showOverlay = (selectedIndexes.contains(eventId)) ? true : false;
    double value = 0.0;
    bool showAddAnimation =
    (selectedAddIndexes.contains(data['id'])) ? true : false;
    bool showRemoveAnimation =
    (selectedRemoveIndexes.contains(data['id'])) ? true : false;

    return InkWell(
      onTap: () {
//        Navigator.push(context,
//            MaterialPageRoute(builder: (context) => GroceryProductListScreen()));

        _createQuickViewDialog();

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
        // );
      },
      child:

      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: constraints.maxWidth,
            decoration:  BoxDecoration(
              color: AppColors.appBackground,
              borderRadius:BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------ IMAGE with DISCOUNT(if needed) ---------------------//
                Container(
                  //alignment: Alignment.center,
                  width: double.infinity,
                  height: 150,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      data['imageLink'],
                      fit: BoxFit.cover,
                    ),

                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 7.h,
                          left: 6.w,
                          right: 6.w,
                        ),
                        child: Text(
                          data['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.AppTextColorGrey2,
                              fontFamily: AppFonts.comfortaaRegular),
                        ),


                      ),
                      //------------------ MEAL PRICE ---------------------//
                    Padding(
                        padding: EdgeInsets.only(
                          left: 6.w,
                          right: 6.w,
                          top: 5.h,
                        ),
                        child: Text(
                          '\$ 100 ',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.AppTextColorGrey2,
                              fontFamily: AppFonts.comfortaaRegular),
                        ),
                      ),
                      const Spacer(),
                     // ------------------ BUTTONS ---------------------//
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 6.h),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child:

                          //------------------ If Meal ADDED ---------------------//
                         mealQuantity > 0
                              ?
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: AppColors.kcFontColor,
                                borderRadius: BorderRadius.circular(15),
                                elevation: 3,
                                shadowColor: AppColors.kcSecondaryDarkColor
                                    .withOpacity(0.3),
                                child: InkWell(
                                  borderRadius:BorderRadius.circular(15),
                                  onTap: () async {
                                    /// SUBTRACTS quantity of a meal or REMOVES a meal from CART
                                    // await viewModel
                                    //     .subtractOrRemoveMealInCart();
                                    // await tweenController.forward();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    child: Icon(
                                      Icons.remove,
                                      size:  12.w,

                                      color: AppColors.kcSecondaryDarkColor,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                              mealQuantity.toString(),
                               style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.AppTextColorGrey2,
                                    fontFamily: AppFonts.comfortaaRegular
                              ),
                              ),
                              Material(
                                color: AppColors.kcFontColor,
                                borderRadius: BorderRadius.circular(15),
                                elevation: 3,
                                shadowColor: AppColors.kcSecondaryDarkColor
                                    .withOpacity(0.3),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () async {
                                    /// INCREASES meal's quantity in CART
                                    // await viewModel
                                    //     .addOrIncreaseMealInCart();
                                    // await tweenController.forward();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size:  12.w,

                                      color: AppColors.kcSecondaryDarkColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                          //------------------ If Meal NOT ADDED ---------------------//
                              : Material(
                            color: AppColors.kcFontColor,
                            borderRadius: BorderRadius.circular(15),
                            elevation: 3,
                            shadowColor: AppColors.kcSecondaryDarkColor
                                .withOpacity(0.3),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () async {
                                /// ADDS a meal to CART
                                 mealQuantity = 1;
                                 setState(() {

                                 });
                                // await viewModel
                                //     .addOrIncreaseMealInCart();
                                // await tweenController.forward();
                              },
                              child: Ink(
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                  color: AppColors.kcFontColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                ),
                                child: Text(
                                  '\$ 100',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.AppTextColorGrey2,
                                      fontFamily: AppFonts.comfortaaRegular
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRecomendedList() {
//    final double itemWidth = 200;
//    final double itemHeight = 250;

    return Container(
      //color: Colors.red,
      // width: double.infinity,
      //  height: double.infinity,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: FutureBuilder(
          future: selectedCategoryIndexes == 1
              ? _fetchDemoData()
              : _fetchDemoData2(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "No data!",
                  style: TextStyle(
                      fontFamily: AppFonts.regularFontFamilyName,
                      fontSize: 25.0,
                      color: AppColors.AppBarColor,
                      fontWeight: FontWeight.normal),
                ),
              );
            } else {
              return Container(
                  child:
                  // Expanded(
                  //   child:
                    GridView.builder(
                      padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 10.h),
                      physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        controller: scrollcontroller,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h, //spaceTopBottom
                        crossAxisSpacing: 12.w, //spaceLeftRight
                        childAspectRatio: Utils().getDeviceType() == phone
                            ? 1 / 1.675
                            : 1 / 1.5,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                  return _buildListItem(snapshot.data[index], index);
                }
                    ),
              //    ),


                  // ListView.builder(
                  //     physics: ScrollPhysics(),
                  //     shrinkWrap: true,
                  //     controller: scrollcontroller,
                  //     itemCount: snapshot.data.length,
                  //     scrollDirection: Axis.vertical,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return _buildListItem(snapshot.data[index], index);
                  //     })

              );
            }
          }),
    );
  }


  void _createQuickViewDialog() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          var size = MediaQuery.of(context).size;
          return Container(
              height: 550.h,
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  //Text("data"),
                  Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: <Widget>[
                          // main image content
                          SizedBox(
                            height: 150.h,
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
                            height: 200.h,
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
                                        fontSize: 24.sp,
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
                                        fontSize: 26.sp,
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
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50.h,
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
                                                      fontSize: 22.sp,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  '1',
                                                  style: GoogleFonts.averiaSerifLibre(
                                                      fontSize: 22.sp,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  '+',
                                                  style: GoogleFonts.averiaSerifLibre(
                                                      fontSize: 22.sp,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.03),
                                        Container(
                                          height: 50.h,
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
                                                    fontSize: 18.sp,
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
                      )),
                  SizedBox(height: 5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontFamily: AppFonts.regularFontFamilyName),
                          ))),
                  SizedBox(
                    height: 5,
                  )
                ],
              ));
        });
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
      elevation: 0.0,
      title: Text(
        "Foodhub",
        style: TextStyle(
            color: AppColors.AppBarColor,
            fontSize: 17,
            fontFamily: AppFonts.comfortaaRegular,
            fontWeight: FontWeight.bold),
      ),
     // leading:

      // InkWell(
      //   onTap: () {
      //     //  Navigator.of(context).pop();
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (context) => SignUpScreen()));
      //   },
      //   child: Container(
      //     width: 45,
      //     height: 45,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(25),
      //     ),
      //     child: Image.asset("assets/images/ic_qr.png"),
      //   ),
      // ),
      actions: [
        GestureDetector(
          onTap: () {
            //  Navigator.of(context).pop();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => SignUpScreen()));

            //  if (value.length > 0) {
            _showPopupMenu = !_showPopupMenu;
            //  } else {
            //     _showPopupMenu = false;
            //   }
            setState(() {});
          },
          child: Container(
            margin: EdgeInsets.all(8),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              // image: DecorationImage(
              //     image: AssetImage("assets/images/icon-avatar.png"))
            ),
            child: Image.asset("assets/images/icon-avatar.png"),
          ),
        )

//         PopupMenuButton(
//           // icon: Icon(Icons.more_vert),
//
//           child: Container(
//             margin: EdgeInsets.all(8),
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               // image: DecorationImage(
//               //     image: AssetImage("assets/images/icon-avatar.png"))
//             ),
//             child: Image.asset("assets/images/icon-avatar.png"),
//           ),
//           onSelected: (value) {
//             //  filterList = value;
// //              Fluttertoast.showToast(
// //                  msg: "You have selected " + value.toString(),
// //                  toastLength: Toast.LENGTH_SHORT,
// //                  gravity: ToastGravity.BOTTOM,
// //                  backgroundColor: Colors.black,
// //                  textColor: Colors.white,
// //                  fontSize: 16.0
// //              );
//             setState(() {});
//           },
//           itemBuilder: (context) => [
//             PopupMenuItem(
//               value: 0,
//               child: Text("All"),
//             ),
//             PopupMenuItem(
//               value: 1,
//               child: Text("Showroom"),
//             ),
//             PopupMenuItem(
//               value: 2,
//               child: Text("Service cCenter"),
//             ),
//           ],
//         ),
      ],
    );
  }

  Widget _favouriteLayout() {
    return Container(
      height: 60,
      color: AppColors.whiteColor,
      padding: EdgeInsets.only(top: 5, bottom: 5.0, left: 5, right: 5),
      width: double.infinity,
      child: FutureBuilder(
          future: _fetchSearchItemListData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              return (snapshot.data.length > 0)
                  ? Container(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return _favouriteItem(
                        snapshot.data[index],
                      );
                    },
                  ))
                  : Container();
            }
          }),
    );
  }

  Widget _favouriteItem(Map data) {
    int categoryId = data['id'];
    bool showUnderline = (selectedCategoryIndexes == categoryId) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          selectedCategoryIndexes = categoryId;
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25,
              child: Text(
                data['category_name'],
                style: TextStyle(
                    color: showUnderline
                        ? AppColors.AppBarColor
                        : AppColors.blackTextColor,
                    fontSize: 17,
                    fontFamily: AppFonts.comfortaaRegular,
                    fontWeight: FontWeight.bold),
              ),
            ),
            showUnderline
                ? Container(width: 80, height: 2, color: AppColors.AppBarColor)
                : Container(width: 80, height: 2, color: AppColors.BgWhite),
          ],
        ),
      ),
    );
  }

  Future<List<Map>> _fetchSearchItemListData() async {
    List<Map> dataList = <Map>[];

    Map item = new Map();
    item['id'] = 1;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Coffey";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 2;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "pastry";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 3;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Favourite";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 4;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Cake";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 5;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Pasta";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 6;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Kabab";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 7;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Cake";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    return dataList;
  }

  // Demo Data
  Future<List<Map>> _fetchDemoData() async {
    List<Map> dataList = <Map>[];

    var newCategory = new Map();
    newCategory['id'] = 1;
    newCategory['name'] = "Sparklin Splash";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Office';
    newCategory['imageLink'] = "assets/images/coffee2.png";

    print(newCategory);

    dataList.insert(0, newCategory);
    newCategory = new Map();
    newCategory['id'] = 2;
    newCategory['name'] = "Creepy Coffee";
    newCategory['isAvailable'] = false;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/image-orderItem.png";

    print(newCategory);

    dataList.insert(1, newCategory);

    newCategory = new Map();
    newCategory['id'] = 3;
    newCategory['name'] = "Matcha Latte";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/coffee2.png";

    print(newCategory);

    dataList.insert(2, newCategory);

    newCategory = new Map();
    newCategory['id'] = 4;
    newCategory['name'] = "Chai Latte";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/image-orderItem.png";

    print(newCategory);

    dataList.insert(3, newCategory);

    Utils().showLog(">>> dataList : $dataList");
    return dataList;
  }

  // Demo Data
  Future<List<Map>> _fetchDemoData2() async {
    List<Map> dataList = <Map>[];

    var newCategory = new Map();
    newCategory['id'] = 1;
    newCategory['name'] = "Sparklin Splash";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Office';
    newCategory['imageLink'] = "assets/images/pastrey.png";

    print(newCategory);

    dataList.insert(0, newCategory);
    newCategory = new Map();
    newCategory['id'] = 2;
    newCategory['name'] = "Sparklin Splash";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/eclair.png";

    print(newCategory);

    dataList.insert(1, newCategory);

    newCategory = new Map();
    newCategory['id'] = 3;
    newCategory['name'] = "Sparklin Splash";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/pastrey.png";

    print(newCategory);

    dataList.insert(2, newCategory);

    newCategory = new Map();
    newCategory['id'] = 4;
    newCategory['name'] = "Sparklin Splash";
    newCategory['isAvailable'] = true;
    newCategory['description'] = 'Home';
    newCategory['imageLink'] = "assets/images/eclair.png";

    print(newCategory);

    dataList.insert(3, newCategory);

    Utils().showLog(">>> dataList : $dataList");
    return dataList;
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Function(int id) didCategoryChange;
  final int selected;
  final int selectedCategoryIndexes;

  Delegate(
      {required this.didCategoryChange,
        required this.selected,
        required this.selectedCategoryIndexes});

  // int selectedCategoryIndexes = initial;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
          return Container(
padding:  const EdgeInsets.all(0),
            // margin: EdgeInsets.all(24),
            color: AppColors.whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _categoryTabLayout(mystate),
               // SizedBox(height: 15),
                // Text(
                //   'Swipe right to add, left to remove',
                //   style: TextStyle(
                //       color: AppColors.textColorDarkGrey,
                //       fontSize: 16,
                //       fontFamily: AppFonts.comfortaaRegular),
                // ),
              ],
            ),
          );
        });
  }

  Widget _categoryTabLayout(StateSetter mystate) {
    return Container(
      height: 70,
      color: AppColors.whiteColor,
      // padding: EdgeInsets.only(top: 5, bottom: 5.0, left: 5, right: 5),
      width: double.infinity,
      child: FutureBuilder(
          future: _fetchCategoryItemListData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              return (snapshot.data.length > 0)
                  ? Container(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return _categoryItem(snapshot.data[index], mystate);
                    },
                  ))
                  : Container();
            }
          }),
    );
  }

  Widget _categoryItem(Map data, StateSetter mystate) {
    int categoryId = data['id'];
    bool showUnderline = (selectedCategoryIndexes == categoryId) ? true : false;
    return InkWell(
      onTap: () {
        mystate(() {
          didCategoryChange(categoryId);
          // selectedCategoryIndexes = categoryId;
        });
      },
      child: Container(
        //margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: 25,
              child: Text(
                data['category_name'],
                style: TextStyle(
                    color: showUnderline
                        ? AppColors.AppBarColor
                        : AppColors.blackTextColor,
                    fontSize: 16,
                    //fontFamily: AppFonts.comfortaaRegular,
                    fontWeight: FontWeight.bold),
              ),
            ),
            showUnderline
                ? Container(
                margin: EdgeInsets.all(5),
                width: 90,
                height: 2,
                color: AppColors.AppBarColor)
                : Container(
                margin: EdgeInsets.all(5),
                width: 90,
                height: 2,
                color: AppColors.BgWhite),
          ],
        ),
      ),
    );
  }

  Future<List<Map>> _fetchCategoryItemListData() async {
    List<Map> dataList = <Map>[];

    Map item = new Map();
    item['id'] = 1;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Coffee";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 2;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Pastry";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 3;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Favourite";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 4;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Cake";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 5;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Pasta";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 6;
    item['imageLink'] = "assets/images/fab1.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Kabab";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    item = new Map();
    item['id'] = 7;
    item['imageLink'] = "assets/images/fab2.png";
    item['cardNo'] = "    7 7 7 0";
    item['category_name'] = "Cake";
    item['distance'] = "0.2 mi";

    dataList.add(item);

    return dataList;
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none, fit: StackFit.expand,
      children: [
        // Image.network(
        //   "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
        //   fit: BoxFit.cover,
        // ),

        Image.asset(
          "assets/images/res1.png",
          fit: BoxFit.cover,
        ),

        // Positioned(
        //   left: 10,
        //   bottom: 10,
        //   child: Opacity(
        //     opacity: (1 - shrinkOffset / expandedHeight),
        //     child: Container(
        //       width: 34,
        //       height: 34,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(25),
        //         border: Border.all(
        //             color: Colors.white, width: 2.0, style: BorderStyle.solid),
        //         color: Colors.green,
        //       ),
        //       // child: Image.asset("assets/images/ic_qr.png"),
        //     ),
        //   ),
        // ),

        // Positioned(
        //   right: 10,
        //   bottom: 10,
        //   child: Opacity(
        //     opacity: (1 - shrinkOffset / expandedHeight),
        //     child: Container(
        //       width: 34,
        //       height: 34,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(25),
        //         border: Border.all(
        //             color: Colors.white, width: 1.0, style: BorderStyle.solid),
        //         color: Colors.white,
        //       ),
        //       child: Image.asset("assets/images/ic-favorites.png"),
        //     ),
        //   ),
        // ),

        // Positioned(
        //   left: 5,
        //   top: 8,
        //   child: Opacity(
        //     opacity: (shrinkOffset / expandedHeight),
        //     child: Container(
        //       margin: EdgeInsets.only(left: 10),
        //       width: 58,
        //       height: 58,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(30),
        //         border: Border.all(
        //             color: Colors.white, width: 1.0, style: BorderStyle.solid),
        //         color: Colors.white,
        //       ),
        //       child: Image.asset("assets/images/fab2.png"),
        //     ),
        //   ),
        // ),
        //
        // Positioned(
        //     right: 5,
        //     top: 5,
        //     child: Opacity(
        //       opacity: (shrinkOffset / expandedHeight),
        //       child: Column(
        //         children: [
        //           Container(
        //             width: 27,
        //             height: 27,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(25),
        //               border: Border.all(
        //                   color: Colors.white,
        //                   width: 1.5,
        //                   style: BorderStyle.solid),
        //               color: Colors.green,
        //             ),
        //             // child: Image.asset("assets/images/ic_qr.png"),
        //           ),
        //           SizedBox(
        //             height: 5,
        //           ),
        //           Container(
        //             width: 27,
        //             height: 27,
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(25),
        //               border: Border.all(
        //                   color: Colors.white,
        //                   width: 1.0,
        //                   style: BorderStyle.solid),
        //               color: Colors.white,
        //             ),
        //             child: Image.asset("assets/images/ic-favorites.png"),
        //           ),
        //         ],
        //       ),
        //     )),

        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 1,
            child: Container(
              height: 51,
              margin: EdgeInsets.only(bottom: 10, top: 10),
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.white, width: 1.0, style: BorderStyle.solid),
                color: Colors.white,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "The Grind",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      "770 Eastern Parkway",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              margin: EdgeInsets.only(bottom: 35),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  "assets/images/fab1-big.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 75;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

// class TransitionAppBar extends StatelessWidget {
//   final Widget avatar;
//   final Widget title;
//   final double extent;
//
//   TransitionAppBar({required this.avatar, required this.title, this.extent = 50, required Key key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverPersistentHeader(
//       pinned: true,
//       delegate: _TransitionAppBarDelegate(
//           avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
//     );
//   }
// }
//
// class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final _avatarMarginTween = EdgeInsetsTween(
//       begin: EdgeInsets.only(bottom: 70, left: 30),
//       end: EdgeInsets.only(left: 0.0, top: 30.0));
//   final _avatarAlignTween =
//   AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);
//
//   final Widget avatar;
//   final Widget title;
//   final double extent;
//
//   _TransitionAppBarDelegate({required this.avatar, required this.title, this.extent = 250})
//       : assert(avatar != null),
//         assert(extent == null || extent >= 200),
//         assert(title != null);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     double tempVal = 34 * maxExtent / 100;
//     final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
//     print("Objechjkf === ${progress} ${shrinkOffset}");
//     final avatarMargin = _avatarMarginTween.lerp(progress);
//     final avatarAlign = _avatarAlignTween.lerp(progress);
//
//     return Stack(
//       children: <Widget>[
//         AnimatedContainer(
//           duration: Duration(milliseconds: 100),
//           height: shrinkOffset * 2,
//           constraints: BoxConstraints(maxHeight: minExtent),
//           color: Colors.redAccent,
//         ),
//         Padding(
//           padding: avatarMargin,
//           child: Align(alignment: avatarAlign, child: avatar),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: title,
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   double get maxExtent => extent;
//
//   @override
//   double get minExtent => (maxExtent * 68) / 100;
//
//   @override
//   bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
//     return avatar != oldDelegate.avatar || title != oldDelegate.title;
//   }
// }
