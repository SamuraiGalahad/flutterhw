import 'package:flutter/material.dart';
import 'package:hw1/src/newsapp/theme/theme_provider.dart';

import 'src/app/app.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: App())
);
