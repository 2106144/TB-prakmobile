import 'package:bakeryapps/apiservice/stock.dart';
import 'package:bakeryapps/models/stock.dart';
import 'package:flutter/material.dart';

class StockFormScreen extends StatefulWidget {
  final Stock? stock;

  const StockFormScreen({super.key, this.stock});

  @override
  State<StockFormScreen> createState() => _StockFormScreenState();
}

class _StockFormScreenState extends State<StockFormScreen> {
  final StockApi stockApi = StockApi();
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.stock != null) {
      _namaController.text = widget.stock!.name;
      _qtyController.text = widget.stock!.qty.toString();
      _attrController.text = widget.stock!.attr;
      _weightController.text = widget.stock!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.stock == null ? 'Tambah Stock Roti' : 'Edit Stock Roti'),
        backgroundColor: const Color.fromARGB(247, 255, 169, 9),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Nama'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama stock';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _qtyController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Kuantitas'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan kuantitas stock';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _attrController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Atribut'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan atribut stock';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Berat'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan berat stock';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool response;
                    if (widget.stock == null) {
                      // Tambah stock baru
                      response = await stockApi.createStock(
                        _namaController.text,
                        double.parse(_qtyController.text),
                        _attrController.text,
                        double.parse(_weightController.text),
                      );
                    } else {
                      // Update stock yang ada
                      response = await stockApi.updateStock(
                        Stock(
                          id: widget.stock!.id,
                          name: _namaController.text,
                          qty: double.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: double.parse(_weightController.text),
                        ),
                        widget.stock!.id,
                      );
                    }

                    if (response == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.stock == null
                            ? "stock berhasil ditambahkan"
                            : "stock berhasil diperbarui"),
                      ));
                      Navigator.of(context).popAndPushNamed('/stock');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.stock == null
                            ? "stock gagal ditambahkan"
                            : "stock gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.stock == null ? 'Simpan' : 'Update',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
