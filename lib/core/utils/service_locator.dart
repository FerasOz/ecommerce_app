import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/data/repo/auth_repo.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/data/repo/cart_repo.dart';
import 'package:ecommerce_app/features/home/data/repo/home_repo.dart';
import 'package:ecommerce_app/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:ecommerce_app/features/home/logic/products_cubit/products_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  //Dio
  DioHelper dio = DioHelper();
  sl.registerSingleton<DioHelper>(dio);

  //Secure Storage
  sl.registerLazySingleton(() => StorageHelper());

  //Auth
  sl.registerLazySingleton(() => AuthRepo(sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  //Home
  sl.registerLazySingleton(() => HomeRepo(sl()));
  sl.registerFactory(() => CategoriesCubit(sl()));
  sl.registerFactory(() => ProductsCubit(sl()));

  //Cart
  sl.registerLazySingleton(() => CartRepo(sl()));
  sl.registerFactory(() => CartCubit(sl()));
}
