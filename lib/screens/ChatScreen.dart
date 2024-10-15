// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import 'chat_screen/ChatClient.dart';
//
// class AdminChatScreen extends StatefulWidget {
//   @override
//   _AdminChatScreenState createState() => _AdminChatScreenState();
// }
//
// class _AdminChatScreenState extends State<AdminChatScreen> {
//   final supabase = Supabase.instance.client;
//   List<String> uniqueIps = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUniqueIps();
//   }
//
//   Future<void> fetchUniqueIps() async {
//     try {
//       final response = await supabase
//           .from('messages')
//           .select('sender') // احصل على جميع الـ IPs
//           .order('created_at', ascending: false);
//
//       if (response is List && response.isNotEmpty) {
//         final Set<String> ipsSet =
//             response.map((msg) => msg['sender'] as String).toSet();
//         setState(() {
//           uniqueIps = ipsSet.toList();
//         });
//       }
//     } catch (error) {
//       print("Error fetching unique IPs: $error");
//     }
//   }
//
//   void openChat(String senderIp) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//             isAdmin: true, senderIp: senderIp), // تمرير isAdmin كـ true
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Admin Chat')),
//       body: ListView.builder(
//         itemCount: uniqueIps.length,
//         itemBuilder: (context, index) {
//           final ip = uniqueIps[index];
//           return ListTile(
//             title: Text('Chat with IP: $ip'),
//             onTap: () => openChat(ip),
//           );
//         },
//       ),
//     );
//   }
// }
