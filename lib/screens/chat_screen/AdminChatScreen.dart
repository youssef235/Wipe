import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taxi_booking/utils/Extensions/theme_helper.dart';

import '../../aWidgets/upper_app_bar.dart';
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
backgroundColor: appTheme.primary,
      body: SafeArea(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomRowWidget(),
            ),
            Expanded( // استخدام Expanded لتمكين ListView من أخذ المساحة المتبقية
              child: ListView.builder(
                itemCount: uniqueUserIds.length,
                itemBuilder: (context, index) {
                  final id = uniqueUserIds[index];
                  return Card(
                    color: appTheme.secondry,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5, // تأثير الظل
                    child: ListTile(

                      contentPadding: EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        child: Text(id[0].toUpperCase() , style: TextStyle(fontSize: 15),),

                        backgroundColor: appTheme.primary,
                        foregroundColor: Colors.white,

                      ),
                      title: Text(
                        'Chat with User ID: $id',
                        style: TextStyle(
                          color: appTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        'Click to start a chat',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => openChat(id),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
