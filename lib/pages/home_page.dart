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

  // impelement a function to copy _generatedProposal value to clipboard
  void copyToClipboard() {
    // implement copy to clipboard code
    
  }

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  Widget _getLeftColumn(context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.amberAccent,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Enter your job post here',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                controller: _myController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a search term',
                ),
              ),
            ),
          ),
          IconButton(onPressed:()=>{copyToClipboard()} ,icon: const Icon(Icons.copy),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(
                  _generatedProposal,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              child: const Text(
                'Generate Proposal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                await _generateProposal();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRightColumn(context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.greenAccent,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                TextField(
                  controller: _apikeyController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter apikey here',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              child: const Text('Save Settings'),
              onPressed: () async {
                await _generateProposal();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          _getLeftColumn(context),
          _getRightColumn(context),
        ],
      ),
    );
  }
}
