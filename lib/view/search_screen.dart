import 'package:e_commerce/constants.dart';
import 'package:e_commerce/view/details_screen.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/icon_container.dart';
import 'package:e_commerce/controllers/search_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../controllers/cart_controller.dart';
import '../controllers/favorites_controller.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          backgroundColor: kPrimaryColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
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
                      child: Icon(Icons.favorite_border_outlined),
                      //alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Icon(Icons.favorite_border_outlined),
              // ),
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
                          : ''),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Align(
                    child: Icon(Icons.shopping_cart),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          padding:
              EdgeInsets.only(top: 55.0, right: 13.0, bottom: 5.0, left: 13.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: controller.searchFormKey,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.grey.shade200,
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: controller.typedValueController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 8.0, top: 13),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    controller.typedValueController.clear();
                                  },
                                ),
                                hintText: 'Search',
                              ),
                            ),
                            suggestionsCallback: (pattern) {
                              return controller
                                  .getSearchSuggestions(pattern.trimLeft());
                            },
                            getImmediateSuggestions: true,
                            hideOnEmpty: true,
                            hideOnLoading: true,
                            hideSuggestionsOnKeyboardHide: true,
                            // noItemsFoundBuilder: (context) {
                            //   return Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text('No Recommendations'),
                            //   );
                            // },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: SubstringHighlight(
                                  text: suggestion.toString(),
                                  term: controller.typedValueController.text,
                                  textStyleHighlight: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              );
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (suggestion) {
                              controller.typedValueController.text = suggestion.toString();
                            },
                            onSaved: (value) {
                              String val = value!.trimLeft();
                              controller.searchText = val;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconContainer(
                    icon: Icons.search,
                    onIconPressed: () {
                      controller.onSearchPressed();
                    },
                  ),
                ],
              ),
              Expanded(
                child: controller.loading.value
                    ? LinearProgressIndicator()
                    : controller.searchResultList.isEmpty
                        ? CustomText(
                            text: controller.searchIconPressed
                                ? 'No Products Found ...!!'
                                : 'Type Something to search ...!!',
                            size: 25.0,
                            alignment: Alignment.center,
                          )
                        : Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: ListView.separated(
                              itemCount: controller.searchResultList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      DetailsScreen(
                                        model:
                                            controller.searchResultList[index],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.11),
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 70.0,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: Image.network(controller
                                                .searchResultList[index].image!),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text:
                                                  '${controller.searchResultList[index].name}',
                                              size: 19.0,
                                              alignment: Alignment.topLeft,
                                            ),
                                            SizedBox(height: 10.0),
                                            CustomText(
                                              text:
                                                  '  \$ ${controller.searchResultList[index].price}',
                                              fontColor: kPrimaryColor,
                                              size: 17.0,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 14.0,
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
 controller.loading.value
                  ? Center(child: CircularProgressIndicator())
                  :


 */
