import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsiveness/notifiers/email_change_notifier.dart';

import 'widgets/email_big_layout.dart';
import 'widgets/email_small_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      title: 'Responsiveness',
      home: ChangeNotifierProvider(
          create: (_) => EmailChangeNotifier(), child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<EmailChangeNotifier>(
                builder: (context, value, child) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      var bigScreen = constraints.maxWidth > 600;
                      if (bigScreen) {
                        return EmailBigLayout(
                          constraints: constraints,
                        );
                      }
                      return const EmailSmallLayout();
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
