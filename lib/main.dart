import 'package:flutter/material.dart';
import 'package:flutter_ai_proposal_assistant/pages/home_page.dart';



void main() {
  runApp(const ProposalApp());
}

class ProposalApp extends StatelessWidget {
  const ProposalApp({super.key});

  final String _appTitle = 'Upwork proposal writer assistant';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(title: _appTitle),
    );
  }
}
