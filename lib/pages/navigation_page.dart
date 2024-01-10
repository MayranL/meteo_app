import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:meteo_app/pages/other_weather_page.dart';
import 'package:meteo_app/pages/settings_page.dart';
import 'package:meteo_app/pages/weather_page.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 1;
  PageController _pageController = PageController(initialPage: 1);

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          //TODO : Add features for this page with future weather and textfield to search other city
          OtherWeatherPage(),
          WeatherPage(),
          //TODO: Add slide page for settings : dark/light mode, informations/details, notifications ?
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        backgroundColor: Colors.transparent,
        color: Theme.of(context).colorScheme.inversePrimary,
        animationDuration: Duration(milliseconds: 300),
        onTap: _onItemTapped,
        items: const [
          Icon(
            Icons.calendar_month,
            color: Colors.black,
          ),
          Icon(
            Icons.home,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
