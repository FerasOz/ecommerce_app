import 'package:ecommerce_app/features/home/data/models/products_model.dart';

abstract class ProductsState {}

class ProductsInitialState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsSuccessState extends ProductsState {
  final List<ProductsModel> products;

  ProductsSuccessState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String errorMessage;

  ProductsErrorState(this.errorMessage);
}
