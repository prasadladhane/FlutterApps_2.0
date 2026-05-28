abstract class AuthEvent {}

// =========================================================
// LOGIN EVENT
// =========================================================

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({
    required this.email,
    required this.password,
  });
}

// =========================================================
// SIGNUP EVENT
// =========================================================

class SignupRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;

  SignupRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

// =========================================================
// GOOGLE SIGN IN EVENT
// =========================================================

class GoogleSignInRequested
    extends AuthEvent {}

// =========================================================
// LOGOUT EVENT
// =========================================================

class LogoutRequested extends AuthEvent {}