import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mesaj.dart';

class MesajlarRepository extends ChangeNotifier {

  final List<Mesaj> mesajlar = [
    Mesaj('Merhaba', 'Ali', DateTime.now().subtract(const Duration(minutes: 3))),
    Mesaj('Nasılsın', 'Ali', DateTime.now().subtract(const Duration(minutes: 2))),
    Mesaj('Evet', 'Ayşe', DateTime.now().subtract(const Duration(minutes: 1))),
    Mesaj('Evet', 'Ayşe', DateTime.now()),
  ];
}

final mesajlarProvider = ChangeNotifierProvider((ref) {
  return MesajlarRepository();
});

class YeniMesajSayisi extends StateNotifier<int> {
  YeniMesajSayisi(int state) : super(state);

  void sifirla() {
    state = 0;
  }
}

final yeniMesajSayisiProvider = StateNotifierProvider<YeniMesajSayisi, int>((ref) {
  return YeniMesajSayisi(4);
});