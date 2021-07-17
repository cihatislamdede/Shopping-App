import 'package:flutter/material.dart';
import 'package:my_shop_app/prodivders/product.dart';
import 'package:my_shop_app/prodivders/products.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add_product';
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void initState() {
    _imageURLFocusNode.addListener(_updateImageURL);
    super.initState();
  }

  @override
  void dispose() {
    _imageURLFocusNode.removeListener(_updateImageURL);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageURLFocusNode.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  void _updateImageURL() {
    if (!_imageURLFocusNode.hasFocus) {
      if ((!_imageURLController.text.startsWith('http') &&
              !_imageURLController.text.startsWith('https')) ||
          (!_imageURLController.text.endsWith('.png') &&
              !_imageURLController.text.endsWith('.jpg') &&
              !_imageURLController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveFrom() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavorite: _editedProduct.isFavorite,
                      title: value.toString(),
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      isFavorite: _editedProduct.isFavorite,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid value.';
                  }
                  if (double.parse(value) < 0) {
                    return 'Please enter a number greater than 0.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value.toString(),
                      price: _editedProduct.price,
                      isFavorite: _editedProduct.isFavorite,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _imageURLController.text.isEmpty
                        ? const Text(
                            'Enter a URL',
                            textAlign: TextAlign.center,
                          )
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageURLController.text),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageURLController,
                      focusNode: _imageURLFocusNode,
                      onFieldSubmitted: (_) {
                        _saveFrom();
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          isFavorite: _editedProduct.isFavorite,
                          imageUrl: value.toString(),
                        );
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an image URL.';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Please enter a valid URL.';
                        }
                        if (!value.endsWith('.jpg') &&
                            !value.endsWith('.png') &&
                            !value.endsWith('.jpeg')) {
                          return 'Please enter a valid image URL. (.png,.jpg,.jpeg)';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(top: 15, right: 20),
                child: ElevatedButton(
                  onPressed: _saveFrom,
                  child: const Icon(
                    Icons.post_add,
                    size: 32,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
