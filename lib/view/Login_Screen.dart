import 'package:flutter/material.dart';
import 'package:silverstar_mobile/view/Home_Screen.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//Function for login
void _onPressedLogin(String username, String password, BuildContext context){
  if(username.isEmpty || password.isEmpty){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ERROR!"),
          content: const Text("Username or Password cannot be empty"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    return;
  }

  if(username == "Admin" && password == "Admin"){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  }
  else{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Failed To Login"),
          content: const Text("Username or Password is Wrong, please try again"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsetsGeometry.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                const SizedBox(height: 12),
                TextField(
                  controller: usernameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Username",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Password",
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                          color: Colors.black26,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      _onPressedLogin(usernameController.text, passwordController.text, context);
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    print("Forgot Password clicked");
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "Click Here",
                        style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("Click Here clicked");
                            // Navigator.push(...)
                          },
                      ),
                    ],
                  ),
                )
              ],
          ),
        ),
      )
    );
  }
}
