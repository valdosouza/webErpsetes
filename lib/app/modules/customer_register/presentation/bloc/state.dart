import 'package:appweb/app/modules/Core/data/model/city_model.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/state_model.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';

abstract class CustomerRegisterState {
  List<CustomerListModel> customerList;

  CustomerRegisterState({
    required this.customerList,
  });
}

class ReturnedState extends CustomerRegisterState {
  final List<CustomerListModel> list;
  ReturnedState({required this.list}) : super(customerList: list);
}

class LoadingState extends CustomerRegisterState {
  LoadingState() : super(customerList: []);
}

class InfoPageState extends CustomerRegisterState {
  final CustomerMainModel model;
  final int tabIndex;
  InfoPageState({
    required List<CustomerListModel> list,
    required this.model,
    required this.tabIndex,
  }) : super(customerList: list);
}

/*------------------------CEP - Customer----------------------------------*/

/*------------------------CNPJ - Customer----------------------------------*/

/*------------------------POST - Customer----------------------------------*/
class PostByDesktopSuccessState extends CustomerRegisterState {
  PostByDesktopSuccessState({required super.customerList});
}

class PostByMobileSuccessState extends CustomerRegisterState {
  PostByMobileSuccessState({required super.customerList});
}

class PutByMobileSuccessState extends CustomerRegisterState {
  PutByMobileSuccessState({required super.customerList});
}

/*------------------------Getlist - Customer----------------------------------*/
class ListLoadedState extends CustomerRegisterState {
  final List<CustomerListModel> list;

  ListLoadedState({required this.list}) : super(customerList: list);
}

/*------------------------Getlist - State-------------------------------------*/
class GetStatesSuccessState extends CustomerRegisterState {
  final List<StateModel> states;

  GetStatesSuccessState(
      {required List<CustomerListModel> list, required this.states})
      : super(customerList: list);
}

/*------------------------Getlist - City-------------------------------------*/
class GetCitySuccessState extends CustomerRegisterState {
  final List<CityModel> cities;

  GetCitySuccessState(
      {required List<CustomerListModel> list, required this.cities})
      : super(customerList: list);
}

class ErrorState extends CustomerRegisterState {
  final String message;
  ErrorState({
    required this.message,
    required super.customerList,
  });
}
