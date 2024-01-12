import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_sale_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/order_sale_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/payment_types_list_model.dart';
import 'package:appweb/app/modules/order_sale_register/data/model/product_prices_model.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_customer_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_payment_types_list.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/get_product_prices.dart';
import 'package:appweb/app/modules/order_sale_register/domain/usecase/reopen.dart';

import 'package:flutter/foundation.dart';

abstract class DataSource extends Gateway {
  DataSource({required super.httpClient});

  Future<List<OrderSaleListModel>> getOrderList(
      {required ParamsOrderList params});

  Future<OrderSaleMainModel> getOrderMain({required int tbOrderId});

  Future<List<CustomerListModel>> getCustomerList(
      {required ParamsCustomerList params});

  Future<List<PaymentTypesListModel>> getPaymentTypesList(
      {required ParamsPaymentList params});

  Future<List<OrderSaleItemModel>> getItemsList(
      {required ParamsItemsList params});

  Future<List<ProductListModel>> getProductList(
      {required ParamsProductList params});

  Future<ProductPricesModel> getProductPrices(
      {required ParamsProductPrices params});

  Future<OrderSaleListModel> post({required OrderSaleMainModel params});

  Future<OrderSaleListModel> put({required OrderSaleMainModel params});

  Future<OrderResultActionModel> delete({required ParamsDeleteOrder params});
  Future<OrderResultActionModel> closure({required ParamsClosureOrder params});
  Future<OrderResultActionModel> reopen({required ParamsReopenOrder params});
}

class DataSourceImpl extends DataSource {
  DataSourceImpl({required super.httpClient});
  List<OrderSaleListModel> orderList = [];
  List<CustomerListModel> customerList = [];
  List<PaymentTypesListModel> paymentTypesList = [];
  List<OrderSaleItemModel> itemsList = [];
  List<ProductListModel> productList = [];
  ProductPricesModel productPrices = ProductPricesModel.empty();
  OrderSaleMainModel order = OrderSaleMainModel.empty();

  @override
  Future<List<OrderSaleListModel>> getOrderList(
      {required ParamsOrderList params}) async {
    await getInstitutionId().then((value) {
      params.tbInstitutionId = int.parse(value);
    });

    await getUserId().then((value) {
      params.tbSalesmanId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'orderSale/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          orderList = (data as List).map((json) {
            return OrderSaleListModel.fromJson(json);
          }).toList();
        }
        return orderList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderSaleMainModel> getOrderMain({required int tbOrderId}) async {
    String tbInstitutionId = '1';
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });
    String tbSalesmanId = '1';
    await getUserId().then((value) {
      tbSalesmanId = value.toString();
    });

    return await request(
      'orderSale/get/$tbInstitutionId/$tbSalesmanId/${tbOrderId.toString()}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          order = OrderSaleMainModel.fromJson(data);
        }
        return order;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<CustomerListModel>> getCustomerList(
      {required ParamsCustomerList params}) async {
    await getInstitutionId().then((value) {
      params.tbInstitutionId = int.parse(value);
    });
    await getUserId().then((value) {
      params.tbSalesmanId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'customer/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          customerList = (data as List).map((json) {
            return CustomerListModel.fromJson(json);
          }).toList();
        }
        return customerList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<PaymentTypesListModel>> getPaymentTypesList(
      {required ParamsPaymentList params}) async {
    var tbInstitutionId = "";
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'paymenttype/getlist/$tbInstitutionId',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          paymentTypesList = (data as List).map((json) {
            return PaymentTypesListModel.fromJson(json);
          }).toList();
        }
        return paymentTypesList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<OrderSaleItemModel>> getItemsList(
      {required ParamsItemsList params}) async {
    String tbInstitutionId = "";
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'ordersale/items/getlist/$tbInstitutionId/${params.tbOrderId}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          itemsList = (data as List).map((json) {
            return OrderSaleItemModel.fromJson(json);
          }).toList();
        }
        return itemsList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<ProductListModel>> getProductList(
      {required ParamsProductList params}) async {
    params.tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });

    final body = jsonEncode(params.toJson());
    return await request(
      'product/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);
        productList = (data as List).map((json) {
          return ProductListModel.fromJson(json);
        }).toList();

        return productList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<ProductPricesModel> getProductPrices(
      {required ParamsProductPrices params}) async {
    var tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });

    return await request(
      'product/getPrices/$tbInstitutionId/${params.tbProductId}',
      (payload) {
        final data = json.decode(payload);
        productPrices = ProductPricesModel.fromJson(data);

        return productPrices;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderSaleListModel> post({required OrderSaleMainModel params}) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    params.order.tbInstitutionId = tbInstitutionId;
    params.order.tbUserId = tbUserId;
    params.orderSale.tbSalesmanId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'ordersale',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderSaleListModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderSaleListModel> put({required OrderSaleMainModel params}) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    params.order.tbInstitutionId = tbInstitutionId;
    params.order.tbUserId = tbUserId;
    params.orderSale.tbSalesmanId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'ordersale',
      method: HTTPMethod.put,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderSaleListModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderResultActionModel> delete(
      {required ParamsDeleteOrder params}) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    params.tbInstitutionId = tbInstitutionId;
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    params.tbUserId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'OrderSale',
      method: HTTPMethod.delete,
      data: body,
      (payload) {
        final data = json.decode(payload);

        return OrderResultActionModel.fromJson(data);
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderResultActionModel> closure(
      {required ParamsClosureOrder params}) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    params.tbInstitutionId = tbInstitutionId;
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    params.tbUserId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'OrderSale/closure',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        return OrderResultActionModel.fromJson(data);
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderResultActionModel> reopen(
      {required ParamsReopenOrder params}) async {
    int tbInstitutionId = 1;
    await getInstitutionId().then((value) {
      (kIsWeb) ? tbInstitutionId = value : tbInstitutionId = int.parse(value);
    });
    params.tbInstitutionId = tbInstitutionId;
    int tbUserId = 1;
    await getUserId().then((value) {
      (kIsWeb) ? tbUserId = value : tbUserId = int.parse(value);
    });
    params.tbUserId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'OrderSale/reopen',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        return OrderResultActionModel.fromJson(data);
      },
      onError: (error) {
        return ServerException;
      },
    );
  }
}
