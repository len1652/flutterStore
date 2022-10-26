import 'dart:convert';

import 'package:http/http.dart' as http;
class ProductsRepository{
  var url = "http://fakestoreapi.com/products/category/";
  var response;

  loadProductsFromApi(String categoryName) async {
    this.response = await http.get(Uri.parse(url + categoryName));
    return json.decode(response.body);
  }

  loadRatingFromApi(String categoryName) async{
    var productsJson = json.decode(response.body);
    var Rating = (productsJson["rating"]);
    // print("${Rating}");
    return Rating;
  }
}