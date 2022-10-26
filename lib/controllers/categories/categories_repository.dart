import 'dart:convert';
import 'package:http/http.dart' as http;


class CategoriesRepository {
  var url = "https://fakestoreapi.com/products/categories";

  loadCategoriesFromApi() async {
    var response = await http.get(Uri.parse(url));
    var categoriesJson = json.decode(response.body);
    var categories = categoriesJson;
    print(categories);
    return categories;
  }
}