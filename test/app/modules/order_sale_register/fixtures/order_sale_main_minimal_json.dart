/// Minimal JSON tree for [OrderSaleMainModel.fromJson] in tests.
Map<String, dynamic> minimalOrderSaleMainJson() {
  return <String, dynamic>{
    'order': <String, dynamic>{
      'id': 1,
      'tb_institution_id': 2,
      'terminal': 1,
      'tb_user_id': 3,
      'doc_user': 'U1',
      'dt_record': '2024-03-15',
      'note': '',
      'origin': 'app',
      'status': 'A',
      'being_used': '',
    },
    'sale': <String, dynamic>{
      'number': 99,
      'tb_customer_id': 10,
      'name_customer': 'Cliente X',
      'doc_customer': '123',
      'tb_salesman_id': 4,
      'name_salesman': 'Vendedor',
      'doc_salesman': '456',
    },
    'billing': <String, dynamic>{
      'tb_payment_types_id': 1,
      'name_payment': 'Dinheiro',
      'task_owner': 0,
      'deadline': '',
      'plots': 1,
    },
    'totalizer': <String, dynamic>{
      'items_qtde': 1.0,
      'product_qtde': 2.0,
      'product_value': 100.0,
      'ipi_value': 0.0,
      'discount_aliquot': 0.0,
      'discount_value': 0.0,
      'expenses_value': 0.0,
      'total_value': 100.0,
    },
    'items': <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 1,
        'tb_order_id': 1,
        'tb_product_id': 50,
        'name_product': 'Produto A',
        'tb_stock_list_id': 1,
        'quantity': 2.0,
        'unit_value': 50.0,
        'discount_aliquot': 0.0,
        'discount_value': 0.0,
        'update_status': 'I',
      },
    ],
  };
}
