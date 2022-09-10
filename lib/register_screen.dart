import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:register_talk/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegExp validatonFull = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double kekuatanPassword = 0;
  TextEditingController password = TextEditingController();

  RegExp huruf = RegExp(r"(?=.*[a-z])(?=.*[A-Z])");
  RegExp angka = RegExp(r"[0-9]");
  bool minimal8huruf = false;
  bool hurufBesarKecil = false;
  bool minimal1Angka = false;

  bool validatePassword(String pass) {
    if (password.text.isEmpty) {
      setState(() {
        kekuatanPassword = 0;
      });
    } else if (password.text.length < 8) {
      setState(() {
        kekuatanPassword = 1 / 4;
      });
    } else if (password.text.length < 10) {
      setState(() {
        kekuatanPassword = 2 / 4;
      });
    } else if (password.text.length < 12) {
      setState(() {
        kekuatanPassword = 3 / 4;
      });
    } else if (validatonFull.hasMatch(password.text)) {
      setState(() {
        kekuatanPassword = 4 / 4;
      });
      return true;
    }
    return false;
  }

  void validateRequirement() {
//password minimal 8 karakter

    if (password.text.length >= 8) {
      minimal8huruf = true;
    } else {
      minimal8huruf = false;
    }

    // huruf besar kecil
    if (password.text.contains(huruf)) {
      hurufBesarKecil = true;
    } else {
      hurufBesarKecil = false;
    }
    //
    if (password.text.contains(angka)) {
      minimal1Angka = true;
    } else {
      minimal1Angka = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Container(
                  height: 150,
                  child: const Text(
                    "Register \nScreen",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Name"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Email"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Password"),
                        onChanged: (value) {
                          validatePassword(value);
                          validateRequirement();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(
                          value: kekuatanPassword,
                          minHeight: 10,
                          backgroundColor: Colors.grey,
                          color: kekuatanPassword <= 1 / 4
                              ? Colors.red
                              : kekuatanPassword == 2 / 4
                                  ? Colors.yellow
                                  : kekuatanPassword == 3 / 4
                                      ? Colors.blue
                                      : kekuatanPassword == 4 / 4
                                          ? Colors.green
                                          : null),
                      Row(
                        children: [
                          minimal8huruf
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Panjang Minimal 8 Karakter",
                            style: TextStyle(
                                color:
                                    minimal8huruf ? Colors.green : Colors.red),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          hurufBesarKecil
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Huruf besar dan kecil",
                            style: TextStyle(
                                color: hurufBesarKecil
                                    ? Colors.green
                                    : Colors.red),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          minimal1Angka
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                          Text(
                            "Minimal 1 Angka",
                            style: TextStyle(
                                color:
                                    minimal1Angka ? Colors.green : Colors.red),
                          )
                        ],
                      ),
                      ElevatedButton(
                          onPressed:
                              minimal8huruf && hurufBesarKecil && minimal1Angka
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginScreen()));
                                    }
                                  : null,
                          child: Container(
                              width: double.infinity,
                              child: Center(child: Text("Register")))),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sudah mempunyai akun? "),
                            Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
