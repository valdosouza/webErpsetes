import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/toast.dart';

import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:flutter/material.dart';

class CustomerRegisterAddressWidget extends StatefulWidget {
  final CustomerRegisterBloc bloc;
  final CustomerMainModel? customer;
  const CustomerRegisterAddressWidget({
    Key? key,
    required this.bloc,
    this.customer,
  }) : super(key: key);

  @override
  State<CustomerRegisterAddressWidget> createState() =>
      _CustomerRegisterAddressWidgetState();
}

class _CustomerRegisterAddressWidgetState
    extends State<CustomerRegisterAddressWidget> {
  var stateId = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInput(
              title: 'CEP',
              sufixIcon: IconButton(
                hoverColor: Colors.transparent,
                onPressed: () {
                  if (widget.bloc.customer.fiscal.objEntity.addressList[0]
                          .zipCode.length ==
                      8) {
                    widget.bloc.add(CepEvent(widget.bloc.customer.fiscal
                        .objEntity.addressList[0].zipCode));
                  } else {
                    CustomToast.showToast("CEP inválido.");
                  }
                },
                icon: const Icon(
                  Icons.search,
                  size: 20.0,
                  color: Colors.white,
                ),
              ),
              initialValue:
                  widget.customer?.fiscal.objEntity.addressList[0].zipCode,
              keyboardType: TextInputType.number,
              inputAction: TextInputAction.next,
              onChanged: (value) {
                widget.customer?.fiscal.objEntity.addressList[0].zipCode =
                    value;
              },
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "UF",
                  style: kLabelStyle,
                ),
                const SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.bloc.customer.fiscal.objEntity
                                  .addressList[0].stateName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            hoverColor: Colors.transparent,
                            onPressed: () {
                              widget.bloc.add(GetStatesEvent());
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cidade",
                  style: kLabelStyle,
                ),
                const SizedBox(height: 10.0),
                Container(
                    alignment: Alignment.centerLeft,
                    decoration: kBoxDecorationStyle,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.bloc.customer.fiscal.objEntity
                                  .addressList[0].cityName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            hoverColor: Colors.transparent,
                            onPressed: () {
                              widget.bloc.add(GetCitysEvent(widget.bloc.customer
                                  .fiscal.objEntity.addressList[0].tbStateId));
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(height: 10.0),
            CustomInput(
              title: 'Logradouro',
              initialValue:
                  widget.customer?.fiscal.objEntity.addressList[0].street,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              onChanged: (value) {
                widget.customer?.fiscal.objEntity.addressList[0].street = value;
              },
            ),
            const SizedBox(height: 10.0),
            CustomInput(
              title: 'Número',
              initialValue:
                  widget.customer?.fiscal.objEntity.addressList[0].nmbr,
              keyboardType: TextInputType.number,
              inputAction: TextInputAction.next,
              onChanged: (value) {
                widget.customer?.fiscal.objEntity.addressList[0].nmbr = value;
              },
            ),
            const SizedBox(height: 10.0),
            CustomInput(
              title: 'Complemento',
              initialValue:
                  widget.customer?.fiscal.objEntity.addressList[0].complement,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              onChanged: (value) {
                widget.customer?.fiscal.objEntity.addressList[0].complement =
                    value;
              },
            ),
            const SizedBox(height: 10.0),
            CustomInput(
              title: 'Bairro',
              initialValue:
                  widget.customer?.fiscal.objEntity.addressList[0].neighborhood,
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.done,
              onChanged: (value) {
                widget.customer?.fiscal.objEntity.addressList[0].neighborhood =
                    value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
