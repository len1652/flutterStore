import 'package:get/get.dart';
import 'package:shop_app/controllers/products_repository.dart';

class ProductsController extends GetxController{
  ProductsRepository _productsRepository = ProductsRepository();
  RxBool loading = false.obs;
  List products = [].obs;
  var showGrid = false.obs;

  ProductsController(){
    loadProductFromRepo();
  }


  loadProductFromRepo() async {
    loading(true);
    products = await _productsRepository.loadProductsFromApi();
    loading(false);

  }
  toggleGrid(){
    showGrid(!showGrid.value);
  }
}