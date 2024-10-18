import 'package:flutter/material.dart';
import 'package:health/bloc/pemantauan_tidur_bloc.dart';
import 'package:health/model/pemantauan_tidur.dart';
import 'package:health/ui/pemantauan_page.dart';
import 'package:health/widget/warning_dialog.dart';

class PemantauanTidurForm extends StatefulWidget {
  PemantauanTidur? pemantauanTidur;

  PemantauanTidurForm({Key? key, this.pemantauanTidur}) : super(key: key);

  @override
  _PemantauanTidurFormState createState() => _PemantauanTidurFormState();
}

class _PemantauanTidurFormState extends State<PemantauanTidurForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH DATA PEMANTAUAN TIDUR";
  String tombolSubmit = "SIMPAN";

  final _sleepQualityController = TextEditingController();
  final _sleepHoursController = TextEditingController();
  final _sleepDisordersController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.pemantauanTidur != null) {
      setState(() {
        judul = "UBAH DATA PEMANTAUAN TIDUR";
        tombolSubmit = "UBAH";
        _sleepQualityController.text = widget.pemantauanTidur!.sleepQuality!;
        _sleepHoursController.text = widget.pemantauanTidur!.sleepHours.toString();
        _sleepDisordersController.text = widget.pemantauanTidur!.sleepDisorders!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul, style: const TextStyle(fontFamily: 'Calibri', fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
        elevation: 5,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _sleepQualityTextField(),
                  const SizedBox(height: 10),
                  _sleepHoursTextField(),
                  const SizedBox(height: 10),
                  _sleepDisordersTextField(),
                  const SizedBox(height: 20),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sleepQualityTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kualitas Tidur", border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      controller: _sleepQualityController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kualitas Tidur harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Calibri'),
    );
  }

  Widget _sleepHoursTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jam Tidur", border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.number,
      controller: _sleepHoursController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jam Tidur harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Calibri'),
    );
  }

  Widget _sleepDisordersTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Gangguan Tidur", border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      controller: _sleepDisordersController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Gangguan Tidur harus diisi";
        }
        return null;
      },
      style: const TextStyle(fontFamily: 'Calibri'),
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
      ),
      child: Text(tombolSubmit, style: const TextStyle(fontFamily: 'Calibri', fontSize: 18)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.pemantauanTidur != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    PemantauanTidur createPemantauan = PemantauanTidur(id: null);
    createPemantauan.sleepQuality = _sleepQualityController.text;
    createPemantauan.sleepHours = int.parse(_sleepHoursController.text);
    createPemantauan.sleepDisorders = _sleepDisordersController.text;

    PemantauanTidurBloc.addPemantauanTidur(pemantauanTidur: createPemantauan).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const PemantauanTidurPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    PemantauanTidur updatePemantauan = PemantauanTidur(id: widget.pemantauanTidur!.id!);
    updatePemantauan.sleepQuality = _sleepQualityController.text;
    updatePemantauan.sleepHours = int.parse(_sleepHoursController.text);
    updatePemantauan.sleepDisorders = _sleepDisordersController.text;

    PemantauanTidurBloc.updatePemantauanTidur(pemantauanTidur: updatePemantauan).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const PemantauanTidurPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
