import 'package:aigeminichatbot/Image%20Path/image_path.dart';
import 'package:aigeminichatbot/Text%20Style/text_style.dart';
import 'package:aigeminichatbot/pages/onboard%20screen/widget/custom_button.dart';
import 'package:flutter/material.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.051,
          ),
          Column(
            children: [
              //This is AI Adviced text part
              Column(
                children: [
                  //Heading text
                  Text(
                    "Your AI Assistant",
                    style: myTextStyle(
                        fontsize: height * 0.031, color: Colors.blue),
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  //sub-heading text
                  Column(
                    children: [
                      Text(
                        "Using this software you can ask you questions",
                        style: myTextStyle(
                            fontsize: height * 0.015, color: Colors.grey),
                      ),
                      Text(
                        "and receive articles using",
                        style: myTextStyle(
                            fontsize: height * 0.015, color: Colors.grey),
                      ),
                      Text(
                        "artificial intelligence assistant",
                        style: myTextStyle(
                            fontsize: height * 0.015, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),

          SizedBox(
            height: height * 0.051,
          ),

          //This is is onBoard Image Part
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            height: height * 0.4,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(onboardImage),
              ),
            ),
          ),

          const Spacer(),

          //This is continue button
          CustomButton(width: width, height: height),

          SizedBox(
            height: height * 0.015,
          ),
        ],
      ),
    );
  }
}
