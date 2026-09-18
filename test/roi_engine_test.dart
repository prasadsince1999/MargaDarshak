import 'package:flutter_test/flutter_test.dart';
import 'package:margadarshak/features/family_bridge/domain/roi_engine.dart';

void main() {
  group('RoiEngine Pure Domain Tests', () {
    test('getAnnualTuition returns correct statutory estimates by tier', () {
      expect(RoiEngine.getAnnualTuition(0), 125000.0);
      expect(RoiEngine.getAnnualTuition(1), 45000.0);
      expect(RoiEngine.getAnnualTuition(2), 220000.0);
    });

    test('getAnnualHostel respects hostel accommodation selection', () {
      expect(RoiEngine.getAnnualHostel(true), 65000.0);
      expect(RoiEngine.getAnnualHostel(false), 0.0);
    });

    test('getMedianSalary reflects verified NIRF salary bands', () {
      expect(RoiEngine.getMedianSalary(0), 1200000.0);
      expect(RoiEngine.getMedianSalary(1), 550000.0);
      expect(RoiEngine.getMedianSalary(2), 400000.0);
    });

    test('getMonthlyInHand calculates net take-home after 15% deductions', () {
      final monthly = RoiEngine.getMonthlyInHand(1200000.0);
      expect(monthly, closeTo(85000.0, 0.01));
    });

    test(
      'calculateMonthlyEmi accurately computes standard SBI student loan amortizations',
      () {
        // Zero loan amount should return 0
        expect(RoiEngine.calculateMonthlyEmi(0), 0.0);
        expect(RoiEngine.calculateMonthlyEmi(-5000), 0.0);

        // 4 Lakhs @ 9.5% for 60 months
        final emi4L = RoiEngine.calculateMonthlyEmi(400000);
        expect(emi4L, closeTo(8401.7, 1.0));

        // 10 Lakhs @ 9.5% for 60 months
        final emi10L = RoiEngine.calculateMonthlyEmi(1000000);
        expect(emi10L, closeTo(21001.86, 1.0));
      },
    );

    test(
      'calculatePaybackYears returns valid ratio string or zero on invalid inputs',
      () {
        // Total cost 7,60,000, median 12,00,000 -> 0.6 years
        expect(RoiEngine.calculatePaybackYears(760000, 1200000), '0.6');

        // Edge case: zero salary
        expect(RoiEngine.calculatePaybackYears(500000, 0), '0.0');
      },
    );

    test(
      'RoiEstimate.formatCurrency formats Lakhs and direct INR numbers accurately',
      () {
        expect(RoiEstimate.formatCurrency(45000), '45000');
        expect(RoiEstimate.formatCurrency(100000), '1.0 L');
        expect(RoiEstimate.formatCurrency(550000), '5.5 L');
        expect(RoiEstimate.formatCurrency(1200000), '12.0 L');
      },
    );

    test(
      'calculate aggregates all parameters into an immutable RoiEstimate model',
      () {
        final estimate = RoiEngine.calculate(
          collegeTier: 0,
          durationYears: 4,
          includeHostel: true,
          loanAmount: 400000,
        );

        // (125000 + 65000) * 4 = 760000
        expect(estimate.totalCourseCost, 760000.0);
        expect(estimate.annualTuition, 125000.0);
        expect(estimate.annualHostel, 65000.0);
        expect(estimate.medianSalary, 1200000.0);
        expect(estimate.paybackYears, '0.6');
        expect(estimate.monthlyEmi, closeTo(8401.7, 1.0));
        expect(estimate.monthlyInHand, closeTo(85000.0, 0.01));
      },
    );
  });
}
