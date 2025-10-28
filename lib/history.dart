// lib/history.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';
import 'dart:convert';
import 'utils.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Invoice> invoices = [];
  static const _key = 'shutter_invoices_v1';

  @override
  void initState() {
    super.initState();
    _load();
  }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    final s = p.getString(_key);
    if (s != null) {
      final list = json.decode(s) as List;
      invoices = list.map((e)=>Invoice.fromJson(e)).toList();
    }
    setState((){});
  }
  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    final jsonList = invoices.map((e)=>e.toJson()).toList();
    await p.setString(_key, json.encode(jsonList));
  }
  Future<void> _clear() async {
    invoices.clear();
    await _save();
    setState((){});
  }

  void _openInvoice(Invoice inv) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => InvoiceView(invoice: inv)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تاریخچه فاکتورها'), actions: [
        IconButton(icon: const Icon(Icons.delete_forever), onPressed: () async {
          final ok = await showDialog<bool>(context: context, builder: (_)=>AlertDialog(
            title: const Text('تأیید'),
            content: const Text('آیا می‌خواهید تمام فاکتورها حذف شوند؟'),
            actions: [TextButton(onPressed: ()=>Navigator.pop(context,false), child: const Text('خیر')), TextButton(onPressed: ()=>Navigator.pop(context,true), child: const Text('بله'))],
          ));
          if (ok==true) { await _clear(); }
        })
      ],),
      body: ListView.builder(
        itemCount: invoices.length,
        itemBuilder: (_,i){
          final inv = invoices[i];
          return ListTile(
            title: Text('فاکتور ${inv.id}'),
            subtitle: Text('${shortDate(inv.date)} — ${formatCurrency(inv.total)} تومان'),
            onTap: ()=> _openInvoice(inv),
          );
        }
      ),
    );
  }
}

// lightweight invoice viewer
class InvoiceView extends StatelessWidget {
  final Invoice invoice;
  const InvoiceView({super.key, required this.invoice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('فاکتور ${invoice.id}')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('مشتری: ${invoice.customerName} — ${invoice.customerPhone}'),
            Text('تاریخ: ${shortDate(invoice.date)}'),
            const SizedBox(height:8),
            Expanded(child: ListView(children: invoice.items.map((it)=>ListTile(
              title: Text(it.title),
              trailing: Text('${formatCurrency(it.total)} تومان'),
              subtitle: Text('${it.quantity} × ${formatCurrency(it.unitPrice)}'),
            )).toList())),
            const SizedBox(height:8),
            Text('جمع کل: ${formatCurrency(invoice.total)} تومان', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
