// lib/models.dart
import 'dart:convert';

class InvoiceItem {
  final String title;
  final double quantity;
  final double unitPrice;
  InvoiceItem({required this.title, required this.quantity, required this.unitPrice});
  double get total => quantity * unitPrice;
  Map<String, dynamic> toJson() => {'title': title, 'quantity': quantity, 'unitPrice': unitPrice};
  static InvoiceItem fromJson(Map<String,dynamic> j) => InvoiceItem(
    title: j['title'],
    quantity: (j['quantity'] as num).toDouble(),
    unitPrice: (j['unitPrice'] as num).toDouble()
  );
}

class Invoice {
  final String id;
  final String customerName;
  final String customerPhone;
  final DateTime date;
  final List<InvoiceItem> items;
  final double total;
  Invoice({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.date,
    required this.items,
    required this.total
  });
  Map<String,dynamic> toJson() => {
    'id': id,
    'customerName': customerName,
    'customerPhone': customerPhone,
    'date': date.toIso8601String(),
    'items': items.map((e)=>e.toJson()).toList(),
    'total': total
  };
  static Invoice fromJson(Map<String,dynamic> j) => Invoice(
    id: j['id'],
    customerName: j['customerName'],
    customerPhone: j['customerPhone'],
    date: DateTime.parse(j['date']),
    items: (j['items'] as List).map((e)=>InvoiceItem.fromJson(e)).toList(),
    total: (j['total'] as num).toDouble()
  );
  String toJsonString() => json.encode(toJson());
}
