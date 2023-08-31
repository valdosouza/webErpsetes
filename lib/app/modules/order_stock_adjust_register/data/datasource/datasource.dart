import 'dart:convert';
import 'package:appweb/app/core/error/exceptions.dart';
import 'package:appweb/app/core/gateway.dart';
import 'package:appweb/app/modules/Core/data/model/order_result_action_model.dart';
import 'package:appweb/app/modules/Core/data/model/order_stock_adjust_item_model.dart';
import 'package:appweb/app/modules/Core/data/model/product_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/stock_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/entity_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_main_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/data/model/order_stock_adjust_list_model.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/closure.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/delete.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_entity_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_items_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_order_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_product_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/get_stock_list.dart';
import 'package:appweb/app/modules/order_stock_adjust_register/domain/usecase/reopen.dart';

import 'package:flutter/foundation.dart';

abstract class DataSource extends Gateway {
  DataSource({required super.httpClient});

  Future<List<OrderStockAdjustListModel>> getOrderList(
      {required ParamsOrderList params});

  Future<OrderStockAdjustMainModel> getOrderMain({required int tbOrderId});

  Future<List<EntityListModel>> getEntityList(
      {required ParamsEntityList params});

  Future<List<StockListModel>> getStockList({required ParamsStockList params});

  Future<List<OrderStockAdjustItemModel>> getItemsList(
      {required ParamsItemsList params});

  Future<List<ProductListModel>> getProductList(
      {required ParamsProductList params});

  Future<OrderStockAdjustListModel> post(
      {required OrderStockAdjustMainModel params});

  Future<OrderStockAdjustListModel> put(
      {required OrderStockAdjustMainModel params});

  Future<OrderResultActionModel> delete({required ParamsDeleteOrder params});

  Future<OrderResultActionModel> closure({required ParamsClosureOrder params});

  Future<OrderResultActionModel> reopen({required ParamsReopenOrder params});
}

class DataSourceImpl extends DataSource {
  DataSourceImpl({required super.httpClient});
  List<OrderStockAdjustListModel> orderList = [];
  List<EntityListModel> customerList = [];
  List<StockListModel> stockList = [];

  List<OrderStockAdjustItemModel> itemsList = [];
  List<ProductListModel> productList = [];
  OrderStockAdjustMainModel order = OrderStockAdjustMainModel.empty();

  @override
  Future<List<OrderStockAdjustListModel>> getOrderList(
      {required ParamsOrderList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });

    await getUserId().then((value) {
      (kIsWeb) ? params.tbUserId = value : params.tbUserId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'orderstockadjust/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          orderList = (data as List).map((json) {
            return OrderStockAdjustListModel.fromJson(json);
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
  Future<OrderStockAdjustMainModel> getOrderMain(
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
      'orderstockadjust/get/$tbInstitutionId/$tbUserId/${tbOrderId.toString()}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          order = OrderStockAdjustMainModel.fromJson(data);
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
      (kIsWeb) ? params.tbUserId = value : params.tbUserId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'entity/getlist',
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
  Future<List<StockListModel>> getStockList(
      {required ParamsStockList params}) async {
    await getInstitutionId().then((value) {
      (kIsWeb)
          ? params.tbInstitutionId = value
          : params.tbInstitutionId = int.parse(value);
    });
    final body = jsonEncode(params.toJson());
    return await request(
      'stocklist/getlist',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          stockList = (data as List).map((json) {
            return StockListModel.fromJson(json);
          }).toList();
        }
        return stockList;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<List<OrderStockAdjustItemModel>> getItemsList(
      {required ParamsItemsList params}) async {
    String tbInstitutionId = "";
    await getInstitutionId().then((value) {
      tbInstitutionId = value.toString();
    });

    return await request(
      'orderstockadjust/items/getlist/$tbInstitutionId/${params.tbOrderId}',
      (payload) {
        final data = json.decode(payload);

        if (data.length > 0) {
          itemsList = (data as List).map((json) {
            return OrderStockAdjustItemModel.fromJson(json);
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
  Future<OrderStockAdjustListModel> post(
      {required OrderStockAdjustMainModel params}) async {
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

    final body = jsonEncode(params.toJson());
    return request(
      'orderstockadjust',
      method: HTTPMethod.post,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderStockAdjustListModel.fromJson(data);
        return model;
      },
      onError: (error) {
        return ServerException;
      },
    );
  }

  @override
  Future<OrderStockAdjustListModel> put(
      {required OrderStockAdjustMainModel params}) async {
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

    final body = jsonEncode(params.toJson());
    return request(
      'orderstockadjust',
      method: HTTPMethod.put,
      data: body,
      (payload) {
        final data = json.decode(payload);
        var model = OrderStockAdjustListModel.fromJson(data);
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
      'orderstockadjust',
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
      'orderstockadjust/closure',
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
      'orderstockadjust/reopen',
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
