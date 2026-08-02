import 'package:ecommerce_app/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class GettingCartLoadingState extends CartState {}

class GettingCartSuccessState extends CartState {
  final CartModel cartItem;
  GettingCartSuccessState({required this.cartItem});
}

class GettingCartErrorState extends CartState {
  final String errorMessage;
  GettingCartErrorState({required this.errorMessage});
}

class AddingCartLoadingState extends CartState {}

class AddingCartSuccessState extends CartState {
  final CartModel cartItem;
  AddingCartSuccessState({required this.cartItem});
}

class AddingCartErrorState extends CartState {
  final String errorMessage;
  AddingCartErrorState({required this.errorMessage});
}
