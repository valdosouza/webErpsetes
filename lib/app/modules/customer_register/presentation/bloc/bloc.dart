import 'package:appweb/app/core/shared/utils/validators.dart';
import 'package:appweb/app/modules/Core/data/model/city_model.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/sales_route_list_model.dart';
import 'package:appweb/app/modules/Core/data/model/state_model.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_cep.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_citys.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_cnpj.dart';
import 'package:appweb/app/modules/Core/domain/usecase/get_states.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/post.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/state.dart';
import 'package:bloc/bloc.dart';

class CustomerRegisterBloc
    extends Bloc<CustomerRegisterEvent, CustomerRegisterState> {
  final GetList getList;
  final GetCep getCep;
  final GetCities getCity;
  final GetCnpj getCnpj;
  final GetStates getStates;
  final Get get;
  final Post post;

  List<CustomerListModel> list = [];
  CustomerMainModel customer = CustomerMainModel.empty();
  List<StateModel> states = [];
  List<CityModel> cities = [];
  List<SalesRouteListModel> salesRoute = [];
  int tabIndex = 0;
  int page = 0;
  String search = "";
  CustomerRegisterBloc({
    required this.getList,
    required this.getCep,
    required this.getCity,
    required this.getCnpj,
    required this.getStates,
    required this.get,
    required this.post,
  }) : super(LoadingState()) {
    _getList();

    _searchList();

    _goToDesktopPage();

    _newMobilePage();

    _getMobilePage();

    searchCEP();

    searchCNPJ();

    getState();

    getCitys();

    searchEventStates();

    searchEventCitys();

    _postByMobile();

    _postByDesktop();

    on<ReturnEvent>((event, emit) => emit(
        InfoPageState(model: customer, list: list, tabIndex: event.index)));
  }

  _getList() {
    on<GetListEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        list.clear();
        page = 1;
      } else {
        page += 1;
      }
      event.params.page = page;
      var response = await getList.call(event.params);

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        list += r;
        emit(ListLoadedState(list: list));
      });
    });
  }

  _searchList() {
    on<SearchEvent>((event, emit) async {
      emit(LoadingState());
      if (event.params.page == 0) {
        list.clear();
        page = 1;
      } else {
        page += 1;
      }
      event.params.page = page;
      var response = await getList.call(event.params);

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        list = r;
        emit(ListLoadedState(list: list));
      });
    });
  }

  Future<String?> _validadePostCustomer() async {
    tabIndex = 0;
    String? error = "";
    if ((customer.fiscal.company?.cnpj != "") &&
        (customer.fiscal.company?.cnpj != null)) {
      error = Validators.validateCNPJ(customer.fiscal.company?.cnpj);
      if (error!.isNotEmpty) {
        return error;
      }
    }
    if ((customer.fiscal.person?.cpf != "") &&
        (customer.fiscal.person?.cpf != null)) {
      error = Validators.validateCPF(customer.fiscal.person!.cpf);
      if ((error != "") || (error != null)) {
        return error;
      }
    }
    if (customer.fiscal.objEntity.entity.nameCompany.isEmpty) {
      return "Campo Nome/Razão é Obrigatório";
    }
    if (customer.fiscal.objEntity.entity.nickTrade.isEmpty) {
      return "Campo Apelido/Nome Fantasia";
    }
    tabIndex = 1;
    if (customer.fiscal.objEntity.addressList[0].zipCode.length < 8) {
      return "Campo Cep não é valido ";
    }
    if (customer.fiscal.objEntity.addressList[0].street.length < 3) {
      return "Campo logradouro não é valido ";
    }
    if (customer.fiscal.objEntity.addressList[0].nmbr.isEmpty) {
      return "Campo número não é valido ";
    }
    if (customer.fiscal.objEntity.addressList[0].neighborhood.isEmpty) {
      return "Campo bairro não é valido ";
    }
    if (customer.fiscal.objEntity.addressList[0].neighborhood.isEmpty) {
      return "Campo bairro não é valido ";
    }
    return "";
  }

  _postByMobile() async {
    on<PostByMobileEvent>((event, emit) async {
      emit(LoadingState());
      String? errorValidate = await _validadePostCustomer();
      if (errorValidate!.isNotEmpty) {
        emit(ErrorState(message: errorValidate, customerList: list));
      } else {
        var response =
            await post.call(ParamsPostCustomer(customer: event.model));

        response.fold((l) {
          emit(ErrorState(message: l.toString(), customerList: list));
        }, (r) {
          if (r.error == "") {
            if (event.model.fiscal.objEntity.entity.id != 0) {
              int index = list.indexWhere((element) => element.id == r.id);
              if (index != -1) {
                list[index] = r;
              }
              emit(PutByMobileSuccessState(customerList: list));
            } else {
              list.add(r);
              emit(PostByMobileSuccessState(customerList: list));
            }
          } else {
            emit(ErrorState(message: r.toString(), customerList: list));
          }
        });
      }
    });
  }

  _postByDesktop() {
    on<PostByDesktopEvent>((event, emit) async {
      emit(LoadingState());

      var response = await post.call(ParamsPostCustomer(customer: event.model));

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        if (r.error == "") {
          if (event.model.fiscal.objEntity.entity.id != 0) {
            list[list.indexWhere((element) => element.id == r.id)] = r;
          } else {
            list.add(r);
          }
          emit(PostByDesktopSuccessState(customerList: list));
        } else {
          emit(ErrorState(message: r.error, customerList: list));
        }
      });
    });
  }

  _goToDesktopPage() {
    on<DesktopEvent>((event, emit) async {
      if (event.id != null) {
        emit(LoadingState());

        final response = await get.call(ParamsGetCustomer(id: event.id!));

        response.fold(
            (l) => emit(ErrorState(message: l.toString(), customerList: list)),
            (r) {
          customer = r;
          emit(InfoPageState(list: list, model: r, tabIndex: 0));
        });
      } else {
        emit(InfoPageState(list: list, model: customer, tabIndex: 0));
      }
    });
  }

  _getMobilePage() {
    on<MobileEditEvent>((event, emit) async {
      emit(LoadingState());

      final response =
          await get.call(ParamsGetCustomer(id: event.tbCustomerId));

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        customer = r;
        emit(InfoPageState(list: list, model: r, tabIndex: 0));
      });
    });
  }

  _newMobilePage() {
    on<MobileNewEvent>((event, emit) async {
      emit(LoadingState());
      customer = CustomerMainModel.empty();
      emit(InfoPageState(list: list, model: customer, tabIndex: 0));
    });
  }

  searchCNPJ() {
    on<CnpjEvent>((event, emit) async {
      emit(LoadingState());

      final response = await getCnpj.call(ParamsCnpj(cnpj: event.cnpj));

      response.fold((l) {
        emit(ErrorState(message: l.toString(), customerList: list));
        emit(InfoPageState(list: list, model: customer, tabIndex: 0));
      }, (r) {
        customer.fiscal.objEntity.addressList[0].zipCode =
            r.zipCode.replaceAll("-", "").replaceAll(".", "");
        if (r.nickTtrade.isNotEmpty) {
          customer.fiscal.objEntity.entity.nickTrade = r.nickTtrade;
        } else {
          customer.fiscal.objEntity.entity.nickTrade = r.nameCompany;
        }
        customer.fiscal.company?.cnpj = r.cnpj;
        customer.fiscal.objEntity.entity.nameCompany = r.nameCompany;
        customer.fiscal.objEntity.addressList[0].nmbr = r.nmbr;
        customer.fiscal.objEntity.addressList[0].street = r.street;
        customer.fiscal.objEntity.addressList[0].complement = r.complement;
        customer.fiscal.objEntity.addressList[0].neighborhood = r.neighborhood;
        customer.fiscal.objEntity.addressList[0].cityName = r.cityName;
        customer.fiscal.objEntity.addressList[0].tbCityId = r.tbCityId;
        customer.fiscal.objEntity.addressList[0].stateName = r.stateName;
        customer.fiscal.objEntity.addressList[0].tbStateId = r.tbStateId;
        customer.fiscal.objEntity.addressList[0].kind = "Comercial";
        customer.fiscal.objEntity.addressList[0].tbCountryId = 1058;
        emit(InfoPageState(list: list, model: customer, tabIndex: 0));
      });
    });
  }

  searchCEP() {
    on<CepEvent>((event, emit) async {
      emit(LoadingState());

      final response = await getCep.call(ParamsCep(cep: event.cep));

      response.fold((l) {
        emit(ErrorState(message: l.toString(), customerList: list));
        emit(InfoPageState(list: list, model: customer, tabIndex: 1));
      }, (r) {
        customer.fiscal.objEntity.addressList[0].zipCode =
            r.zipCode.replaceAll("-", "");
        customer.fiscal.objEntity.addressList[0].street = r.street;
        customer.fiscal.objEntity.addressList[0].complement = r.complement;
        customer.fiscal.objEntity.addressList[0].neighborhood = r.neighborhood;
        customer.fiscal.objEntity.addressList[0].stateName = r.stateName;
        customer.fiscal.objEntity.addressList[0].tbStateId = r.tbStateId;
        customer.fiscal.objEntity.addressList[0].cityName = r.cityName;
        customer.fiscal.objEntity.addressList[0].tbCityId = r.tbCityId;
        customer.fiscal.objEntity.addressList[0].kind = "Comercial";
        customer.fiscal.objEntity.addressList[0].tbCountryId = 1058;
        emit(InfoPageState(list: list, model: customer, tabIndex: 1));
      });
    });
  }

  getState() {
    on<GetStatesEvent>((event, emit) async {
      emit(LoadingState());

      final response = await getStates.call(ParamsGetStates());

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        states = r;
        emit(GetStatesSuccessState(states: states, list: list));
      });
    });
  }

  getCitys() {
    on<GetCitysEvent>((event, emit) async {
      emit(LoadingState());

      final response =
          await getCity.call(ParamsGetCity(tbStateId: event.tbStateId));

      response.fold(
          (l) => emit(ErrorState(message: l.toString(), customerList: list)),
          (r) {
        cities = r;
        emit(GetCitySuccessState(cities: cities, list: list));
      });
    });
  }

  searchEventStates() {
    on<SearchStateEvent>((event, emit) async {
      if (event.search.isNotEmpty) {
        var statestSearched = states.where((element) {
          String name = element.name;
          return name
              .toLowerCase()
              .trim()
              .contains(event.search.toLowerCase().trim());
        }).toList();
        if (statestSearched.isEmpty) {}
        emit(GetStatesSuccessState(states: statestSearched, list: list));
      } else {
        emit(GetStatesSuccessState(states: states, list: list));
      }
    });
  }

  searchEventCitys() {
    on<SearchCityEvent>((event, emit) async {
      if (event.search.isNotEmpty) {
        var citiestSearched = cities.where((element) {
          String name = element.name;
          return name
              .toLowerCase()
              .trim()
              .contains(event.search.toLowerCase().trim());
        }).toList();
        if (citiestSearched.isEmpty) {}
        emit(GetCitySuccessState(cities: citiestSearched, list: list));
      } else {
        emit(GetCitySuccessState(cities: cities, list: list));
      }
    });
  }
}
