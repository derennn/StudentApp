import 'package:flutter/material.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfasi.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app/repository/mesajlar_repository.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';

void main() {
  runApp(const OgrenciApp());
}

class OgrenciApp extends StatelessWidget {
  const OgrenciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Öğrenci Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnaSayfa(title: 'Öğrenci Ana Sayfa'),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  MesajlarRepository mesajlarRepository = MesajlarRepository();
  OgrencilerRepository ogrencilerRepository = OgrencilerRepository();
  OgretmenlerRepository ogretmenlerRepository = OgretmenlerRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextButton(
              onPressed: () {
                _ogrencilereGit(context);
              },
              child: Text('${ogrencilerRepository.ogrenciler.length} Öğrenci'),
            ),
            TextButton(
              onPressed: () {
                _ogretmenlereGit(context);
              },
              child: Text('${ogretmenlerRepository.ogretmenler.length} Öğretmen'),
            ),
            TextButton(
              onPressed: () {
                _mesajlaraGit(context);
              },
              child: Text('${mesajlarRepository.mesajlar.length} yeni mesaj'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Öğrenci Adı'),
            ),
            ListTile(
              title: const Text('Öğrenciler'),
              onTap: () {
                _ogrencilereGit(context);
              },
            ),
            ListTile(
              title: const Text('Öğretmenler'),
              onTap: () {
                _ogretmenlereGit(context);
              },
            ),
            ListTile(
              title: const Text('Mesajlar'),
              onTap: () {
                _mesajlaraGit(context);
              },
            ),
          ],
        ),
      ),
    );
  }


  void _ogrencilereGit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OgrencilerSayfasi(ogrencilerRepository);
      },));
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OgretmenlerSayfasi(ogretmenlerRepository);
    },));
  }

  void _mesajlaraGit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MesajlarSayfasi(mesajlarRepository);
    },));
  }

}