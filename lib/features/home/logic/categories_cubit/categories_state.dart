abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesSuccessState extends CategoriesState {
  final List<String> categories;

  CategoriesSuccessState(this.categories);
}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;

  CategoriesErrorState(this.errorMessage);
}