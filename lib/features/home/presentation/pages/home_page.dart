import 'package:flutter/material.dart';
import 'package:quant_ai/features/market/presentation/pages/market_page.dart';
import 'package:quant_ai/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:quant_ai/features/chat/presentation/pages/chat_page.dart';

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
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.show_chart), label: 'Market'),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Portfolio',
          ),
          NavigationDestination(icon: Icon(Icons.psychology), label: 'Advisor'),
        ],
      ),
    );
  }
}
