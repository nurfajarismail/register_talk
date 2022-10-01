import 'package:flutter/material.dart';
import 'package:register_talk/home_screen.dart';
import 'package:register_talk/register_screen.dart';
import 'package:register_talk/res_login.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerPassword = TextEditingController();

  TextEditingController controllerEmail = TextEditingController();

  bool isLoading = false;

  final _key = GlobalKey<FormState>();
  Future<ResLogin?> loginUsers() async {
    try {
      setState(() {
        isLoading = true;
      });

      var res = await http.post(
          Uri.parse("http://192.168.1.13:8085/codingtalk_register/login.php"),
          body: {
            "email": controllerEmail.text,
            "password": controllerPassword.text
          });
      ResLogin data = resLoginFromJson(res.body);
      print(data.value);
      print(res.body);

      if (data.value == 1) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else if (data.value == 0) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(data.message ?? "")));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Container(
                  height: 150,
                  child: const Text(
                    "Login \nScreen",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Container(
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
                          controller: controllerEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Email"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: controllerPassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Password"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                loginUsers();
                              }
                            },
                            child: Container(
                                width: double.infinity,
                                child: Center(child: Text("Log In")))),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegisterScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Belum mempunyai akun? "),
                              Text(
                                "Register",
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
