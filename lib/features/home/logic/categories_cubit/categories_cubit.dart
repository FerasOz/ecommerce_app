import 'package:ecommerce_app/features/home/data/repo/home_repo.dart';
import 'package:ecommerce_app/features/home/logic/categories_cubit/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._homeRepo) : super(CategoriesInitialState());

  final HomeRepo _homeRepo;

  void fetchCategories() async {
    emit(CategoriesLoadingState());
    final result = await _homeRepo.getAllCategories();
    result.fold(
      (error) => emit(CategoriesErrorState(error)),
      (categories) => emit(CategoriesSuccessState(categories)),
    );
  }

}
