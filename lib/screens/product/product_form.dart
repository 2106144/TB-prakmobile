import 'package:bakeryapps/apiservice/product.dart';
import 'package:bakeryapps/models/product.dart';
import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final ProductApi productApi = ProductApi();
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _attrController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _namaController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _qtyController.text = widget.product!.qty.toString();
      _attrController.text = widget.product!.attr;
      _weightController.text = widget.product!.weight.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null
            ? 'Tambah product Roti'
            : 'Edit product Roti'),
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
                      return 'Masukkan nama roti';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Harga'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan harga roti';
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
                      return 'Masukkan kuantitas roti';
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
                      return 'Masukkan atribut roti';
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
                      return 'Masukkan berat roti';
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
                    if (widget.product == null) {
                      // Tambah product baru
                      response = await productApi.createProduct(
                        _namaController.text,
                        num.parse(_priceController.text),
                        num.parse(_qtyController.text),
                        _attrController.text,
                        num.parse(_weightController.text),
                      );
                    } else {
                      // Update product yang ada
                      response = await productApi.updateProduct(
                        Product(
                          id: widget.product!.id,
                          name: _namaController.text,
                          price: num.parse(_priceController.text),
                          qty: num.parse(_qtyController.text),
                          attr: _attrController.text,
                          weight: num.parse(_weightController.text),
                        ),
                        widget.product!.id,
                      );
                    }

                    if (response == true) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(widget.product == null
                            ? "product berhasil ditambahkan"
                            : "product berhasil diperbarui"),
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).popAndPushNamed('/product');
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(widget.product == null
                            ? "product gagal ditambahkan"
                            : "product gagal diperbarui"),
                      ));
                    }
                  }
                },
                child: Text(
                  widget.product == null ? 'Simpan' : 'Update',
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
