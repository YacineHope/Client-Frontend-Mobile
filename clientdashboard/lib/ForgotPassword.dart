import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? _selectedTool; // To store the selected tool
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Forgot your password?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter the tool that helps you reset your password:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown menu
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Choose a tool",
                border: OutlineInputBorder(),
              ),
              value: _selectedTool,
              items: const [
                DropdownMenuItem(
                  value: "Phone",
                  child: Text("Phone number"),
                ),
                DropdownMenuItem(
                  value: "Email",
                  child: Text("Email"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTool = value;
                });
              },
            ),
            const SizedBox(height: 20),
            // Conditional input field
            if (_selectedTool == "Phone")
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone number",
                  border: OutlineInputBorder(),
                ),
              ),
            if (_selectedTool == "Email")
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 30),
            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle reset password logic
                  if (_selectedTool == "Phone") {
                    print("Phone number: ${_phoneController.text}");
                  } else if (_selectedTool == "Email") {
                    print("Email: ${_emailController.text}");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
