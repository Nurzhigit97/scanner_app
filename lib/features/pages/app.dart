import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/features/pages/barcode_scan_page/barcode_scanner_page.dart';
import 'package:scanner_app/features/pages/history_scanners_page.dart';
import 'package:scanner_app/features/cubits/product_cubit.dart';
import 'package:scanner_app/shared/widgets/bottom_nav_bar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductCubit()..loadProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'Barcode Scanner App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const BottomNavigationBarWidget(),
          '/scan': (context) => const BarcodeScanner(),
          '/history': (context) => const HistoryScanPage(),
        },
      ),
    );
  }
}
