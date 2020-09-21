import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFf74269);
const kSecondaryColor = Color(0xFF929794);

kReplaceRoute(widget, context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

kRoute(widget, context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
