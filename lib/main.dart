import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ogrenci_app/pages/mesajlar_sayfasi.dart';
import 'package:ogrenci_app/pages/ogrenciler_sayfasi.dart';
import 'package:ogrenci_app/pages/ogretmenler_sayfasi.dart';
import 'package:ogrenci_app/repository/mesajlar_repository.dart';
import 'package:ogrenci_app/repository/ogrenciler_repository.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';
import 'animationsayfasi.dart';

void main() {
  runApp(const ProviderScope(child: OgrenciApp()));
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

class AnaSayfa extends ConsumerWidget {
  const AnaSayfa({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogrencilerRepository = ref.watch(ogrencilerProvider);
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              child: Text('${ref.watch(yeniMesajSayisiProvider)} yeni mesaj'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AnimationSayfasi();
                  },));
                },
                child: Text('Animation Sayfası'),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserHeader(),
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
      return const OgrencilerSayfasi();
      },));
  }

  void _ogretmenlereGit(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const OgretmenlerSayfasi();
    },));
  }

  Future<void> _mesajlaraGit(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const MesajlarSayfasi();
    },));
  }

}

class UserHeader extends StatefulWidget {
  const UserHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Öğrenci Adı'),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
              if (image == null) return;
              setState(() {
                imagePath = image.path;
              });
            },
            child: MovingAvatar(imagePath: imagePath),
            ),
        ],
      ),
    );
  }
}

class MovingAvatar extends StatefulWidget {
  const MovingAvatar({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  State<MovingAvatar> createState() => _MovingAvatarState();
}

class _MovingAvatarState extends State<MovingAvatar>
  with SingleTickerProviderStateMixin<MovingAvatar> {

  late Ticker _ticker;
  double yataydaKonum = 0.0;
  double dikeydeKonum = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      final aci = pi / 2 * elapsed.inMicroseconds / Duration(seconds: 1).inMicroseconds;
      final aci2 = pi * elapsed.inMicroseconds / Duration(seconds: 1).inMicroseconds;
      setState(() {
        yataydaKonum = sin(aci) * 30 + 30;
        dikeydeKonum = sin(aci2) * 30 + 30;
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: yataydaKonum, top: dikeydeKonum),
      child: CircleAvatar(
        child:
        widget.imagePath == null
          ? Text('DB')
          : null,
        backgroundImage:
        widget.imagePath == null
        ? null
        : FileImage(File(widget.imagePath!)),
        ),
    );
  }
}