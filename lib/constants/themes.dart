import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: const TextStyle(color: Colors.red),
        foregroundColor: Colors.red,
        side: const BorderSide(color: Colors.red, width: 1.7),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        border: outlineInputBorder,
        errorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 18),
          disabledBackgroundColor: Colors.grey),
    ),
    primarySwatch: Colors.red,
    canvasColor: Colors.red,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black)));

OutlineInputBorder outlineInputBorder =
    const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey));
