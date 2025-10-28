// lib/invoice_view.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'utils.dart';

class InvoiceViewScreen extends StatelessWidget {
  final Invoice invoice;
  const InvoiceViewScreen({super.key, required this.invoice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('فاکتور ${invoice.id}')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('فروشنده: نوازش', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('تلفن: 09168413916'),
          const SizedBox(height:12),
          Text('مشتری: ${invoice.customerName} — ${invoice.customerPhone}'),
          Text('تاریخ: ${shortDate(invoice.date)}'),
          const SizedBox(height:12),
          Expanded(child: ListView(children: invoice.items.map((it)=>
            ListTile(title: Text(it.title), subtitle: Text('${it.quantity}'), trailing: Text('${formatCurrency(it.total)} تومان'))
          ).toList())),
          const SizedBox(height:8),
          Text('جمع کل: ${formatCurrency(invoice.total)} تومان', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height:12),
          ElevatedButton(onPressed: () {
            // placeholder: in full app implement PDF generation or share
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('قابلیت صادر کردن PDF در نسخه پرو فعال می‌شود')));
          }, child: const Text('ذخیره/اشتراک فاکتور'))
        ]),
      ),
    );
  }
}
