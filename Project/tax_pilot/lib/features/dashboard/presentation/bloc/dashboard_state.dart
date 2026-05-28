import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

// =========================================================
// INITIAL
// =========================================================

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

// =========================================================
// LOADING
// =========================================================

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

// =========================================================
// REFRESHING
// =========================================================

class DashboardRefreshing extends DashboardState {
  const DashboardRefreshing();
}

// =========================================================
// LOADED
// =========================================================

class DashboardLoaded extends DashboardState {

  final String totalBalance;
  final String monthlyIncome;
  final String monthlyExpense;
  final String estimatedTax;

  const DashboardLoaded({
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.estimatedTax,
  });

  @override
  List<Object?> get props => [
        totalBalance,
        monthlyIncome,
        monthlyExpense,
        estimatedTax,
      ];
}

// =========================================================
// AI INSIGHTS LOADED
// =========================================================

class DashboardAiInsightsLoaded extends DashboardState {

  final List<String> insights;

  const DashboardAiInsightsLoaded({
    required this.insights,
  });

  @override
  List<Object?> get props => [insights];
}

// =========================================================
// RECENT ACTIVITIES LOADED
// =========================================================

class DashboardRecentActivitiesLoaded extends DashboardState {

  final List<String> activities;

  const DashboardRecentActivitiesLoaded({
    required this.activities,
  });

  @override
  List<Object?> get props => [activities];
}

// =========================================================
// ERROR
// =========================================================

class DashboardError extends DashboardState {

  final String message;

  const DashboardError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}