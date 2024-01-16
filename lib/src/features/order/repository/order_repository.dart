import 'dart:convert';
import 'package:flutter/Material.dart';
import '../../../../shared/api/api_endpoint.dart';
import '../../../../shared/api/api_service.dart';
import '../model/order_list_data_model.dart';

class OrderRepository {
  Future<List<OrderListDataModel>> getOrderList({required orderEndpoint}) async {
    List<OrderListDataModel> result = [];
    await ApiService.instance.apiCall(execute: () async {
      return await ApiService.instance.get(
          '${ApiEndpoint.baseUrl}$orderEndpoint',
          addToken: true);
    }, onSuccess: (response) async {
      debugPrint(response.body);
      var jsonData = jsonDecode(response.body);
      if(jsonData['data']!=null && jsonData['data'].isNotEmpty){
        result = orderListDataModelFromJson(jsonEncode(jsonData['data']));
      }
    }, onError: (error) {
      debugPrint(error.message ?? 'Something went wrong');
    });
    return result;
  }
}
