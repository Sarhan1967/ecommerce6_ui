import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/view/category_details.dart';
import 'package:e_commerce/view/profile/notifications_view.dart';
import 'package:e_commerce/view/profile_screen.dart';
import 'package:e_commerce/view/search_screen.dart';
import 'package:e_commerce/view/user_orders_screen.dart';
import 'package:e_commerce/view/widgets/custom_product_viewer.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/icon_container.dart';
import 'package:e_commerce/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';
import '../controllers/cart_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/profile_controller.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    return GetBuilder<HomeController>(
      init: Get.put(HomeController()),
      builder: (mainController) => Scaffold(
        drawer: _drawer(),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search,size: 30,),
              color:Colors.red,

              onPressed: () {
                Get.to(()=>SearchScreen());
              },
            ),
            InkWell(
              onTap: () {
                Get.to(() => FavoritesScreen());
                //Get.to(() => FavouriteView());
              },
              child: Stack(
                children: [
                  GetBuilder<FavoritesController>(
                    init: Get.put(FavoritesController()),
                    builder: (controller) => Align(
                      child: Text(
                          controller.allFavoriteProducts.length > 0
                              ? controller.allFavoriteProducts.length
                              .toString()
                              : '0'),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(Icons.favorite_border_outlined,color:Colors.red,size: 30,),
                      //alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => CartScreen());
              },
              child: Stack(
                children: [
                  GetBuilder<CartController>(
                    init: Get.put(CartController()),
                    builder: (controller) => Align(
                      child: Text(controller.cartProductModel.length > 0
                          ? controller.cartProductModel.length.toString()
                          : '0'),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Align(
                    //-----------------shopping_cart----------
                    child: Icon(Icons.shopping_cart_outlined,color:Colors.red,size: 30,),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: mainController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: 10, right: 13.0, bottom: 5.0, left: 13.0),
                  child: Column(
                    children: [
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: CustomText(
                      //         text: 'Brand City',
                      //         size: 35.0,
                      //         fontColor: Colors.blueAccent,
                      //         fontFamily: 'Pacifico',
                      //       ),
                      //     ),
                      //     IconContainer(
                      //       icon: Icons.notifications_none_outlined,
                      //       onIconPressed: () {
                      //         Get.to(()=>NotificationsView());
                      //       },
                      //     ),
                      //     IconContainer(
                      //       icon: Icons.search,
                      //       onIconPressed: () {
                      //         Get.to(()=>SearchScreen());
                      //       },
                      //     ),
                      //
                      //     // Expanded(
                      //     //   child: Form(
                      //     //     key: searchController.searchFormKey,
                      //     //     child: Container(
                      //     //       decoration: BoxDecoration(
                      //     //         borderRadius: BorderRadius.circular(30.0),
                      //     //         color: Colors.grey.shade200,
                      //     //         border: Border.all(
                      //     //           color: Colors.grey.shade400,
                      //     //         ),
                      //     //       ),
                      //     //       child: Padding(
                      //     //         padding: EdgeInsets.symmetric(
                      //     //             horizontal: 10.0),
                      //     //         child: TypeAheadFormField(
                      //     //           textFieldConfiguration:
                      //     //               TextFieldConfiguration(
                      //     //             controller: searchController
                      //     //                 .typedValueController,
                      //     //             onChanged: (value) {
                      //     //               //_searchFormKey.currentState.save();
                      //     //             },
                      //     //             decoration: InputDecoration(
                      //     //               contentPadding: EdgeInsets.only(
                      //     //                   left: 8.0, top: 13),
                      //     //               border: InputBorder.none,
                      //     //               suffixIcon: IconButton(
                      //     //                 icon: Icon(
                      //     //                   Icons.close,
                      //     //                   color: Colors.grey,
                      //     //                 ),
                      //     //                 onPressed: () {
                      //     //                   searchController
                      //     //                       .typedValueController
                      //     //                       .clear();
                      //     //                 },
                      //     //               ),
                      //     //               hintText: 'Search',
                      //     //             ),
                      //     //           ),
                      //     //           suggestionsCallback: (pattern) {
                      //     //             return searchController
                      //     //                 .getSearchSuggestions(pattern);
                      //     //           },
                      //     //           getImmediateSuggestions: true,
                      //     //           hideOnEmpty: true,
                      //     //           hideOnLoading: true,
                      //     //           hideSuggestionsOnKeyboardHide: true,
                      //     //           // noItemsFoundBuilder: (context) {
                      //     //           //   return Padding(
                      //     //           //     padding: const EdgeInsets.all(8.0),
                      //     //           //     child: Text('No Recommendations'),
                      //     //           //   );
                      //     //           // },
                      //     //           itemBuilder: (context, suggestion) {
                      //     //             return ListTile(
                      //     //               title: SubstringHighlight(
                      //     //                 text: suggestion,
                      //     //                 term: searchController
                      //     //                     .typedValueController.text,
                      //     //                 textStyleHighlight: TextStyle(
                      //     //                   color: Colors.black,
                      //     //                   fontWeight: FontWeight.w800,
                      //     //                 ),
                      //     //               ),
                      //     //             );
                      //     //           },
                      //     //           transitionBuilder: (context,
                      //     //               suggestionsBox, controller) {
                      //     //             return suggestionsBox;
                      //     //           },
                      //     //           onSuggestionSelected: (suggestion) {
                      //     //             searchController.typedValueController
                      //     //                 .text = suggestion;
                      //     //           },
                      //     //           onSaved: (value) {
                      //     //             searchController.searchText = value;
                      //     //           },
                      //     //         ),
                      //     //       ),
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //   ],
                      // ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30.0),
                      //       color: Colors.grey.shade200),
                      //   child: GetBuilder<SearchController>(
                      //     init: SearchController(),
                      //     builder: (searchController) => Form(
                      //       key: _searchFormKey,
                      //       child: TypeAheadFormField(
                      //         textFieldConfiguration: TextFieldConfiguration(
                      //           controller:
                      //               searchController.typedValueController,
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             prefixIcon: GestureDetector(
                      //               onTap: () {
                      //                 _searchFormKey.currentState.save();
                      //                 searchController.onSearchPressed();
                      //               },
                      //               child: Icon(
                      //                 Icons.search,
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //             hintText: 'Search',
                      //           ),
                      //         ),
                      //         suggestionsCallback: (pattern) {
                      //           return searchController
                      //               .getSearchSuggestions(pattern);
                      //         },
                      //         getImmediateSuggestions: true,
                      //         hideOnEmpty: true,
                      //         hideOnLoading: true,
                      //         hideSuggestionsOnKeyboardHide: true,
                      //         noItemsFoundBuilder: (context) {
                      //          return Padding(
                      //          padding: const EdgeInsets.all(8.0),
                      //          child: Text('No Recommendations'),
                      //          );
                      //           },
                      //         itemBuilder: (context, suggestion) {
                      //           return ListTile(
                      //             title: SubstringHighlight(
                      //               text: suggestion,
                      //               term: searchController
                      //                   .typedValueController.text,
                      //               textStyleHighlight: TextStyle(
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.w800),
                      //             ),
                      //           );
                      //         },
                      //         transitionBuilder:
                      //             (context, suggestionsBox, controller) {
                      //           return suggestionsBox;
                      //         },
                      //         onSuggestionSelected: (suggestion) {
                      //           searchController.typedValueController.text =
                      //               suggestion;
                      //         },
                      //         onSaved: (value) {
                      //           searchController.searchText = value;
                      //         },
                      //       ),
                      //       // child: TextFormField(
                      //       //    decoration: InputDecoration(
                      //       //      border: InputBorder.none,
                      //       //      prefixIcon: IconButton(
                      //       //        icon: Icon(Icons.search,),
                      //       //        onPressed: (){
                      //       //         searchController.onSearchPressed();
                      //       //        },
                      //       //        color: Colors.black,
                      //       //      ),
                      //       //    ),
                      //       //   onSaved: (value){
                      //       //      searchController.searchText = value;
                      //       //   },
                      //       //   // validator: (value){
                      //       //   //   if(value == ''){
                      //       //   //     return '';
                      //       //   //   }
                      //       //   //   return null;
                      //       //   // },
                      //       //  ),
                      //     ),
                      //   ),
                      // ),
                      _carousel(),

                      SizedBox(
                        height: 20.0,
                      ),
                      CustomText(
                        text: 'Categories',
                        alignment: Alignment.bottomLeft,
                        size: 20.0,
                        weight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GetBuilder<HomeController>(
                          init: Get.find(),
                          builder: (controller) {
                            return Container(
                              height: 120.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(CategoryDetails(
                                            categoryName: controller
                                                .categories[index].name!,
                                          ));
                                        },
                                        child: Container(
                                          height: 60.0,
                                          width: 60.0,
                                          child: Image.network(
                                            controller.categories[index].image!,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                offset: Offset(4, 8),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      CustomText(
                                        text: controller.categories[index].name!,
                                        size: 17.0,
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 20.0,
                                  );
                                },
                                itemCount: controller.categories.length,
                              ),
                            );
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Best Selling',
                            size: 20.0,
                            weight: FontWeight.bold,
                          ),
                          CustomText(
                            text: 'See all',
                            size: 18.0,
                            fontColor: kPrimaryColor,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GetBuilder<HomeController>(builder: (productController) {
                        return Container(
                          height: 350.0,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CustomProductViewer(
                                determinedProduct:
                                    productController.ourAllProducts[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 15.0,
                              );
                            },
                            itemCount: productController.ourAllProducts.length,
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _carousel() {
    return Container(
      height: 120,
      color: Colors.white,
      child: Carousel(
        boxFit: BoxFit.cover,
        // images: const [
        //   AssetImage('assets/images/img1.jpg'),
        //   AssetImage('assets/images/img2.jpg'),
        //   AssetImage('assets/images/img3.jpg'),
        //   AssetImage('assets/images/img4.jpg'),
        // ],
        images: [
          Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce6ui.appspot.com/o/img1.jpg?alt=media&token=c2112bb2-f743-4bdc-a7ee-8959aa4afea6'),
          Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce6ui.appspot.com/o/img2.jpg?alt=media&token=43f772ec-2560-41da-82d8-81ba86911e22'),
          Image.network("https://firebasestorage.googleapis.com/v0/b/ecommerce6ui.appspot.com/o/img3.jpg?alt=media&token=a846333e-0a65-4130-8454-6c2a973342a1"),
          Image.network('https://firebasestorage.googleapis.com/v0/b/ecommerce6ui.appspot.com/o/img4.jpg?alt=media&token=a23c5d82-0da6-4a95-bb0a-6128eaaf44f6'),
        ],

        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 800),
        dotSize: 4.0,
        indicatorBgPadding: 5,
        dotColor: Colors.white,
        dotBgColor: Colors.transparent,
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(width: 100.0),
           Container(
             padding: EdgeInsets.only(top: 50),
             child: GetBuilder<ProfileController>(
                init: Get.put(ProfileController()),
                 builder: (PrfController) => Row(
                    children: [
                      CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: PrfController.currentUser?.pic == null
                                ? Image.asset(
                              'assets/images/default.png',
                            )
                                : Image.network(PrfController.currentUser!.pic!),
                          ),
                        ),
                        radius: 50.0,
                        backgroundColor: kPrimaryColor.withOpacity(0.6),
                      ),

                      // Container(
                      //  padding: EdgeInsets.all(10.0),
                      //   height: 100.0,
                      //   width: 100.0,
                      //   decoration: BoxDecoration(
                      //     color: Colors.red,
                      //     borderRadius: BorderRadius.circular(50.0),
                      //     image: DecorationImage(
                      //       fit: BoxFit.fill,
                      //       image: controller.userData.pic == null
                      //           ? AssetImage(
                      //                'assets/images/default.png',
                      //             )
                      //           : NetworkImage(controller.userData.pic),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: PrfController.currentUser!.name!,
                            size: 30.0,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          CustomText(
                            text: PrfController.currentUser!.email!,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
           ),


              // UserAccountsDrawerHeader(
              //   accountName: Text('Usama elgindy'),
              //   accountEmail: Text(
              //     'usamaelgindy2@gmail.com',
              //     style: TextStyle(color: Colors.grey.shade900),
              //   ),
              //   currentAccountPicture: GestureDetector(
              //     child: const CircleAvatar(
              //       backgroundColor: Colors.grey,
              //       child: Icon(
              //         Icons.person,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              //   decoration: const BoxDecoration(color: Colors.red),
              // ),

              // Container(
              //   //height: MediaQuery.of(context).size.height / 9.3,
              //   height: 20,
              //   child: InkWell(
              //     onTap: () {
              //       Get.offAll(() => HomeScreen());
              //     },
              //     child: DrawerHeader(
              //       decoration: BoxDecoration(
              //         color: kPrimaryColor,
              //       ),
              //       // child: Row(
              //       //   children: [
              //       //     Icon(
              //       //       Icons.home,
              //       //       color: Colors.white,
              //       //     ),
              //       //     SizedBox(width: 20),
              //       //     Text(
              //       //       'My Home',
              //       //       style: TextStyle(color: Colors.white),
              //       //     ),
              //       //   ],
              //       // ),
              //     ),
              //   ),
              // ),
              ListTile(
                title: const Text('Home Page'),
                leading: const Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                onTap: () {
                  Get.back();
                  Get.offAll(() => HomeScreen());
                },
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  Get.to(() => ProfileScreen());
                },
                leading: Icon(Icons.person, color: kPrimaryColor),
                title: Text("My Account"),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  Get.to(() => FavoritesScreen());
                },
                leading: Icon(Icons.favorite_border, color: kPrimaryColor),
                title: Text("My Favourite"),
              ),
              ListTile(
                onTap: () {
                  //Get.put(ProfileController())
                  Get.back();
                  Get.to(()=>UserOrdersScreen());
                },
                leading: Icon(Icons.drive_file_move_outline, color: kPrimaryColor),
                title: Text("My Orders"),
              ),
              ListTile(
                onTap: () {
                  Get.back();
                  Get.to(() => CartScreen());
                },
                leading: Icon(Icons.shopping_cart_outlined, color: kPrimaryColor),
                title: Text("My Cart"),
              ),
              Divider(),
              ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                onTap: () {},
              ),
              ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                  color: Colors.blue,
                ),
                onTap: () {},
              ),
            ],
          ),
    );
  }
}
