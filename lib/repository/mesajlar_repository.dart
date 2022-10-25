class MesajlarRepository {

  final List<Mesaj> mesajlar = [
    Mesaj('Merhaba', 'Ali', DateTime.now().subtract(const Duration(minutes: 3))),
    Mesaj('Nasılsın', 'Ali', DateTime.now().subtract(const Duration(minutes: 2))),
    Mesaj('Evet', 'Ayşe', DateTime.now().subtract(const Duration(minutes: 1))),
    Mesaj('Evet', 'Ayşe', DateTime.now()),
  ];

}

class Mesaj {
  String yazi;
  String gonderen;
  DateTime zaman;

  Mesaj(this.yazi, this.gonderen, this.zaman);
}