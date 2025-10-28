// lib/settings.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController sellerCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  bool minInstallEnabled = true;
  bool roundThousands = false;

  static const _keySeller = 'seller_name';
  static const _keyPhone = 'seller_phone';
  static const _keyMinInstall = 'enable_min_install';
  static const _keyRound = 'round_thousands';

  @override
  void initState() {
    super.initState();
    _load();
  }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    sellerCtrl.text = p.getString(_keySeller) ?? 'نوازش';
    phoneCtrl.text = p.getString(_keyPhone) ?? '09168413916';
    minInstallEnabled = p.getBool(_keyMinInstall) ?? true;
    roundThousands = p.getBool(_keyRound) ?? false;
    setState((){});
  }
  Future<void> _save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_keySeller, sellerCtrl.text);
    await p.setString(_keyPhone, phoneCtrl.text);
    await p.setBool(_keyMinInstall, minInstallEnabled);
    await p.setBool(_keyRound, roundThousands);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تنظیمات ذخیره شد')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تنظیمات')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            TextFormField(controller: sellerCtrl, decoration: const InputDecoration(labelText: 'نام فروشنده')),
            const SizedBox(height:8),
            TextFormField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'تلفن فروشنده')),
            const SizedBox(height:12),
            SwitchListTile(
              title: const Text('حداقل نصب 10 متر فعال باشد'),
              value: minInstallEnabled,
              onChanged: (v){ setState(()=> minInstallEnabled = v); },
            ),
            SwitchListTile(
              title: const Text('گرد کردن به هزار تومان'),
              value: roundThousands,
              onChanged: (v){ setState(()=> roundThousands = v); },
            ),
            const SizedBox(height:12),
            ElevatedButton.icon(onPressed: _save, icon: const Icon(Icons.save), label: const Text('ذخیره تنظیمات'))
          ],
        ),
      ),
    );
  }
}
