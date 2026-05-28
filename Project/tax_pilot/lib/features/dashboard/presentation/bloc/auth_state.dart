abstract class AuthState {}

// =========================================================
// INITIAL
// =========================================================

class AuthInitial extends AuthState {}

// =========================================================
// LOADING
// =========================================================

class AuthLoading extends AuthState {}

// =========================================================
// AUTHENTICATED
// =========================================================

class AuthAuthenticated
    extends AuthState {
  final String userId;
  final String email;

  AuthAuthenticated({
    required this.userId,
    required this.email,
  });
}

// =========================================================
// SIGNUP SUCCESS
// =========================================================

class SignupSuccess extends AuthState {}

// =========================================================
// LOGGED OUT
// =========================================================

class AuthLoggedOut extends AuthState {}

// =========================================================
// ERROR
// =========================================================

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}