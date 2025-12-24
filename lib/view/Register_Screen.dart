import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:silverstar_mobile/background.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final authService = AuthService();
final TextEditingController usernameController = TextEditingController();
final TextEditingController fullNameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController birthDateController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();

String selectedGender = '';

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  Future<void> _onPressedRegister(
    String username,
    String fullName,
    String password,
    String confirmPassword,
    String email,
    String birthDate,
    String gender,
    String phoneNumber,
  ) async {
    if (username.trim().isEmpty ||
        fullName.trim().isEmpty ||
        password.trim().isEmpty ||
        confirmPassword.trim().isEmpty ||
        email.trim().isEmpty ||
        birthDate.trim().isEmpty ||
        gender.trim().isEmpty) {
      _showErrorDialog(
        title: "ERROR!",
        message: "Please Check again your input",
      );
      return;
    } else {
      try {
        final register = await authService.registerUser(
          address: '-',
          dateOfBirth: birthDate,
          email: email,
          gender: gender,
          password: password,
          phoneNumber: phoneNumber,
          username: username,
          fullName: fullName,
        );

        if (!mounted) return;

        if (register != null) {
          if (!mounted) return;

          showDialog(
            context: context,
            barrierDismissible: false, // user must tap OK
            builder: (_) => AlertDialog(
              title: const Text("Success"),
              content: const Text(
                "Your account has been registered successfully.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // close dialog
                    Navigator.of(context).pop(); // go back to previous screen
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;

        _showErrorDialog(
          title: "Failed To Register",
          message: "Please try again later",
        );
      }
    }
  }

  void _showErrorDialog({required String title, required String message}) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.transparent,
      ),
      body: SilkyMetallicBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Full Name",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Username",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "E-mail",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneNumberController,
                  obscureText: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Phone Number",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: birthDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Date of Birth",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      birthDateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Gender : '), GenderToggle()],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: obscureTextPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscureTextPassword = !obscureTextPassword;
                        setState(() {
                          obscureTextPassword;
                        });
                      },
                      icon: obscureTextPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Password",
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureTextConfirmPassword,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscureTextConfirmPassword =
                            !obscureTextConfirmPassword;
                        setState(() {
                          obscureTextConfirmPassword;
                        });
                      },
                      icon: obscureTextConfirmPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Re-type Password",
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: Colors.black26, width: 1),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      _onPressedRegister(
                        usernameController.text,
                        fullNameController.text,
                        passwordController.text,
                        confirmPasswordController.text,
                        emailController.text,
                        birthDateController.text,
                        selectedGender,
                        phoneNumberController.text,
                      );
                    },
                    child: const Text("Register"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum Gender { male, female, notSay }

class GenderToggle extends StatefulWidget {
  const GenderToggle({super.key});

  @override
  State<GenderToggle> createState() => _GenderToggleState();
}

class _GenderToggleState extends State<GenderToggle> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _genderButton("Male", Gender.male),
        const SizedBox(width: 8),
        _genderButton("Female", Gender.female),
        const SizedBox(width: 8),
        _genderButton("Rather not say", Gender.notSay),
      ],
    );
  }

  Widget _genderButton(String label, Gender value) {
    final bool isActive = _selectedGender == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = value;
            selectedGender = _selectedGender.toString();
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isActive ? Colors.black : Colors.grey),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
