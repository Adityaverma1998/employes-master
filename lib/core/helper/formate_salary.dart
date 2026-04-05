class FormateSalary {
  FormateSalary._();
  static String formatRupee(num amount) {
    if (amount >= 10000000) {
      return "₹${(amount / 10000000).toStringAsFixed(1).replaceAll('.0', '')}Cr";
    } else if (amount >= 100000) {
      return "₹${(amount / 100000).toStringAsFixed(1).replaceAll('.0', '')}L";
    } else if (amount >= 1000) {
      return "₹${(amount / 1000).toStringAsFixed(1).replaceAll('.0', '')}K";
    } else {
      return "₹${amount.toString()}";
    }
  }
}
