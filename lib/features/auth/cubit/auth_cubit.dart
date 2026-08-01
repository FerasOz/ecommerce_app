import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_state.dart';
import 'package:ecommerce_app/features/auth/data/models/login_response_model.dart';
import 'package:ecommerce_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());

  final AuthRepo _authRepo;

  void login({required String username, required String password}) async {
    emit(LoadingAuthState());

    final Either<String, LoginResponseModel> response = await _authRepo.login(
      username: username,
      password: password,
    );

    response.fold((error) {
      emit(ErrorAuthState(error));
    }, (success) {
      emit(SuccessAuthState("Login Successfully ..."));
    });
  }
}
