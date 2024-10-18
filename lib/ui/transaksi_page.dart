import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/transaksi_bloc.dart';
import '/model/transaksi.dart';
import '/ui/transaksi_detail.dart';
import '/ui/transaksi_form.dart';
import 'login_page.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({Key? key}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TRANSACTION LIST',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Verdana',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(
                Icons.add,
                size: 26.0,
                color: Colors.white,
              ),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TransaksiForm()));
              },
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 197, 181, 235),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 192, 112, 139),
                const Color.fromARGB(255, 219, 181, 226),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 192, 112, 139),
                      Color.fromARGB(255, 219, 181, 226),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Verdana',
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Verdana',
                  ),
                ),
                trailing: const Icon(Icons.logout, color: Colors.white),
                onTap: () async {
                  await LogoutBloc.logout().then((value) => {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (route) => false)
                      });
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFB3E5FC),
              const Color.fromARGB(255, 197, 181, 235),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<List>(
          future: TransaksiBloc.getTransaksis(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListTransaksi(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListTransaksi extends StatelessWidget {
  final List? list;

  const ListTransaksi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: ListView.builder(
          itemCount: list == null ? 0 : list!.length,
          itemBuilder: (context, i) {
            return ItemTransaksi(
              transaksi: list![i],
            );
          },
        ),
      ),
    );
  }
}

class ItemTransaksi extends StatelessWidget {
  final Transaksi transaksi;

  const ItemTransaksi({Key? key, required this.transaksi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransaksiDetail(
                      transaksi: transaksi,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 173, 226, 226),
              const Color(0xFF9A6EAB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          title: Text(
            transaksi.transaction2!,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Verdana',
            ),
          ),
          subtitle: Text(
            transaksi.amount2.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Verdana',
            ),
          ),
          trailing: Text(
            transaksi.type2!,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Verdana',
            ),
          ),
        ),
      ),
    );
  }
}
