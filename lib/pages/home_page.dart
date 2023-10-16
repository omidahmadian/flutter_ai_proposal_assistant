import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _generatedProposal = "";

  final _myController = TextEditingController();
  final _apikeyController = TextEditingController();

  Future<void> _generateProposal() async {
    var urlString = 'https://api.openai.com/v1/chat/completions';
    var url = Uri.parse(urlString);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${_apikeyController.text}',
    };
    var body = json.encode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {
          'role': 'system',
          'content':
              'Act as a freelancer. write a winning proposal for job details posted'
        },
        {'role': 'user', 'content': _myController.text}
      ],
    });

    setState(() {
      _generatedProposal = 'Networking';
    });

    final response = await http.post(url, headers: headers, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    setState(() {
      _generatedProposal = response.body;
    });
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _apikeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter apikey here',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: _myController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a search term',
                ),
              ),
            ),
            Text(
              _generatedProposal,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              child: const Text('Generate Proposal'),
              onPressed: () async {
                await _generateProposal();
              },
            ),
          ],
        ),
      ),
    );
  }
}
