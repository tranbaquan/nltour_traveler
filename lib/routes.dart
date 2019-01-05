import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/change_pass_page.dart';
import 'package:nltour_traveler/ui/forgot_page.dart';
import 'package:nltour_traveler/ui/home_page.dart';
import 'package:nltour_traveler/ui/login_page.dart';
import 'package:nltour_traveler/ui/register_page.dart';

final routes = {
  '/': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/forgot': (BuildContext context) => new ForgotPage(),
  '/changepass': (BuildContext context) => new ChangePassPage(),
};
