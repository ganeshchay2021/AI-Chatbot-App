import 'dart:io';
import 'dart:typed_data';

import 'package:aigeminichatbot/Image%20Path/image_path.dart';
import 'package:aigeminichatbot/Text%20Style/text_style.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';


class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  final Gemini gemini = Gemini.instance;
  ChatUser currentUser =
      ChatUser(id: "0", firstName: "Ganesh", lastName: "Chaudhary");
  ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "AI Gemini",
      profileImage:
          "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png");
  List<ChatMessage> messages = [];
  final List<ChatUser> typingUser = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.only(left: width * 0.051),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(logo),
              ),
            ),
          ),
          elevation: 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI ChatBot",
                style: myTextStyle(
                  fontsize: height * 0.024,
                ),
              ),
              Row(
                children: [
                  Container(
                    height: height * 0.009,
                    width: width * 0.020,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                  SizedBox(
                    width: height * 0.0062,
                  ),
                  Text(
                    "Online",
                    style: myTextStyle(
                        color: Colors.green, fontsize: height * 0.014),
                  ),
                ],
              )
            ],
          )),
      body: DashChat(
        inputOptions: InputOptions(trailing: [
          IconButton(
              onPressed: () {
                sendMediaMessage();
              },
              icon: const Icon(
                Icons.image,
                color: Colors.green,
              ))
        ]),
        typingUsers: typingUser,
        currentUser: currentUser,
        onSend: sendMessage,
        messages: messages,
      ),
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      typingUser.add(geminiUser);
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gemini.streamGenerateContent(question, images: images).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
            typingUser.remove(geminiUser);
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        medias: [
          ChatMedia(url: file.path, fileName: "", type: MediaType.image)
        ],
      );
      sendMessage(chatMessage);
    }
  }
}
