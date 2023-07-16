import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChannelPage extends StatelessWidget {
  const ChannelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const StreamChannelHeader(
          // title: Text("Priyanshu Paliwal"),
          ),
      body: Column(
        children: const [
          Expanded(child: StreamMessageListView()),
          StreamMessageInput()
        ],
      ),
    );
  }
}
