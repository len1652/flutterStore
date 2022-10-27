import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart/cart_controller.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController cartController = CartController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: Obx((){
        if (cartController.loading.value){
          return Center(child: CircularProgressIndicator());
        }
        if (cartController.cartItems.isEmpty){
          return Center(child: Text("No cart items foud!"));
        }
        return Stack(
          children: [
            Container(

            ),
            Positioned.fill(
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: cartController.cartItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  elevation: 0,
                  child: Container(
                    height: 110,
                    width: 100,

                    margin: EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(cartController.cartItems[index]["product"]["image"])
                            ),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartController.cartItems[index]["product"]["title"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(child: Text(cartController.cartItems[index]["product"]["description"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),

                                Text(
                                  "\$${cartController.cartItems[index]["product"]["price"]}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey,
                              child: Icon(Icons.remove),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(cartController.cartItems[index]["quantity"].toString()),
                            ),
                            Container(
                              color: Colors.grey,
                              child: Icon(Icons.add),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _buildBottom()
          ],
        );

      },),
    );
  }

  Positioned _buildBottom() {
    return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(
              left:  16.0,
              right: 16,
              bottom: 8.0,
              top: 4.0,
            ),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("subtotal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                      ),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${cartController.subtotal}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text("Subtotal does not include shipping"
                          ,style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(

                  children: [

                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16.0
                            ),
                            primary: Colors.red,
                            elevation:  0,
                            textStyle:  TextStyle(
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: Colors.black38
                                )
                            ),
                          ),
                        onPressed: (){},
                        child: Text("Check out")
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16.0
                          ),
                          primary: Colors.white,
                          elevation:  0,
                          textStyle:  TextStyle(
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: Colors.black38
                            )
                          ),
                        ),
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Check out with", style: TextStyle(color: Colors.black),),
                            SizedBox(width: 4,),
                            Container(
                              width: 60,
                              height: 20,
                              decoration:  BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage("https://kieutruong.com/wp-content/uploads/2019/11/huong-dan-dang-ky-tai-khoan-paypal-1024x512.jpg")
                                )
                              ),
                            ),
                          ],
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Text("Continue shopping"),
              ],
            ),
          ),
        );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle:  true,
      title: Text(
        "Cart",
        style: TextStyle(
          color: Colors.redAccent,
        ),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.share))
      ],
      iconTheme: IconThemeData(color: Colors.red),
    );
  }
}
