import 'package:flutter/material.dart';
import 'package:quant_ai/core/widgets/custom_bottom_nav.dart';
import 'package:quant_ai/features/chat/presentation/pages/chat_page.dart';
import 'package:quant_ai/features/market/presentation/pages/market_page.dart';
import 'package:quant_ai/features/portfolio/presentation/pages/portfolio_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const MarketPage(),
    const PortfolioPage(),
    const ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Important for floating nav bar
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
