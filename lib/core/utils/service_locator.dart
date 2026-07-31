import 'package:ecommerce_app/core/network/dio_helper.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/data/repo/auth_repo.dart';
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
}
