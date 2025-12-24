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

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: fullnameController,
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
                      obscureTextConfirmPassword = !obscureTextConfirmPassword;
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
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender : '),
                  GenderToggle(),
                ],
              ),
            ],
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
