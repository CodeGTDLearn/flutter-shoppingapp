import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/entities/product.dart';
import '../repo/i_managed_products_repo.dart';
import 'i_managed_products_service.dart';

class ManagedProductsService implements IManagedProductsService {
  final IManagedProductsRepo _repo = Get.find();

  @override
  List<Product> getAll() {
    return _repo.getAll();
  }

  @override
  int managedProductsQtde() {
    return getAll().length;
  }

  @override
  Product getById(String id) {
    return _repo.getById(id);
  }

  @override
  Future<void> addProduct(Product product) {
    _repo.add(product);
  }

  @override
  void update(Product product) {
    _repo.update(product);
  }

  @override
  void delete(String id) {
    _repo.delete(id);
  }
}
