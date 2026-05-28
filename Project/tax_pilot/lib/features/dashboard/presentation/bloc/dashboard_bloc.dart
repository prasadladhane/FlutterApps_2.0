import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  DashboardBloc() : super(const DashboardInitial()) {

    /// INITIAL DASHBOARD LOAD
    on<LoadDashboardEvent>(_onLoadDashboard);

    /// REFRESH DASHBOARD
    on<RefreshDashboardEvent>(_onRefreshDashboard);

    /// LOAD AI INSIGHTS
    on<LoadAiInsightsEvent>(_onLoadAiInsights);

    /// LOAD RECENT ACTIVITIES
    on<LoadRecentActivitiesEvent>(_onLoadRecentActivities);
  }

  // =========================================================
  // LOAD DASHBOARD
  // =========================================================

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {

    emit(const DashboardLoading());

    try {

      /// FUTURE:
      /// API CALLS
      /// FIREBASE
      /// POSTGRESQL
      /// SPRING BOOT SERVICES
      /// ANALYTICS FETCH
      /// TAX SUMMARY FETCH

      await Future.delayed(
        const Duration(seconds: 2),
      );

      emit(
        const DashboardLoaded(
          totalBalance: '₹2,45,000',
          monthlyIncome: '₹85,000',
          monthlyExpense: '₹35,000',
          estimatedTax: '₹12,000',
        ),
      );

    } catch (e) {

      emit(
        DashboardError(
          message: e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // REFRESH DASHBOARD
  // =========================================================

  Future<void> _onRefreshDashboard(
    RefreshDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {

    emit(const DashboardRefreshing());

    try {

      await Future.delayed(
        const Duration(seconds: 1),
      );

      emit(
        const DashboardLoaded(
          totalBalance: '₹2,45,000',
          monthlyIncome: '₹85,000',
          monthlyExpense: '₹35,000',
          estimatedTax: '₹12,000',
        ),
      );

    } catch (e) {

      emit(
        DashboardError(
          message: e.toString(),
        ),
      );
    }
  }

  // =========================================================
  // LOAD AI INSIGHTS
  // =========================================================

  Future<void> _onLoadAiInsights(
    LoadAiInsightsEvent event,
    Emitter<DashboardState> emit,
  ) async {

    /// FUTURE GEMINI AI INTEGRATION
  }

  // =========================================================
  // LOAD RECENT ACTIVITIES
  // =========================================================

  Future<void> _onLoadRecentActivities(
    LoadRecentActivitiesEvent event,
    Emitter<DashboardState> emit,
  ) async {

    /// FUTURE DATABASE FETCH
  }
}