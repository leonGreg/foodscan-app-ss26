import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/router/app_router.dart';
import 'package:food_scan/features/auth/presentation/pages/profile_page.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:food_scan/features/home/presentation/pages/home_page.dart';
import 'package:food_scan/features/scanner/presentation/bloc/scanner_bloc.dart';
import 'package:go_router/go_router.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      context.read<HomeBloc>().add(const ShowRecentScansEvent());
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      
      floatingActionButton: SizedBox(
        width: 68,
        height: 68,
        child: FloatingActionButton(
          onPressed: _openScanner,
          backgroundColor: const Color(AppColors.primaryGreen),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      bottomNavigationBar: BottomAppBar(
        color: isDark 
            ? const Color(AppColors.surfaceDark) 
            : const Color(AppColors.surfaceLight),
        
        shape: const SmoothSquareNotch(), 
        notchMargin: 12.0,
        
        clipBehavior: Clip.antiAlias,
        elevation: 24,
        shadowColor: Colors.black.withValues(alpha: 0.15),
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  selected: _selectedIndex == 0,
                  onTap: () => _selectPage(0),
                ),
              ),
              
              const SizedBox(width: 72), 
              
              Expanded(
                child: _BottomNavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  selected: _selectedIndex == 1,
                  onTap: () => _selectPage(1),
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

    final targetColor = selected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder<Color?>(
        tween: ColorTween(end: targetColor),
        duration: const Duration(milliseconds: 250),
        builder: (context, color, child) {
          return AnimatedScale(
            scale: selected ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
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
        },
      ),
    );
  }
}

class SmoothSquareNotch extends NotchedShape {
  const SmoothSquareNotch();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final double radius = 36.0;
    final double smoothing = 18.0;

    final Path path = Path();
    path.moveTo(host.left, host.top);
    
    path.lineTo(guest.left - smoothing, host.top);
    
    path.quadraticBezierTo(
      guest.left, host.top, 
      guest.left, host.top + smoothing,
    );
    
    path.lineTo(guest.left, guest.bottom - radius);
    
    path.quadraticBezierTo(
      guest.left, guest.bottom, 
      guest.left + radius, guest.bottom,
    );
    
    path.lineTo(guest.right - radius, guest.bottom);
    
    path.quadraticBezierTo(
      guest.right, guest.bottom, 
      guest.right, guest.bottom - radius,
    );
    
    path.lineTo(guest.right, host.top + smoothing);
    
    path.quadraticBezierTo(
      guest.right, host.top, 
      guest.right + smoothing, host.top,
    );
    
    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    path.close();

    return path;
  }
}