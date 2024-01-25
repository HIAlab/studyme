import 'package:flutter/material.dart';
import 'package:studyme/ui/screens/settings.dart';

import 'history.dart';
import 'home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  late int _currentIndex;

  final List<String> _titles = ['Home', 'History', 'Settings'];

  final List<Function> _body = [() => const Home(), () => const History(), () => const Settings()];

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body[_currentIndex]()),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _titles[0],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.insert_chart),
              label: _titles[1],
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: _titles[2],
            )
          ]),
    );
  }
}
