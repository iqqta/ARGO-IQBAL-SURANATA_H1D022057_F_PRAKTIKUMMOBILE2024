import 'package:flutter/material.dart';
import 'package:health/bloc/login_bloc.dart';
import 'package:health/helpers/user_info.dart';
import 'package:health/ui/pemantauan_page.dart';
import 'package:health/ui/registrasi_page.dart';
import 'package:health/widget/warning_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontFamily: 'Calibri', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
        elevation: 5, // Add shadow effect
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF0E68C), // Light pastel yellow at the bottom
              const Color(0xFFE7F0F4), // Light pastel blue at the top
            ],
            begin: Alignment.bottomCenter, // Start from the bottom
            end: Alignment.topCenter, // Gradient moves to the top
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100), // Spacer for centering
                _logo(),
                const SizedBox(height: 20),
                _loginForm(), // Form is now within a card with better frame
                const SizedBox(height: 20),
                _buttonRegistrasiText(), // Text button for registration
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Menampilkan Logo
  Widget _logo() {
    return Column(
      children: [
        const Icon(
          Icons.health_and_safety,
          size: 80,
          color: Color(0xFFF0B0B0), // Pastel pink color
        ),
        const SizedBox(height: 10),
        const Text(
          "Snooze Right, Live Bright!",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Calibri',
            fontWeight: FontWeight.bold,
            color: Color(0xFFF0B0B0),
          ),
        ),
      ],
    );
  }

  // Form login yang diletakkan di dalam Card dengan frame yang diperbagus
  Widget _loginForm() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Sudut lebih halus untuk Card
        side: BorderSide(
          color: Colors.grey.shade300, // Border warna abu-abu terang
          width: 1.5, // Ukuran border lebih tebal
        ),
      ),
      elevation: 8, // Tambahkan shadow untuk efek depth
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding lebih besar
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _emailTextField(),
              const SizedBox(height: 10),
              _passwordTextField(),
              const SizedBox(height: 20),
              _buttonLogin(), // Tombol login dengan desain kotak yang sedikit rounded
            ],
          ),
        ),
      ),
    );
  }

  // Membuat Textbox Email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Calibri'),
    );
  }

  // Membuat Textbox Password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Calibri'),
    );
  }

  // Membuat Tombol Login dengan bentuk kotak sedikit rounded
  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded lebih kecil
        ),
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontFamily: 'Calibri', fontSize: 18, color: Colors.white),
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  // Membuat Tombol Registrasi sebagai teks underline
  Widget _buttonRegistrasiText() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegistrasiPage()),
        );
      },
      child: const Text(
        "Belum punya akun? Registrasi",
        style: TextStyle(
          fontFamily: 'Calibri',
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline, // Underline the text
        ),
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      print("Response: ${value.toString()}");
      if (value.code == 200) {
        if (value.token != null) {
          await UserInfo().setToken(value.token!);
        } else {
          _showWarningDialog("Token is null");
        }

        if (value.userID != null) {
          await UserInfo().setUserID(value.userID!);
        } else {
          _showWarningDialog("User ID is null");
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PemantauanTidurPage()),
        );
      } else {
        _showWarningDialog("Login gagal, silahkan coba lagi");
      }
    }, onError: (error) {
      print("Error: $error");
      _showWarningDialog("Login gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showWarningDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WarningDialog(
        description: message,
      ),
    );
  }
}
