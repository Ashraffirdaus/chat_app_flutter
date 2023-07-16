
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page_auth/chat/chat.service.dart';
import 'package:login_page_auth/widget_page.dart/login_textfield.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId});
  final String receiverUserEmail;

  final String receiverUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebauseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    //only send message if there is something to send
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserId, _messageController.text);
      //clear the text controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(children: [
        //messages
        Expanded(
          child: _buildMessageList(),
        ),

        //user input
        _buildMessageInput()
      ]),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserId, _firebauseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text ('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs
          .map((document)=> _buildMessageItem(document)).toList()
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //align the messages to the right if the sender is the current user , otherwise to the left
    var alignment = (data['senderId'] == _firebauseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft);

    return Container(
      alignment: alignment,
      child: Column(
        children: [
          Text(
            data['senderEmail'],
          ),
          Text(
            data['message'],
          ),
        ],
      ),
    );
  }

  // build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //Textfield
        Expanded(
          child: MyTextField(
              textFieldText: 'Enter message',
              controller: _messageController,
              obsecureText: false),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.arrow_upward_rounded))
      ],
    );
  }
}
