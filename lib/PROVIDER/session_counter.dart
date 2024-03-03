import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionCounterProvider extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  SessionCounterProvider() {
    // Initialize counter value from SharedPreferences
    _loadCounter();
  }

  // Load counter value from SharedPreferences
  Future<void> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('counter') ?? 0;
    notifyListeners();
  }

  // Increment counter value by one
  void incrementCounter() async {
    _counter++;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
    notifyListeners();
  }

  // Reset counter value to zero
  void resetCounter() async {
    _counter = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
    notifyListeners();
  }
}
