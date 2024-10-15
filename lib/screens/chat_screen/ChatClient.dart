import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../aWidgets/upper_app_bar.dart';
import '../../components/drawer_component.dart';
import '../../utils/Constants.dart';
import '../../utils/Extensions/theme_helper.dart';

class ChatScreen extends StatefulWidget {
  final bool isAdmin; // لتحديد ما إذا كان المستخدم هو المدير أم العميل
  final String? senderId; // لإضافة user ID إذا كان المدير

  ChatScreen({required this.isAdmin, this.senderId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final supabase = Supabase.instance.client;
  String? userId; // تغيير userIp إلى userId
  List<dynamic> messages = [];
  bool isLoading = true; // متغير لحالة التحميل

  @override
  void initState() {
    super.initState();
    getUserId().then((id) {
      userId = id;
      fetchMessages();
    });
  }

  Future<String?> getUserId() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getInt(USER_ID).toString(); // استرجاع user ID من SharedPreferences
  }

  Future<void> fetchMessages() async {
    try {
      setState(() {
        isLoading = true; // بدء التحميل
      });

      final clientMessagesResponse = await supabase
          .from('messages')
          .select()
          .eq('sender', userId!) // استخدم userId هنا
          .order('created_at', ascending: true);

      final adminMessagesResponse = await supabase
          .from('messages')
          .select()
          .eq('reply_to', userId!) // استخدم userId هنا
          .order('created_at', ascending: true);

      if (clientMessagesResponse.isNotEmpty) {
        messages.addAll(clientMessagesResponse);
      }
      if (adminMessagesResponse.isNotEmpty) {
        messages.addAll(adminMessagesResponse);
      }

      messages.sort((a, b) => DateTime.parse(a['created_at'])
          .compareTo(DateTime.parse(b['created_at'])));

      setState(() {
        isLoading = false; // انتهاء التحميل
      });
    } catch (error) {
      setState(() {
        isLoading = false; // انتهاء التحميل في حال حدوث خطأ
      });
      print("Error fetching messages: $error");
    }
  }

  void sendMessage(String message) async {
    if (userId != null) {
      try {
        final newMessage = {
          'text': message,
          'sender': widget.isAdmin ? 'admin' : userId!, // استخدم userId هنا
          'reply_to': widget.isAdmin ? widget.senderId : null,
        };

        await supabase.from('messages').insert(newMessage);
        setState(() {
          messages.add(newMessage);
          _controller.clear();
        });
      } catch (error) {
        print("Error sending message: $error");
      }
    } else {
      print("Failed to get user ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.primary,
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomRowWidget(),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              reverse: true,
              child: Column(
                children: messages.map((message) {
                  bool isMe = (!widget.isAdmin &&
                      message['sender'] == userId) ||
                      (widget.isAdmin && message['sender'] == 'admin');

                  return Container(
                    margin:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        if (isMe)
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://www.w3schools.com/w3images/avatar3.png'),
                          ),
                        SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        if (!isMe) SizedBox(width: 10),
                        if (!isMe)
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'https://www.w3schools.com/w3images/avatar2.png'),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 10), // هذا السطر يرفع حقل النص قليلاً عن الأسفل

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                IconButton(
                  icon: Transform.rotate(
                    angle: 180 * 3.14159 / 180, // 180 degrees in radians
                    child: Icon(Icons.send),
                  ),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(
                      color: Colors.black, // لون النص
                      fontSize: 14, // حجم الخط
                    ),
                    decoration: InputDecoration(
                      hintText: 'أكـتب رسالـة',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      filled: true, // لجعل الخلفية ملونة
                      fillColor: Colors.grey[200], // لون الخلفية
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: appTheme.secondry, // لون البوردر
                          width: 1, // عرض البوردر
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: // لون البوردر عند التركيز
                          Colors.blueAccent,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: appTheme.secondry,
                          width: 2,
                        ),
                      ),
                    ),
                    onSubmitted: (text) {
                      if (text.isNotEmpty) {
                        sendMessage(text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5), // هذا السطر يرفع حقل النص قليلاً عن الأسفل
        ],
      ),
    );
  }
}
