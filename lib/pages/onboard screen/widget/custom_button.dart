// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:aigeminichatbot/Text%20Style/text_style.dart';
import 'package:aigeminichatbot/pages/gemini%20home%20page/gemini_chat_bot.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * 0.0622,
      padding: EdgeInsets.symmetric(horizontal: width * 0.076),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GeminiChatBot(),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Continue",
                  style: myTextStyle(
                      fontsize: height * 0.021, color: Colors.white),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              size: width * 0.063,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
