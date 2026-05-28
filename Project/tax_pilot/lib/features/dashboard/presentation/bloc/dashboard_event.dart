import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

// =========================================================
// LOAD DASHBOARD
// =========================================================

class LoadDashboardEvent extends DashboardEvent {
  const LoadDashboardEvent();
}

// =========================================================
// REFRESH DASHBOARD
// =========================================================

class RefreshDashboardEvent extends DashboardEvent {
  const RefreshDashboardEvent();
}

// =========================================================
// LOAD AI INSIGHTS
// =========================================================

class LoadAiInsightsEvent extends DashboardEvent {
  const LoadAiInsightsEvent();
}

// =========================================================
// LOAD RECENT ACTIVITIES
// =========================================================

class LoadRecentActivitiesEvent extends DashboardEvent {
  const LoadRecentActivitiesEvent();
}

// =========================================================
// LOAD FINANCIAL SUMMARY
// =========================================================

class LoadFinancialSummaryEvent extends DashboardEvent {
  const LoadFinancialSummaryEvent();
}

// =========================================================
// LOAD TAX OVERVIEW
// =========================================================

class LoadTaxOverviewEvent extends DashboardEvent {
  const LoadTaxOverviewEvent();
}