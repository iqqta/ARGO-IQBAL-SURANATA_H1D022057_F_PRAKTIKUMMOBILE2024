import 'package:flutter/material.dart';
import 'package:auth/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState(); // Correct class name
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var namauser;

  // Function untuk menyimpan username di SharedPreferences
  void _saveUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);

    // Update state untuk menyimpan username di variabel lokal
    setState(() {
      namauser = _usernameController.text;
    });
  }

  // Fungsi untuk menampilkan input field (umum untuk username dan password)
  Widget _showInput(TextEditingController controller, String placeholder, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: placeholder,
      ),
    );
  }

  // Fungsi untuk menampilkan dialog box
  void _showDialog(String pesan, Widget alamat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(pesan),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Pindah ke halaman baru sesuai dengan widget 'alamat' yang dikirim
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => alamat),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _showInput(_usernameController, 'Masukkan Username', false), // Input untuk username
            _showInput(_passwordController, 'Masukkan Password', true),  // Input untuk password
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                // Cek jika username dan password sama dengan 'admin'
                if (_usernameController.text == 'admin' &&
                    _passwordController.text == 'admin') {
                  // Simpan username di SharedPreferences
                  _saveUsername();

                  // Tampilkan dialog berhasil login dan pindah ke HomePage
                  _showDialog('Anda Berhasil Login', const HomeScreen());
                } else {
                  // Tampilkan dialog error jika login gagal
                  _showDialog('Username dan Password Salah', const LoginPage());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
