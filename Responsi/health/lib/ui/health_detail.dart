import 'package:flutter/material.dart';
import 'package:health/bloc/pemantauan_tidur_bloc.dart';
import 'package:health/model/pemantauan_tidur.dart';
import 'package:health/ui/health_form.dart';
import 'package:health/ui/pemantauan_page.dart';
import 'package:health/widget/warning_dialog.dart';

class PemantauanTidurDetail extends StatefulWidget {
  final PemantauanTidur? pemantauanTidur;

  PemantauanTidurDetail({Key? key, this.pemantauanTidur}) : super(key: key);

  @override
  _PemantauanTidurDetailState createState() => _PemantauanTidurDetailState();
}

class _PemantauanTidurDetailState extends State<PemantauanTidurDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sleep Monitoring Detail',
          style: TextStyle(fontFamily: 'Calibri', fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF0E68C), // Light pastel yellow
              const Color(0xFFE7F0F4), // Light pastel blue
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kualitas Tidur : ${widget.pemantauanTidur!.sleepQuality}",
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Calibri',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Jumlah Jam Tidur : ${widget.pemantauanTidur!.sleepHours} jam",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Calibri',
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Gangguan Tidur : ${widget.pemantauanTidur!.sleepDisorders}",
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Calibri',
                  ),
                ),
                const SizedBox(height: 30),
                _tombolHapusEdit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Custom padding
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PemantauanTidurForm(
                  pemantauanTidur: widget.pemantauanTidur!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10), // Spacing between buttons
        // Tombol Hapus
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE7F0F4), // Light pastel blue
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Custom padding
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(
              fontFamily: 'Calibri',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text(
        "Yakin ingin menghapus data ini?",
        style: TextStyle(
          fontFamily: 'Calibri',
          fontSize: 18,
        ),
      ),
      actions: [
        // Tombol Hapus
        OutlinedButton(
          child: const Text(
            "Ya",
            style: TextStyle(fontFamily: 'Calibri'),
          ),
          onPressed: () {
            PemantauanTidurBloc.deletePemantauanTidur(id: widget.pemantauanTidur!.id!).then(
              (value) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PemantauanTidurPage(),
                ));
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          child: const Text(
            "Batal",
            style: TextStyle(fontFamily: 'Calibri'),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
