import 'package:flutter/material.dart';

AppBar myAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: Colors.brown.shade700.withOpacity(0.8),
    centerTitle: true,
  );
}
