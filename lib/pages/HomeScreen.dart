import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_foodhub/pages/ProductDetailsScreen.dart';
import 'package:my_foodhub/pages/login_screen.dart';

import '../utilities/constants.dart';
import '../utilities/utils.dart';
import '../utilities/data.dart';
import '../widgets/app_header.dart';
import '../widgets/category_card.dart';
import '../widgets/header_section.dart';
import '../widgets/offers_section.dart';
import '../widgets/popular_now_card.dart';
import 'checkout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // late ProgressHUD _progressHUD;

  String seletedCategory = '';
  List<String> favorites = [];
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: _appBar(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 50),
            const AvaterHeaderWithNotifications(),
            const SizedBox(height: 35),
            //const SearchBar(),
            // offers section
            const OffersSection(),
            const SizedBox(height: 20),
            HeaderSection(
              onPressed: () {},
              title: 'Categories',
            ),

            // categories section
            SizedBox(
              height: 115,
              child: ListView.separated(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (context, index) => const SizedBox(width: 23),
                itemBuilder: (context, index) {
                  final category = categoryData[index];
                  return CategoryCard(
                    category: category.category,
                    image: category.image,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          seletedCategory = category.category;
                        } else {
                          seletedCategory = '';
                        }
                      });
                    },
                    selected:
                        seletedCategory == category.category ? true : false,
                  );
                },
              ),
            ),

            //
            HeaderSection(
              onPressed: () {},
              title: 'Popular Now',
            ),

            SizedBox(
              height: 230,
              child: ListView.separated(
                shrinkWrap: true,
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (context, index) => const SizedBox(width: 23),
                itemBuilder: (_, index) {
                  final food = popularData[index];
                  return PopularNowCard(
                    title: food.title,
                    deliveryTime: food.deliveryTime,
                    price: food.price,
                    image: food.image,
                    onPressed: () {},
                    favorite: favorites.contains(food.title),
                    onLike: (value) {
                      value && !favorites.contains(food.title)
                          ? setState(() => favorites.add(food.title))
                          : setState(() => favorites.remove(food.title));
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));

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
}
