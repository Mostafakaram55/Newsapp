

import 'package:flutter/material.dart';

void navigateTo(BuildContext context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
      builder:(  context)=>widget,
  ),
);