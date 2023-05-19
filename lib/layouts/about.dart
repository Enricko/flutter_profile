import "package:flutter/material.dart";
import "package:responsive_ui/responsive_ui.dart";

class AboutProfile extends StatefulWidget {
  const AboutProfile({super.key});

  @override
  State<AboutProfile> createState() => _AboutProfileState();
}

class _AboutProfileState extends State<AboutProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints(
        minHeight: 500,
      ),
      margin: const EdgeInsets.symmetric(vertical: 50,horizontal: 50),
      child: Column(
        children: [
          Responsive(
            children: [
              Div(
                divison: Division(
                  colXL: 3,
                  colL: 3, 
                  colM: 4, 
                  colS: 5, 
                  colXS: 5, 
                ),
                child: Container(
                  child: Image.asset(
                    'question.png',
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Div(
                divison: Division(
                  colXL: 9,
                  colL: 9, 
                  colM: 8, 
                  colS: 7, 
                  colXS: 7, 
                ),
                child: Column(
                  children: [
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                      ),
                    ),
                    Text(
                      "     Hi There, my name is Enricko Putra Hartono."
                      " I just graduated from SMK 1 BANTUL as Software Engineer."
                      " I'm currently still studying as Software Enginner and"
                      " I focused studying on Flutter Multi-Platform Developer."
                      " especially at back-end developer. ",
                      style: TextStyle(
                        fontSize: screenWidth <= 375 ? 12 : screenWidth <= 598 ? 16 : 18,
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Responsive(
            children: [
              Div(
                divison: Division(
                  colXL: 9,
                  colL: 9, 
                  colM: 8, 
                  colS: 7, 
                  colXS: 7, 
                ),
                child: Column(
                  children: [
                  Text(
                    "My Skills",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    "     I have advance skills in Web Developing such as HTML and CSS,Bootstrap for styling, and also has experience "
                    "PHP framework such as CI3(CodeIgniter 3) and Laravel. I'm using SQL based databased like MySql. "
                    "and I have not advance or basic in Multi-Platform APPS Developing with using Flutter framework and Firebase as Databases. "
                    "I'm able to work in team and managing code using GIT.",
                    style: TextStyle(
                      fontSize: screenWidth <= 375 ? 12 : screenWidth <= 598 ? 16 : 18,
                      color: Colors.white
                    ),
                  ),

                  ],
                ),
              ),
              Div(
                divison: Division(
                  colXL: 3,
                  colL: 3, 
                  colM: 4, 
                  colS: 5, 
                  colXS: 5, 
                ),
                child: Container(
                  child: Image.asset(
                    'work.png',
                    width: 100,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}