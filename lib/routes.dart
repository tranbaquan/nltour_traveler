import 'package:flutter/material.dart';
import 'package:nltour_traveler/ui/change_pass_page.dart';
import 'package:nltour_traveler/ui/forgot_page.dart';
import 'package:nltour_traveler/ui/histoy_page.dart';
import 'package:nltour_traveler/ui/home_page.dart';
import 'package:nltour_traveler/ui/info_page.dart';
import 'package:nltour_traveler/ui/login_page.dart';
import 'package:nltour_traveler/ui/mesage_page.dart';
import 'package:nltour_traveler/ui/payment_page.dart';
import 'package:nltour_traveler/ui/place_page.dart';
import 'package:nltour_traveler/ui/register_page.dart';

final routes = {
  '/': (BuildContext context) => new LoginPage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/forgot': (BuildContext context) => new ForgotPage(),
  '/changepass': (BuildContext context) => new ChangePassPage(),
  '/place': (BuildContext context) => new PlacePage(),
  '/payment': (BuildContext context) => new PaymentPage(),
  '/history': (BuildContext context) => new HistoryPage(),
  '/info': (BuildContext context) => new InformationPage(),
  '/message': (BuildContext context) => new MessagePage(),
};
