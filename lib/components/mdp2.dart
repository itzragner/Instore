import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/components/mdp3.dart';
import 'package:instore/services/auth.dart';
import 'package:instore/widgets/codeBox.dart';
// import 'package:get/get.dart';

// import 'package:google_fonts/google_fonts.dart';

// import 'package:saverapp/Services/auth.dart';

// import '../widget/codeBox.dart';
// import '../widget/rounded_button.dart';

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  List<FocusNode> focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;

    final List verifCodeList = ["", "", "", ""];
    verifCode() async {
      var code = verifCodeList.join("");
      if (code.isEmpty) {
        Get.snackbar(
          backgroundColor: const Color.fromRGBO(243, 75, 63, 0.644),
          "error",
          "please fill the code area",
        );
      } else {
        var response = await AuthService.sendVerifCode(code);
        if (response["response"]?["status"] == 200) {
          Get.snackbar(
              backgroundColor: Colors.white,
              "success",
              response["response"]["message"],
              colorText: Colors.green.shade800);
          Get.to(ChangePassword(), arguments: email);
          // print(response["response"]["message"]);
        } else {
          Get.snackbar(
              backgroundColor: Colors.red,
              "error",
              "Error, please try again",
              colorText: Colors.white);
        }
      }
    }

    // print(controller.email);
    List<CodeBox> codeBoxes = List.generate(
      4,
      (index) => CodeBox(
        key: Key(index.toString()),
        moveCount: index,
        focusNode: focusNodes[index],
        onTextChanged: (text) {
          verifCodeList[index] = text;
          if (text.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
    return SizedBox(
      height: 2000,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFffebf7),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.grey,
          ),
          actions: [],
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // )
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Verification CODE",
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                const Text(
                  "Enter the verification code sent at your email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: codeBoxes,
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  elevation: 5,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFFFA058C),
                  onPressed: () {
                        verifCode();
                  },
                  minWidth: 290,
                  height: 45,
                  child: Text(
                    'Envoyer Code',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Resend email ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
