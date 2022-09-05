import 'package:blog/Components/shared.dart';
import 'package:blog/Screens/Sign_up.dart';
import 'package:blog/Services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

String btn = 'Create an account';
String accountStatus = 'Create an account';
int status = 0;
final newEmailController = TextEditingController();
final newPassController = TextEditingController();
final _formKey = GlobalKey<FormState>();
final _formKey2 = GlobalKey<FormState>();
final emailController = TextEditingController();
final passController = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Builder(builder: (context) {
            switch (status) {
              case 0:
                return Form(
                  key: _formKey,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height * 0.12,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign in',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffEAF6F6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              textfield(
                                  "Username",
                                  "username",
                                  false,
                                  TextInputType.name,
                                  Icons.person,
                                  emailController),
                              textfield(
                                  "Password",
                                  "Password",
                                  true,
                                  TextInputType.text,
                                  Icons.lock,
                                  passController),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xff0099c9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ) // foreground
                                      ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        context
                                            .read<authServices>()
                                            .signWithEmailAndPassword(
                                                '${emailController.text.trim()}@mail.com',
                                                passController.text.trim());
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.toString(),
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 5,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => const HomePage()),
                                    // );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                          'Login',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(Icons.login)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                status = 1;
                              });
                            },
                            child: Text(
                              "Dont have an account",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ))
                      ],
                    )),
                  ),
                );
              default:
                return signup();
            }
          }),
        ),
      ),
    );
  }

  Widget signup() {
    return Form(
      key: _formKey2,
      child: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height * 0.12,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register New account',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffEAF6F6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  textfield("Username", "username", false, TextInputType.name,
                      Icons.person, newEmailController),
                  textfield("Password", "Password", true, TextInputType.text,
                      Icons.lock, newPassController),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff0099c9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ) // foreground
                          ),
                      onPressed: () {
                        if (_formKey2.currentState!.validate()) {
                          try {
                            context
                                .read<authServices>()
                                .registerWithEmailAndPassword(
                                    '${newEmailController.text.trim()}@mail.com',
                                    newPassController.text.trim());
                          } catch (e) {
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const HomePage()),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.login)
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    status = 0;
                  });
                },
                child: Text(
                  "Already have an account",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
