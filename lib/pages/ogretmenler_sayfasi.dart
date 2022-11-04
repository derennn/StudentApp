import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ogrenci_app/repository/ogretmenler_repository.dart';
import '../models/ogretmen.dart';
import 'package:ogrenci_app/pages/ogretmen/ogretmen_form.dart';

class OgretmenlerSayfasi extends ConsumerWidget {
  const OgretmenlerSayfasi({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ogretmenlerRepository = ref.watch(ogretmenlerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Öğretmenler')),
      body: Column(
        children: [
          PhysicalModel(
            color: Colors.white,
            elevation: 10,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 32.0),
                    child: Text(
                        '${ogretmenlerRepository.ogretmenler.length} Öğretmen'),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: OgretmenindirmeButonu(),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.refresh(ogretmenListesiProvider);
              },
              child: ref.watch(ogretmenListesiProvider).when(
                data: (data) => ListView.separated(
                  itemBuilder: (context, index) => OgretmenSatiri(
                    data[index],
                  ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: data.length,
                ),
                error: (error, stackTrace) {
                  return const Text('error');
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.of(context).push<bool>(MaterialPageRoute(
            builder: (context) {
              return const OgretmenForm();
            },
          ));
          if (created == true) {
            print('Ogretmenleri yenile!');
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class OgretmenindirmeButonu extends StatefulWidget {
  const OgretmenindirmeButonu({
    Key? key,
  }) : super(key: key);

  @override
  State<OgretmenindirmeButonu> createState() => _OgretmenindirmeButonuState();
}

class _OgretmenindirmeButonuState extends State<OgretmenindirmeButonu> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return isLoading ? CircularProgressIndicator() : IconButton(
          icon: const Icon(Icons.download),
            onPressed: () async {
            try {
              setState(() {
                isLoading = true;
              });
              await ref.read(ogretmenlerProvider).indir();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString())),
              );
            }
            finally {
              setState(() {
                isLoading = false;
              });
            }
          },
        );
      }
    );
  }
}

class OgretmenSatiri extends StatelessWidget {
  final Ogretmen ogretmen;
  const OgretmenSatiri(
      this.ogretmen, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(right: 5),
      title: Text(ogretmen.ad + ' ' + ogretmen.soyad),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ogretmen.cinsiyet == 'Kadın'
              ? IconButton(
            onPressed: () {},
            icon: Icon(Icons.woman_rounded),
          )
              : IconButton(
            onPressed: () {},
            icon: Icon(Icons.man_rounded),
          ),
        ],
      ),
    );
  }
}
