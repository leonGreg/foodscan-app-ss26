import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/router/app_router.dart';
import 'package:food_scan/features/auth/presentation/pages/profile_page.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/pages/home_page.dart';
import 'package:food_scan/features/scanner/presentation/bloc/scanner_bloc.dart';
import 'package:food_scan/features/search/presentation/pages/search_page.dart';
import 'package:go_router/go_router.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [HomePage(), SearchPage(), ProfilePage()];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      context.read<HomeBloc>().add(const ShowRecentScansEvent());
    }

    if (index == 1) {
      context.read<HomeBloc>().add(const ShowSearchResultsEvent());
    }
  }

  Future<void> _openScanner() async {
    final scannerBloc = context.read<ScannerBloc>();
    final router = GoRouter.of(context);

    final result = await router.push(AppRouter.scanner);

    if (result != null && result is String) {
      await router.pushNamed('details', pathParameters: {'barcode': result});

      scannerBloc.add(const ScannerResetEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 82,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: _selectedIndex == 0,
                  onTap: () => _selectPage(0),
                ),
              ),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.search_rounded,
                  label: 'Search',
                  selected: _selectedIndex == 1,
                  onTap: () => _selectPage(1),
                ),
              ),
              Expanded(child: _ScanNavItem(onTap: _openScanner)),
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  selected: _selectedIndex == 2,
                  onTap: () => _selectPage(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = const Color(AppColors.primaryGreen);
    final unselectedColor =
        Theme.of(context).iconTheme.color?.withValues(alpha: 0.55) ??
        Colors.grey;

    final color = selected ? selectedColor : unselectedColor;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanNavItem extends StatelessWidget {
  final VoidCallback onTap;

  const _ScanNavItem({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(AppColors.primaryGreen),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(
                    AppColors.primaryGreen,
                  ).withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.qr_code_scanner_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Scan',
            style: TextStyle(
              color: Color(AppColors.primaryGreen),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
