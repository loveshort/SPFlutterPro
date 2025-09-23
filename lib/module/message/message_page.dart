/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-23 16:57:44
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-23 17:06:11
 * @FilePath: /SPFlutterPro/lib/module/message/message_page.dart
 * @Description: 消息
 */
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
      ),
      body: Center(
        child: Text('消息'),
      ),
    );
  }
}
