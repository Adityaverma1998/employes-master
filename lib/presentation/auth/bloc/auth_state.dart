part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

///  Initial
class AuthInitial extends AuthState {}

/// Loading
class AuthLoading extends AuthState {}

/// Authenticated
class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Unauthenticated
class AuthUnauthenticated extends AuthState {}

///  Error
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class OnBoardLoaded extends AuthState {
  final bool isLogin;

  const OnBoardLoaded(this.isLogin);

  @override
  List<Object?> get props => [isLogin];
}
