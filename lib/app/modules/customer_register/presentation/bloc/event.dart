import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';

abstract class CustomerRegisterEvent {}

class GetListEvent extends CustomerRegisterEvent {
  final ParamsList params;
  GetListEvent({required this.params});
}

class SearchEvent extends CustomerRegisterEvent {
  final ParamsList params;

  SearchEvent({required this.params});
}

class FilterCustomerEvent extends CustomerRegisterEvent {}

class DesktopEvent extends CustomerRegisterEvent {
  final int? id;
  DesktopEvent({this.id});
}

class MobileNewEvent extends CustomerRegisterEvent {}

class MobileEditEvent extends CustomerRegisterEvent {
  final int tbCustomerId;

  MobileEditEvent({required this.tbCustomerId});
}

class CepEvent extends CustomerRegisterEvent {
  final String cep;

  CepEvent(this.cep);
}

class CnpjEvent extends CustomerRegisterEvent {
  final String cnpj;

  CnpjEvent(this.cnpj);
}

class GetStatesEvent extends CustomerRegisterEvent {}

class GetCitysEvent extends CustomerRegisterEvent {
  final int tbStateId;

  GetCitysEvent(this.tbStateId);
}

class ReturnEvent extends CustomerRegisterEvent {
  int index;
  ReturnEvent({
    required this.index,
  });
}

class SearchStateEvent extends CustomerRegisterEvent {
  String search;

  SearchStateEvent({
    required this.search,
  });
}

class SearchCityEvent extends CustomerRegisterEvent {
  String search;

  SearchCityEvent({
    required this.search,
  });
}

class PostByDesktopEvent extends CustomerRegisterEvent {
  CustomerMainModel model;

  PostByDesktopEvent({
    required this.model,
  });
}

class PostByMobileEvent extends CustomerRegisterEvent {
  CustomerMainModel model;

  PostByMobileEvent({
    required this.model,
  });
}

class GetRegionEvent extends CustomerRegisterEvent {}

class SearchRegionEvent extends CustomerRegisterEvent {
  String search;

  SearchRegionEvent({
    required this.search,
  });
}

class GetSalesRouteEvent extends CustomerRegisterEvent {}

class SearchSalesRouteEvent extends CustomerRegisterEvent {
  String search;

  SearchSalesRouteEvent({
    required this.search,
  });
}
