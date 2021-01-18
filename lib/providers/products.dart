import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../soap/model/medical_policy_details_client.dart';
import '../soap/model/policy_information_client.dart';

import '../models/http_exception.dart';
import './product.dart';
import 'auth.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
  ];



  // var _showFavoritesOnly = false;
  final Auth auth;
    String authToken;
  Products(this.auth, this._items){
    authToken = auth.token;
  }

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
   // return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
   // return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }
  static const  SUCCESS_CODE = "0";
final _policyInformation = PolicyInformation();
final _medicalPolicyDetailsClient = MedicalPolicyDetailsClient();
  MedicalPolicyDetailsRequest _medicalPolicyDetailsRequest;
  PolicyInformationResponse _policyInformationResponse;
  MedicalPolicyDetailsResponse _medicalPolicyDetailsResponse;

  MedicalPolicyDetailsResponse get medicalPolicyDetailsResponse {
    return _medicalPolicyDetailsResponse ;
  }
  MedicalPolicyDetailsRequest get medicalPolicyDetailsRequest {
    return _medicalPolicyDetailsRequest ;
  }


  Future<void> fetchAndSetMedicalPolicyDetails(String policyNumber) async {
    if(_medicalPolicyDetailsResponse != null  ){
      String resultCode = _medicalPolicyDetailsResponse.resultCode;
      if (resultCode.isEmpty ||   resultCode != Products.SUCCESS_CODE){
            print('call api');
      }else{
        print('do not call api');
        return;
      }
    }

    String username = this.auth.customerLoginRequest.username;
    String password = this.auth.customerLoginRequest.password;
    String langCode = this.auth.customerLoginRequest.langCode;
    String  medicalCustomerId=this.auth.customerLoginResponse.customer.medCustomerID;
    String idNumber = this.auth.customerLoginResponse.customer.iqamahID;
    String  customerId = this.auth.customerLoginResponse.customer.customerID;


    try{
         _medicalPolicyDetailsRequest = MedicalPolicyDetailsRequest(
         username: username,
         policyNumber: policyNumber,
         medicalCustomerId: medicalCustomerId,
         idNumber: idNumber,
         customerId: customerId,
         password: password,
         langCode: langCode,
       );
       _medicalPolicyDetailsResponse = await _medicalPolicyDetailsClient.getMedicalPolicyDetails(_medicalPolicyDetailsRequest);

      String resultCode = _medicalPolicyDetailsResponse.resultCode;
      if (resultCode.isEmpty ||   resultCode != Products.SUCCESS_CODE){
        throw HttpException(_medicalPolicyDetailsResponse.resultDescription);
      }else{

      }
      notifyListeners();
    } catch (error) {
      throw error;
    }

  }


  Future<void> fetchAndSetPolicies() async {
   String username = this.auth.customerLoginRequest.username;
   String password = this.auth.customerLoginRequest.password;
   String langCode = this.auth.customerLoginRequest.langCode;
    try{
    PolicyInformationRequest policyInformationReq = PolicyInformationRequest(
                  username: username,password:password,langCode:langCode  ) ;
   _policyInformationResponse = await _policyInformation.getPolicyInformation(policyInformationReq);

    String resultCode = _policyInformationResponse.resultCode;
   if (resultCode.isEmpty ||   resultCode != Products.SUCCESS_CODE){
     throw HttpException(_policyInformationResponse.resultDescription);
   }else{

   }
   notifyListeners();
  } catch (error) {
  throw error;
  }

  }

  PolicyInformationResponse get policyInformationResponse {
    return _policyInformationResponse ;
  }

  Future<void> fetchAndSetProducts() async {
    final url = 'https://flutter-update.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = 'https://flutter-update.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-update.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-update.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
