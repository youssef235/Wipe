import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'ChatClient.dart';

class AdminChatScreen extends StatefulWidget {
  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final supabase = Supabase.instance.client;
  List<String> uniqueUserIds = [];

  @override
  void initState() {
    super.initState();
    fetchUniqueUserIds();
  }

  Future<void> fetchUniqueUserIds() async {
    try {
      final response = await supabase
          .from('messages')
          .select('sender') // احصل على جميع الـ user IDs
          .order('created_at', ascending: false);

      if (response is List && response.isNotEmpty) {
        final Set<String> idsSet =
        response.map((msg) => msg['sender'] as String).toSet();
        setState(() {
          uniqueUserIds = idsSet.toList();
        });
      }
    } catch (error) {
      print("Error fetching unique user IDs: $error");
    }
  }

  void openChat(String senderId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
            isAdmin: true, senderId: senderId), // تمرير isAdmin كـ true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Chat')),
      body: ListView.builder(
        itemCount: uniqueUserIds.length,
        itemBuilder: (context, index) {
          final id = uniqueUserIds[index];
          return ListTile(
            title: Text('Chat with User ID: $id'),
            onTap: () => openChat(id),
          );
        },
      ),
    );
  }
}
