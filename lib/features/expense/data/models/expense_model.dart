class Expense {
  final int? id;
  final String merchant;
  final double amount;
  final String category;
  final String date;
  final String? notes;

  Expense({
    this.id,
    required this.merchant,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'merchant': merchant,
      'amount': amount,
      'category': category,
      'date': date,
      'notes': notes,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int?,
      merchant: map['merchant'] ?? '',
      amount: _parseDouble(map['amount']),
      category: map['category'] ?? '',
      date: map['date'] ?? '',
      notes: map['notes'],
    );
  }

  // 🔥 SAFE CONVERSION (IMPORTANT FIX)
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}