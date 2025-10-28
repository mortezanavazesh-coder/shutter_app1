// lib/roll_calc.dart
import 'package:flutter/material.dart';
import 'dart:math';

class RollCalcScreen extends StatefulWidget {
  const RollCalcScreen({super.key});

  @override
  State<RollCalcScreen> createState() => _RollCalcScreenState();
}

class _RollCalcScreenState extends State<RollCalcScreen> {
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController shaftCtrl = TextEditingController();
  final TextEditingController thicknessCtrl = TextEditingController();

  double? result;

  void calculate() {
    final h = double.tryParse(heightCtrl.text.replaceAll(',', '.')) ?? 0.0;
    final d = double.tryParse(shaftCtrl.text.replaceAll(',', '.')) ?? 0.0;
    final t = double.tryParse(thicknessCtrl.text.replaceAll(',', '.')) ?? 0.0;

    if (h <= 0 || d <= 0 || t <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لطفاً همه مقادیر را وارد کنید')));
      return;
    }

    final D = sqrt(pow(d, 2) + (15.9 * h * t) / pi);
    setState(() { result = D; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محاسبه قطر رول')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            TextField(controller: heightCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'ارتفاع (cm)')),
            const SizedBox(height: 8),
            TextField(controller: shaftCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'قطر شفت (cm)')),
            const SizedBox(height: 8),
            TextField(controller: thicknessCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'ضخامت تیغه (cm)')),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: calculate, child: const Text('محاسبه')),
            const SizedBox(height: 16),
            if (result != null)
              Text('قطر رول ≈ ${result!.toStringAsFixed(1)} cm', style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
