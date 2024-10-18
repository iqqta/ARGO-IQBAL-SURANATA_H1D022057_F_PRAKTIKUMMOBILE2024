import 'package:flutter/material.dart';
import 'package:health/bloc/logout_bloc.dart';
import 'package:health/bloc/pemantauan_tidur_bloc.dart';
import 'package:health/model/pemantauan_tidur.dart';
import 'package:health/ui/health_detail.dart';
import 'package:health/ui/health_form.dart';
import 'package:health/ui/login_page.dart';

class PemantauanTidurPage extends StatefulWidget {
  const PemantauanTidurPage({Key? key}) : super(key: key);

  @override
  _PemantauanTidurPageState createState() => _PemantauanTidurPageState();
}

class _PemantauanTidurPageState extends State<PemantauanTidurPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep Monitoring',
          style: const TextStyle(fontFamily: 'Calibri', fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF0B0B0), // Pastel pink color
        elevation: 5, // Add shadow effect
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => PemantauanTidurForm(),
                ),
               );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Logout', style: const TextStyle(fontFamily: 'Calibri')),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                        (route) => false,
                      )
                    });
              },
            )
          ],
        ),
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
        child: FutureBuilder<List<PemantauanTidur>>(
          future: PemantauanTidurBloc.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListPemantauanTidur(list: snapshot.data)
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListPemantauanTidur extends StatelessWidget {
  final List<PemantauanTidur>? list;
  const ListPemantauanTidur({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemPemantauanTidur(pemantauanTidur: list![i]);
      },
    );
  }
}

class ItemPemantauanTidur extends StatelessWidget {
  final PemantauanTidur pemantauanTidur;

  const ItemPemantauanTidur({Key? key, required this.pemantauanTidur})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PemantauanTidurDetail(
              pemantauanTidur: pemantauanTidur,
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xFFFDDDE6), // Light pastel pink color
        elevation: 3, // Add shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: ListTile(
          title: Text(
            pemantauanTidur.sleepQuality!,
            style: const TextStyle(fontFamily: 'Calibri', fontSize: 18),
          ),
          subtitle: Text(
            'Hours: ${pemantauanTidur.sleepHours}, Disorders: ${pemantauanTidur.sleepDisorders}',
            style: const TextStyle(fontFamily: 'Calibri', fontSize: 16),
          ),
        ),
      ),
    );
  }
}