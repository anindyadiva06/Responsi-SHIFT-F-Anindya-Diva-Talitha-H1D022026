import 'package:flutter/material.dart';
import '../bloc/transaksi_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/transaksi.dart';
import 'transaksi_page.dart';

class TransaksiForm extends StatefulWidget {
  Transaksi? transaksi;
  TransaksiForm({Key? key, this.transaksi}) : super(key: key);

  @override
  _TransaksiFormState createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "ADD TRANSACTION";
  String tombolSubmit = "Add New Data";
  final _transaction2TextboxController = TextEditingController();
  final _type2TextboxController = TextEditingController();
  final _amount2TextboxController = TextEditingController();

  final FocusNode _transactionFocusNode = FocusNode();
  final FocusNode _typeFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.transaksi != null) {
      setState(() {
        judul = "UPDATE TRANSACTION";
        tombolSubmit = "Update";
        _transaction2TextboxController.text = widget.transaksi!.transaction2!;
        _type2TextboxController.text = widget.transaksi!.type2!;
        _amount2TextboxController.text = widget.transaksi!.amount2.toString();
      });
    } else {
      judul = "ADD TRANSACTION";
      tombolSubmit = "Save";
    }
  }

  @override
  void dispose() {
    _transactionFocusNode.dispose();
    _typeFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
        ),
        backgroundColor: const Color.fromARGB(235, 255, 219, 231),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _transaction2TextField(),
                    const SizedBox(height: 16.0),
                    _type2TextField(),
                    const SizedBox(height: 16.0),
                    _amount2TextField(),
                    const SizedBox(height: 20.0),
                    _buttonSubmit(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _transaction2TextField() {
    return TextFormField(
      focusNode: _transactionFocusNode,
      decoration: InputDecoration(
        labelText: "Transaction",
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _transactionFocusNode.hasFocus ? Colors.white : Colors.white,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _transaction2TextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Transaction Must Be Filled In!";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white, fontFamily: 'Verdana'),
    );
  }

  Widget _type2TextField() {
    return TextFormField(
      focusNode: _typeFocusNode,
      decoration: InputDecoration(
        labelText: "Type",
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _typeFocusNode.hasFocus ? Colors.white : Colors.white,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      controller: _type2TextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Type Must Be Filled In!";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white, fontFamily: 'Verdana'),
    );
  }

  Widget _amount2TextField() {
    return TextFormField(
      focusNode: _amountFocusNode,
      decoration: InputDecoration(
        labelText: "Amount",
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Verdana'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: _amountFocusNode.hasFocus ? Colors.white : Colors.white,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _amount2TextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Amount Must Be Filled In!";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white, fontFamily: 'Verdana'),
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      child: Text(tombolSubmit, style: const TextStyle(color: Colors.white)),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.transaksi != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(235, 255, 219, 231),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Transaksi createTransaksi = Transaksi(id: null);
    createTransaksi.transaction2 = _transaction2TextboxController.text;
    createTransaksi.type2 = _type2TextboxController.text;
    createTransaksi.amount2 = int.parse(_amount2TextboxController.text);
    TransaksiBloc.addTransaksi(transaksi: createTransaksi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransaksiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Save Failed! Please Try Again",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Transaksi updateTransaksi = Transaksi(id: widget.transaksi!.id!);
    updateTransaksi.transaction2 = _transaction2TextboxController.text;
    updateTransaksi.type2 = _type2TextboxController.text;
    updateTransaksi.amount2 = int.parse(_amount2TextboxController.text);
    TransaksiBloc.updateTransaksi(transaksi: updateTransaksi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransaksiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Update Request Failed! Please Try Again",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
