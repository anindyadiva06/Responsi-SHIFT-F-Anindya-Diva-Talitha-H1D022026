import 'package:flutter/material.dart'; 
import '../bloc/transaksi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transaksi.dart';
import '/ui/transaksi_form.dart';
import 'transaksi_page.dart';

class TransaksiDetail extends StatefulWidget {
  Transaksi? transaksi;

  TransaksiDetail({Key? key, this.transaksi}) : super(key: key);

  @override
  _TransaksiDetailState createState() => _TransaksiDetailState();
}

class _TransaksiDetailState extends State<TransaksiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Detail',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Verdana',
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
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
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB3E5FC),
              Color.fromARGB(255, 197, 181, 235),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Transaction : ${widget.transaksi!.transaction2}",
                style: const TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Verdana',
                  color: Colors.black,
                ),
              ),
              Text(
                "Type : ${widget.transaksi!.type2}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Verdana',
                  color: Colors.black,
                ),
              ),
              Text(
                "Amount : Rp. ${widget.transaksi!.amount2}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Verdana',
                  color: Colors.black,
                ),
              ),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 192, 112, 139),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransaksiForm(
                  transaksi: widget.transaksi!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 219, 181, 226),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are You Sure To Delete This Transaction?"),
      actions: [
        OutlinedButton(
          child: const Text("Yes"),
          onPressed: () {
            TransaksiBloc.deleteTransaksi(id: widget.transaksi!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TransaksiPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Delete Failed, Please Try Again",
                      ));
            });
          },
        ),
        OutlinedButton(
          child: const Text("No"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
