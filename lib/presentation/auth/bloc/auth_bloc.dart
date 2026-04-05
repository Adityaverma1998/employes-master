import 'package:employes_master/core/helper/shared_prefs/custom_shared_prefs.dart';
import 'package:employes_master/core/helper/shared_prefs/shared_presfsConstant.dart';
import 'package:employes_master/domain/entities/user.dart';
import 'package:employes_master/domain/usecase/auth/login_usecase.dart';
import 'package:employes_master/domain/usecase/auth/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({required this.loginUseCase, required this.logoutUseCase})
    : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthEvent>(_onCheckAuth);
    on<OnBoardingEvent>(_onBoardingEvent);
  }

  /// handle redirect
  Future<void> _onBoardingEvent(
    OnBoardingEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final isLogin =
          await CustomSharedPref.getBool(SharedPrefsConstant.isLoggedIn) ??
          false;

      emit(OnBoardLoaded(isLogin));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  ///  LOGIN
  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    await result.fold((failure) async => emit(AuthError(failure.message)), (
      user,
    ) async {
      ///  SAVE LOCALLY
      await CustomSharedPref.saveBool(SharedPrefsConstant.isLoggedIn, true);

      await CustomSharedPref.saveString(SharedPrefsConstant.userId, user.uid);

      await CustomSharedPref.saveString(
        SharedPrefsConstant.userEmail,
        user.email,
      );

      emit(AuthAuthenticated(user));
    });
  }

  ///  LOGOUT
  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logoutUseCase();

    await result.fold((failure) async => emit(AuthError(failure.message)), (
      _,
    ) async {
      ///  CLEAR STORAGE
      await CustomSharedPref.clearData();

      emit(AuthUnauthenticated());
    });
  }

  ///  CHECK AUTH (APP START)
  Future<void> _onCheckAuth(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    ///  CHECK SECURE STORAGE
    final isLoggedIn = await CustomSharedPref.getBool(
      SharedPrefsConstant.isLoggedIn,
    );

    ///  CHECK FIREBASE
    final firebaseUser = fb.FirebaseAuth.instance.currentUser;

    if (isLoggedIn && firebaseUser != null) {
      emit(
        AuthAuthenticated(
          User(uid: firebaseUser.uid, email: firebaseUser.email ?? ""),
        ),
      );
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
