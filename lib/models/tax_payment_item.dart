import 'package:moneynote4/extensions/extensions.dart';

class TaxPaymentItem {
  TaxPaymentItem({
    this.id,
    required this.year,
    required this.businessIncome,
    required this.incomeDividend,
    required this.salaryIncome,
    required this.expenses,
    required this.incomeAmountDividend,
    required this.employmentIncome,
    required this.socialInsuranceDeduction,
    required this.smallBusinessDeduction,
    required this.lifeInsuranceDeduction,
    required this.donationDeduction,
    required this.dividendDeduction,
    required this.withholdingTaxAmount,
    required this.blueSpecialDeduction,
  });

  factory TaxPaymentItem.fromJson(Map<String, dynamic> json) => TaxPaymentItem(
//        id: json['id'].toString().toInt(),
        year: json['year'].toString(),
        businessIncome: json['business_income'].toString().toInt(),
        incomeDividend: json['income_dividend'].toString().toInt(),
        salaryIncome: json['salary_income'].toString().toInt(),
        expenses: json['expenses'].toString().toInt(),
        incomeAmountDividend: json['income_amount_dividend'].toString().toInt(),
        employmentIncome: json['employment_income'].toString().toInt(),
        socialInsuranceDeduction:
            json['social_insurance_deduction'].toString().toInt(),
        smallBusinessDeduction:
            json['small_business_deduction'].toString().toInt(),
        lifeInsuranceDeduction:
            json['life_insurance_deduction'].toString().toInt(),
        donationDeduction: json['donation_deduction'].toString().toInt(),
        dividendDeduction: json['dividend_deduction'].toString().toInt(),
        withholdingTaxAmount: json['withholding_tax_amount'].toString().toInt(),
        blueSpecialDeduction: json['blue_special_deduction'].toString().toInt(),
      );

  int? id;
  String year;
  int businessIncome;
  int incomeDividend;
  int salaryIncome;
  int expenses;
  int incomeAmountDividend;
  int employmentIncome;
  int socialInsuranceDeduction;
  int smallBusinessDeduction;
  int lifeInsuranceDeduction;
  int donationDeduction;
  int dividendDeduction;
  int withholdingTaxAmount;
  int blueSpecialDeduction;

  Map<String, dynamic> toJson() => {
        'id': id,
        'year': year,
        'business_income': businessIncome,
        'income_dividend': incomeDividend,
        'salary_income': salaryIncome,
        'expenses': expenses,
        'income_amount_dividend': incomeAmountDividend,
        'employment_income': employmentIncome,
        'social_insurance_deduction': socialInsuranceDeduction,
        'small_business_deduction': smallBusinessDeduction,
        'life_insurance_deduction': lifeInsuranceDeduction,
        'donation_deduction': donationDeduction,
        'dividend_deduction': dividendDeduction,
        'withholding_tax_amount': withholdingTaxAmount,
        'blue_special_deduction': blueSpecialDeduction,
      };
}
