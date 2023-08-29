import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/pages/barcode_scan_page/barcode_scanner_page.dart';
import 'package:scanner_app/features/pages/history_scanners_page.dart';
import 'package:scanner_app/shared/data/repos/product_provider.dart';
import 'package:scanner_app/shared/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Barcode Scanner App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const BottomNavigationBarWidget(),
          '/scan': (context) => const BarcodeScanner(),
          // '/history': (context) => const HistoryScanPage(),
        },
      ),
    );
  }
}
