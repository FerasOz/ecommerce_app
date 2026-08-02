import 'package:ecommerce_app/features/cart/cubit/cart_state.dart';
import 'package:ecommerce_app/features/cart/data/repo/cart_repo.dart';
import 'package:ecommerce_app/features/home/data/models/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this._cartRepo) : super(CartInitialState());

  final CartRepo _cartRepo;

  Future<void> fetchCart() async {
    emit(GettingCartLoadingState());
    final result = await _cartRepo.getUserCart();
    result.fold(
      (error) => emit(GettingCartErrorState(errorMessage: error)),
      (cartItem) => emit(GettingCartSuccessState(cartItem: cartItem)),
    );
  }

  Future<void> addingToCart({
    required int quantity,
    required ProductsModel product,
  }) async {
    emit(AddingCartLoadingState());
    DateTime now = DateTime.now();
    final result = await _cartRepo.addToCart(
      product: product,
      date: now.toString(),
      quantity: quantity,
    );
    result.fold(
      (error) => emit(AddingCartErrorState(errorMessage: error)),
      (cartItem) => emit(AddingCartSuccessState(cartItem: cartItem)),
    );
  }
}
