import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/modules/Core/data/model/customer_list_model.dart';
import 'package:appweb/app/modules/customer_register/domain/usecase/get_list.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/state.dart';
import 'package:flutter/material.dart';

statesCustomer(CustomerRegisterState state) {
  if (state is ErrorState) {
    CustomToast.showToast(state.message);
  } else if (state is ErrorState) {
    CustomToast.showToast(state.message);
  } else if ((state is PostByDesktopSuccessState) ||
      (state is PostByMobileEvent)) {
    CustomToast.showToast("Cadastro atualizado com sucesso.");
  } else if (state is ErrorState) {
    CustomToast.showToast(state.message);
  } else if (state is ErrorState) {
    CustomToast.showToast(state.message);
  }
}

buildSearchInput(CustomerRegisterBloc bloc) {
  return Container(
    decoration: kBoxDecorationStyle,
    child: TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) {
        bloc.add(SearchEvent(
          params: ParamsList(
            tbInstitutionId: 0,
            tbSalesmanId: 0,
            page: 0,
            id: 0,
            nameCustomer: bloc.search,
          ),
        ));
      },
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(left: 10.0),
        hintText: "Pesquise seu cliente por nome, cnpj ou cpf",
        hintStyle: kHintTextStyle,
      ),
    ),
  );
}

buildListView(CustomerRegisterBloc bloc, List<CustomerListModel> customers) {
  return Expanded(
    child: customers.isEmpty
        ? const Center(
            child: Text("Não encontramos nenhum registro em nossa base."))
        : ListView.separated(
            itemCount: customers.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                bloc.add(DesktopEvent(id: customers[index].id));
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: (Colors.black),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Text(
                      (index + 1).toString(),
                      style: kCircleAvatarTextStyle,
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nome: ${customers[index].nickTrade}"),
                    const SizedBox(height: 5.0),
                    customers[index].docKind == "J"
                        ? Text("CNPJ: ${customers[index].docNumber}")
                        : Text("CPF: ${customers[index].docNumber}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove, color: kSecondaryColor),
                  onPressed: () {
                    CustomToast.showToast("Funcionalidade em desenvolvimento.");
                  },
                ),
              ),
            ),
            separatorBuilder: (_, __) => const Divider(),
          ),
  );
}
