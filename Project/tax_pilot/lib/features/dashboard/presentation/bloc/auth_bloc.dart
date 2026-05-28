import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tax_pilot/features/dashboard/presentation/bloc/auth_event.dart';
import 'package:tax_pilot/features/dashboard/presentation/bloc/auth_state.dart';

// import 'auth_event.dart';
// import 'auth_state.dart';

class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {

    // =====================================================
    // LOGIN
    // =====================================================

    on<LoginRequested>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          await Future.delayed(
            const Duration(seconds: 2),
          );

          // TODO:
          // Replace with Firebase Auth login

          emit(
            AuthAuthenticated(
              userId: 'taxpilot_user_001',
              email: event.email,
            ),
          );
        } catch (e) {
          emit(
            AuthError(
              'Login failed. Please try again.',
            ),
          );
        }
      },
    );

    // =====================================================
    // SIGNUP
    // =====================================================

    on<SignupRequested>(
      (event, emit) async {
        emit(AuthLoading());

        try {

          // ===============================================
          // VALIDATIONS
          // ===============================================

          if (event.fullName
              .trim()
              .isEmpty) {
            emit(
              AuthError(
                'Full name is required.',
              ),
            );

            return;
          }

          if (event.email
                  .trim()
                  .isEmpty ||
              !event.email.contains('@')) {
            emit(
              AuthError(
                'Enter a valid email address.',
              ),
            );

            return;
          }

          if (event.password.length < 6) {
            emit(
              AuthError(
                'Password must be at least 6 characters.',
              ),
            );

            return;
          }

          if (event.password !=
              event.confirmPassword) {
            emit(
              AuthError(
                'Passwords do not match.',
              ),
            );

            return;
          }

          // ===============================================
          // API / FIREBASE PLACEHOLDER
          // ===============================================

          await Future.delayed(
            const Duration(seconds: 2),
          );

          // TODO:
          // Firebase signup
          // Backend user creation
          // Save user profile

          emit(SignupSuccess());

        } catch (e) {
          emit(
            AuthError(
              'Signup failed. Please try again.',
            ),
          );
        }
      },
    );

    // =====================================================
    // GOOGLE SIGN IN
    // =====================================================

    on<GoogleSignInRequested>(
      (event, emit) async {
        emit(AuthLoading());

        try {
          await Future.delayed(
            const Duration(seconds: 2),
          );

          // TODO:
          // Google Sign In integration

          emit(
            AuthAuthenticated(
              userId: 'google_user_001',
              email:
                  'user@gmail.com',
            ),
          );
        } catch (e) {
          emit(
            AuthError(
              'Google sign in failed.',
            ),
          );
        }
      },
    );

    // =====================================================
    // LOGOUT
    // =====================================================

    on<LogoutRequested>(
      (event, emit) async {

        // TODO:
        // Firebase logout

        emit(AuthLoggedOut());
      },
    );
  }
}

