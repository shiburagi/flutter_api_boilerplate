
import 'package:flutter/material.dart';

class NavigatorHelper {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}