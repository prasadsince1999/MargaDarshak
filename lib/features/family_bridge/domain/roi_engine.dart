import 'dart:math' as math;

/// Domain model representing the calculated financial ROI and loan metrics.
class RoiEstimate {
  const RoiEstimate({
    required this.collegeTier,
    required this.durationYears,
    required this.includeHostel,
    required this.loanAmount,
    required this.annualTuition,
    required this.annualHostel,
    required this.totalCourseCost,
    required this.medianSalary,
    required this.monthlyInHand,
    required this.monthlyEmi,
    required this.paybackYears,
  });

  final int collegeTier;
  final int durationYears;
  final bool includeHostel;
  final double loanAmount;
  final double annualTuition;
  final double annualHostel;
  final double totalCourseCost;
  final double medianSalary;
  final double monthlyInHand;
  final double monthlyEmi;
  final String paybackYears;

  /// Human-readable currency formatting helper (e.g. "5.5 L" or "45000").
  static String formatCurrency(double amount) {
    if (amount >= 100000) {
      final inLakhs = amount / 100000;
      return '${inLakhs.toStringAsFixed(1)} L';
    }
    return amount.toStringAsFixed(0);
  }
}

/// Pure Dart financial calculation engine for higher education ROI and student loans.
abstract final class RoiEngine {
  /// Top Govt = 0, State Govt / Aided = 1, Private / Deemed = 2.
  static double getAnnualTuition(int tier) {
    return switch (tier) {
      0 => 125000.0, // Top Govt (IIT/NIT/Central)
      1 => 45000.0, // State Govt / Autonomous Aided
      _ => 220000.0, // Private / Deemed University
    };
  }

  /// Estimated annual hostel and living expenses.
  static double getAnnualHostel(bool includeHostel) {
    return includeHostel ? 65000.0 : 0.0;
  }

  /// Expected median entry-level starting salary (CTC in INR).
  static double getMedianSalary(int tier) {
    return switch (tier) {
      0 => 1200000.0, // ₹12 LPA
      1 => 550000.0, // ₹5.5 LPA
      _ => 400000.0, // ₹4.0 LPA
    };
  }

  /// Monthly take-home estimate (approx 85% of CTC / 12 months).
  static double getMonthlyInHand(double medianSalary) {
    return (medianSalary * 0.85) / 12;
  }

  /// Standard SBI Student Loan EMI: 5-year repayment @ 9.5% interest.
  /// Monthly interest rate r = 0.095 / 12 = 0.00791667.
  /// Formula: EMI = [P * r * (1+r)^n] / [(1+r)^n - 1], where n = 60 months.
  static double calculateMonthlyEmi(
    double loanAmount, {
    double annualRate = 0.095,
    int tenureMonths = 60,
  }) {
    if (loanAmount <= 0) return 0.0;
    final r = annualRate / 12;
    final factor = math.pow(1 + r, tenureMonths).toDouble();
    return (loanAmount * r * factor) / (factor - 1);
  }

  /// Payback period in years: Total Course Cost / Annual Median Salary.
  static String calculatePaybackYears(double totalCost, double medianSalary) {
    if (medianSalary <= 0) return '0.0';
    return (totalCost / medianSalary).toStringAsFixed(1);
  }

  /// Comprehensive calculation producing an immutable [RoiEstimate].
  static RoiEstimate calculate({
    required int collegeTier,
    required int durationYears,
    required bool includeHostel,
    required double loanAmount,
  }) {
    final annualTuition = getAnnualTuition(collegeTier);
    final annualHostel = getAnnualHostel(includeHostel);
    final totalCourseCost = (annualTuition + annualHostel) * durationYears;
    final medianSalary = getMedianSalary(collegeTier);
    final monthlyInHand = getMonthlyInHand(medianSalary);
    final monthlyEmi = calculateMonthlyEmi(loanAmount);
    final paybackYears = calculatePaybackYears(totalCourseCost, medianSalary);

    return RoiEstimate(
      collegeTier: collegeTier,
      durationYears: durationYears,
      includeHostel: includeHostel,
      loanAmount: loanAmount,
      annualTuition: annualTuition,
      annualHostel: annualHostel,
      totalCourseCost: totalCourseCost,
      medianSalary: medianSalary,
      monthlyInHand: monthlyInHand,
      monthlyEmi: monthlyEmi,
      paybackYears: paybackYears,
    );
  }
}
