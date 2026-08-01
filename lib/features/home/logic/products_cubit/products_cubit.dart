import 'package:ecommerce_app/features/home/data/repo/home_repo.dart';
import 'package:ecommerce_app/features/home/logic/products_cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._homeRepo) : super(ProductsInitialState());

  final HomeRepo _homeRepo;

  void fetchProducts() async {
    emit(ProductsLoadingState());
    final result = await _homeRepo.getProducts();
    result.fold(
      (error) => emit(ProductsErrorState(error)),
      (products) => emit(ProductsSuccessState(products)),
    );
  }

  void fetchCategoryProducts(String categoryName) async {
    emit(ProductsLoadingState());
    final result = await _homeRepo.getCategoryProducts(categoryName);
    result.fold(
      (error) => emit(ProductsErrorState(error)),
      (products) => emit(ProductsSuccessState(products)),
    );
  }
}
