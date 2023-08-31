import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_transfer_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/data/model/order_stock_transfer_list_model.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_transfer_register/domain/usecase/reopen.dart';

import 'package:flutter/foundation.dart';

abstract class DataSource extends Gateway {
  DataSource({required super.httpClient});

  Future<List<OrderStockTransferListModel>> getOrderList(
      {required ParamsOrderList params});

  Future<OrderStockTransferMainModel> getOrderMain({required int tbOrderId});

  Future<List<EntityListModel>> getEntityList(
      {required ParamsEntityList params});

  Future<List<OrderStockTransferItemModel>> getItemsList(
      {required ParamsItemsList params});

  Future<List<ProductListModel>> getProductList(
      {required ParamsProductList params});

  Future<OrderStockTransferListModel> post(
      {required OrderStockTransferMainModel params});

  Future<OrderStockTransferListModel> put(
      {required OrderStockTransferMainModel params});

  Future<OrderResultActionModel> delete({required ParamsDeleteOrder params});

  Future<OrderResultActionModel> closure({required ParamsClosureOrder params});

  Future<OrderResultActionModel> reopen({required ParamsReopenOrder params});
}

class DataSourceImpl extends DataSource {
  DataSourceImpl({required super.httpClient});
  List<OrderStockTransferListModel> orderList = [];
  List<EntityListModel> customerList = [];

  List<OrderStockTransferItemModel> itemsList = [];
  List<ProductListModel> productList = [];
  OrderStockTransferMainModel order = OrderStockTransferMainModel.empty();

  @override
  Future<List<OrderStockTransferListModel>> getOrderList(
      {required ParamsOrderList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });

    await getUserId().then((value) {
      (kIsWeb)
          ? params.tbSalesmanId = value
          : params.tbSalesmanId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'OrderStockTransfer/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          orderList = (data as List).map((json) {
            return OrderStockTransferListModel.fromJson(json);
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
  Future<OrderStockTransferMainModel> getOrderMain(
      {required int tbOrderId}) async {
    String tbInstitutionId = '1';
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? tbInstitutionId = value.toString()
          : tbInstitutionId = value.toString();
    });
    String tbUserId = '1';
    await getUserId().then((value) {
      tbUserId = value.toString();
    });

    return await request(
      'OrderStockTransfer/get/$tbInstitutionId/$tbUserId/${tbOrderId.toString()}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          order = OrderStockTransferMainModel.fromJson(data);
        }
        return order;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<EntityListModel>> getEntityList(
      {required ParamsEntityList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
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
            return EntityListModel.fromJson(json);
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
  Future<List<OrderStockTransferItemModel>> getItemsList(
      {required ParamsItemsList params}) async {
    String tbInstitutionId = "";
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'OrderStockTransfer/items/getlist/$tbInstitutionId/${params.tbOrderId}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          itemsList = (data as List).map((json) {
            return OrderStockTransferItemModel.fromJson(json);
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
  Future<OrderStockTransferListModel> post(
      {required OrderStockTransferMainModel params}) async {
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
    params.orderStockTransfer.tbEntityId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'OrderStockTransfer',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderStockTransferListModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderStockTransferListModel> put(
      {required OrderStockTransferMainModel params}) async {
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
    params.orderStockTransfer.tbEntityId = tbUserId;

    final body = jsonEncode(params.toJson());
    return request(
      'OrderStockTransfer',
      method: HTTPMethod.put,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderStockTransferListModel.fromJson(data);
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
      'OrderStockTransfer',
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
      'OrderStockTransfer/closure',
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
      'OrderStockTransfer/reopen',
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
