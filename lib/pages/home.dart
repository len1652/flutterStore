import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shop_app/controllers/product_controller.dart';

import 'cart.dart';

class HomeView extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());
  final List categories = [
    "TShirt",
    "Pants",
    "Jeans",
    "Jackets",
    "Shirt",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTop(),
            _buildCategoriesRow(),
            Expanded(
              child: Obx(
                () {
                  if(productsController.loading.value){
                    return Center(child: CircularProgressIndicator());
                  }
                  if(productsController.products.isEmpty ){
                    return Center(child: Text("No products found"));
                  }
                  if(productsController.showGrid.value)
                  return _buildProductGrid();

                  return _buildProductList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView _buildProductGrid() {
    return GridView.builder(
                  padding: EdgeInsets.only(top: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: productsController.products.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      elevation: 0.0,
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      productsController.products[index]
                                      ["image"]
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productsController.products[index]
                                      ["title"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,

                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Expanded(
                                      child: Text(
                                        productsController.products[index]
                                        ["description"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      "\$${ productsController.products[index]
                                      ["price"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  );
  }

  ListView _buildProductList() {
    return ListView.builder(

                  itemCount: productsController.products.length,
                  padding: EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) => Card(
                    elevation: 0.0,
                    child: Container(
                      height: 120,
                      padding: EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 100,

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  productsController.products[index]
                                  ["image"]
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productsController.products[index]
                                    ["title"],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,

                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                    child: Text(
                                      productsController.products[index]
                                      ["description"],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                   "\$${ productsController.products[index]
                                  ["price"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
  }

  Row _buildTop() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Clother",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {
          productsController.toggleGrid();
        }, icon: Icon(Icons.filter_list)),
      ],
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      height: 35.0,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: index == 0 ? Colors.black87 : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            categories[index],
            style: TextStyle(
              color: index == 0 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      leading: BackButton(),
      elevation: 0,
      title: Text(
        "SHOPPE",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder:
            (context) => CartPage(),
          ));
        }, icon: Icon(Icons.shopping_cart_outlined)),
      ],
    );
  }
}
