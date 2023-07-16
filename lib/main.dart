import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream_chat_application/channelpage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_list_page.dart';

const apiKey = "ggr2qmcw4f3k";
// const userToken =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoid2lzcHktbWF0aC0xIn0.3L0bNkL3yp52jCJyAk8i7MAetsPSpm6QybpsnT7bgHk";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );
  var sharedPreferences = await SharedPreferences.getInstance();
  String userId = sharedPreferences.getString("userId") ?? const Uuid().v4();
  if (sharedPreferences.getString("userId") == null) {
    await sharedPreferences.setString("userId", userId);
  }

  String userToken = client.devToken(userId).rawValue;

  await client.connectUser(User(id: userId), userToken);

  final channel = client.channel('messaging', id: "flutterStreamChat");
  await channel.create();
  await channel.watch();

  runApp(MyApp(
    streamChatClient: client,
    channel: channel,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.streamChatClient, required this.channel});

  final StreamChatClient streamChatClient;
  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stream Chat Application',
      theme: ThemeData(primaryColor: Colors.blue),
      builder: (context, widget) {
        return StreamChat(
          client: streamChatClient,
          child: widget,
        );
      },
      home: StreamChannel(
        channel: channel,
        child: const ChannelPage(),
      ),
    );
  }
}
