import 'package:flutter/material.dart';
import 'dart:math';

import 'package:ogrenci_app/repository/mesajlar_repository.dart';

class MesajlarSayfasi extends StatefulWidget {
  final MesajlarRepository mesajlarRepository;
  const MesajlarSayfasi(this.mesajlarRepository, {Key? key}) : super(key: key);

  @override
  State<MesajlarSayfasi> createState() => _MesajlarSayfasiState();
}

class _MesajlarSayfasiState extends State<MesajlarSayfasi> {

  @override
  void initState() {
    widget.mesajlarRepository.yeniMesajSayisi = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mesajlar Sayfasi')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.mesajlarRepository.mesajlar.length,
              itemBuilder: (context, index) {
                return MesajGorunumu(widget.mesajlarRepository.mesajlar[widget.mesajlarRepository.mesajlar.length - index -1]);
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.shade300,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                    onPressed: () {
                      print('gönder');
                    },
                    child: const Text('gönder'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MesajGorunumu extends StatelessWidget {
  final Mesaj mesaj;
  const MesajGorunumu(this.mesaj, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          mesaj.gonderen == 'Ali' ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius:
                const BorderRadius.all(Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(mesaj.yazi),
          ),
        ),
      ),
    );
  }
}
