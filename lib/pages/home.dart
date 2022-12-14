import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/categories/cateries_controller.dart';
import 'cart.dart';
import 'info_product.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoriesController categoriesController = CategoriesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.grey[100],
        body: Obx(() {
          if (categoriesController.loading.value)
            return Center(child: CircularProgressIndicator());
          if (categoriesController.categories.isEmpty) {
            return Center(child: Text("No categories found"));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTop(),
                _buildCategoriesRow(),
                Expanded(
                  child: Obx(
                    () {
                      if (productsController.loading.value)
                        return Center(child: CircularProgressIndicator());
                      if (productsController.products.isEmpty) {
                        return Center(child: Text("No products found"));
                      }
                      if (productsController.showGrid.value)
                        return _buildGrid();
                      return _buildProductsList();
                    },
                  ),
                ),
              ],
            ),
          );
        }));
  }

  GridView _buildGrid() {
    return GridView.builder(
      padding: EdgeInsets.only(top: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: productsController.products.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 0.0,
          child: InkWell(

            onTap: ((){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => info(
                    productsController.products[index]["image"],
                    productsController.products[index]["title"],
                    productsController.products[index]["description"],
                    productsController.products[index]["price"]
                  ),
                ),
              );

            }),
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
                            productsController.products[index]["image"]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsController.products[index]["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Text(
                              productsController.products[index]["description"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$${productsController.products[index]["price"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(Icons.add_shopping_cart)),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star,color: Colors.yellow,),
                                    Icon(Icons.star_half,color: Colors.yellow,),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ListView _buildProductsList() {
    return ListView.builder(
      itemCount: productsController.products.length,
      padding: EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        return Card(
          elevation: 0.0,
          child: InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => info(
                      productsController.products[index]["image"],
                      productsController.products[index]["title"],
                      productsController.products[index]["description"],
                      productsController.products[index]["price"]
                  ),
                ),
              );
            },
            child: Container(
              height: 160,
              padding: EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            productsController.products[index]["image"]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsController.products[index]["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                            child: Text(
                              productsController.products[index]["description"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // Text(
                          //     productsController.rating[index]["count"]
                          // ),
                          IconButton(
                              onPressed: () {

                              },
                              icon: Icon(Icons.add_shopping_cart)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$${productsController.products[index]["price"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Icon(Icons.star,color: Colors.yellow,),
                                  Icon(Icons.star_half,color: Colors.yellow,),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
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
                  "Cloths",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_down),
                )
              ],
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              productsController.toggleGrid();
            },
            icon: Icon(Icons.filter_list)),
      ],
    );
  }

  Container _buildCategoriesRow() {
    return Container(
      height: 35.0,
      margin: EdgeInsets.only(top: 16),
      child: ListView.builder(
          itemCount: categoriesController.categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Obx(
                () => InkWell(
                  onTap: () {
                    categoriesController.changeCategories(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: index == categoriesController.currentIndex.value
                          ? Colors.redAccent
                          : Colors.transparent,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      categoriesController.categories[index],
                      style: TextStyle(
                        color: index == categoriesController.currentIndex.value
                            ? Colors.white
                            : Colors.red,
                      ),
                    ),
                  ),
                ),
              )),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      leading: BackButton(),
      elevation: 0,
      title: Text(
        "SHOPPO",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartPage(),
              ));
            },
            icon: Icon(Icons.shopping_cart_outlined)),
      ],
    );
  }
}
