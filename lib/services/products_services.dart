import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsServices extends ChangeNotifier {
  final String _baseUrl = 'your endpoint here';
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  final storage = FlutterSecureStorage();

  late Product selectedProduct;
  late File? newPirctureFile;

  int cameraOrGallery = 1;

  ProductsServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    // convertir respuesta en mapa

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    // lo cargamos en la lista de productos

    productsMap.forEach((key, value) {
      final temp = Product.fromMap(value);
      temp.id = key;

      products.add(temp);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  // --------------------Control de flujo--------------------
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Es necesario crear
      await createProduct(product);
    } else {
      // Es necesario actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }
  // --------------------Control de flujo--------------------

  // --------------------Interacciones con la DB--------------------

  // Update
  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());
    // ignore: unused_local_variable
    final decodedData = json.decode(resp.body);

    // Solucion 2
    final index = products.indexWhere((element) => product.id == element.id);
    products[index] = product;

    // Actualizar el listado de productos
    return product.id.toString();
  }

  // Create
  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);
    product.id = decodedData["name"];
    products.add(product);

    // Actualizar el listado de productos
    return product.id.toString();
  }

  void updateSelectedProductImage(String path) {
    selectedProduct.picture = path;

    newPirctureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  void seleccionarFoto(int entero) {
    cameraOrGallery = entero;
    notifyListeners();
  }

  Future<String?> uploadImagen() async {
    if (newPirctureFile == null) return null;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dw1ghtfbz/image/upload?upload_preset=n9gzmimq');
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url,
    );
    final file =
        await http.MultipartFile.fromPath('file', newPirctureFile!.path);
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    newPirctureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
