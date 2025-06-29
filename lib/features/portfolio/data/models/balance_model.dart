class BalanceModel {
  final double netValue;
  final double pnl;
  final double pnlPercentage;

  BalanceModel({
    required this.netValue,
    required this.pnl,
    required this.pnlPercentage,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      netValue: (json['netValue'] as num).toDouble(),
      pnl: (json['pnl'] as num).toDouble(),
      pnlPercentage: (json['pnlPercentage'] as num).toDouble(),
    );
  }
}
