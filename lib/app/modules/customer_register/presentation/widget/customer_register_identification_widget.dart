import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/event.dart';
import 'package:flutter/material.dart';

class CustomerRegisterIdentificationWidget extends StatefulWidget {
  final CustomerRegisterBloc bloc;
  final CustomerMainModel? customer;
  const CustomerRegisterIdentificationWidget({
    super.key,
    required this.bloc,
    this.customer,
  });

  @override
  State<CustomerRegisterIdentificationWidget> createState() =>
      _CustomerRegisterIdentificationWidgetState();
}

class _CustomerRegisterIdentificationWidgetState
    extends State<CustomerRegisterIdentificationWidget> {
  bool selectPersonType = false;
  bool selectWallet = false;
  @override
  void initState() {
    super.initState();
    selectPersonType = widget.customer?.fiscal.company?.cnpj.isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tipo de Pessoa", style: kLabelStyle),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: selectPersonType,
                      activeColor: Colors.red,
                      onChanged: selectPersonType
                          ? (value) {}
                          : (value) {
                              setState(() {
                                selectPersonType = true;
                              });
                            },
                    ),
                    const SizedBox(width: 5.0),
                    const Text("Jurídica", style: kLabelStyle),
                  ],
                ),
                const SizedBox(width: 5.0),
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: selectPersonType,
                        activeColor: Colors.red,
                        onChanged: selectPersonType
                            ? (value) {
                                setState(() {
                                  selectPersonType = false;
                                });
                              }
                            : (value) {}),
                    const SizedBox(width: 5.0),
                    const Text("Física", style: kLabelStyle),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            selectPersonType ? _buildCompany() : _buildPerson(),
            const SizedBox(height: 10.0),
            const Text("Consumidor Final", style: kLabelStyle),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: selectWallet,
                      activeColor: Colors.red,
                      onChanged: selectWallet
                          ? (value) {}
                          : (value) {
                              setState(() {
                                selectWallet = true;
                              });
                              widget.customer?.customer.consumer = "S";
                            },
                    ),
                    const SizedBox(width: 5.0),
                    const Text("Sim", style: kLabelStyle),
                  ],
                ),
                const SizedBox(width: 10.0),
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: selectWallet,
                        activeColor: Colors.red,
                        onChanged: selectWallet
                            ? (value) {
                                setState(() {
                                  selectWallet = false;
                                });
                                widget.customer?.customer.consumer = "N";
                              }
                            : (value) {}),
                    const SizedBox(width: 5.0),
                    const Text("Não", style: kLabelStyle),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column _buildCompany() {
    return Column(
      children: [
        CustomInput(
          title: 'CNPJ',
          initialValue: widget.customer?.fiscal.company?.cnpj,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          sufixIcon: IconButton(
            hoverColor: Colors.transparent,
            onPressed: () {
              if (widget.customer?.fiscal.company?.cnpj.length == 14) {
                widget.bloc
                    .add(CnpjEvent(widget.customer!.fiscal.company!.cnpj));
              } else {
                CustomToast.showToast("CNPJ inválido.");
              }
            },
            icon: const Icon(
              Icons.search,
              size: 20.0,
              color: Colors.white,
            ),
          ),
          onChanged: (value) {
            widget.customer?.fiscal.person?.cpf = "";
            widget.customer?.fiscal.company?.cnpj = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'Nome/Razão Social',
          initialValue: widget.customer?.fiscal.objEntity.entity.nameCompany,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.objEntity.entity.nameCompany = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'Nome Fantasia',
          initialValue: widget.customer?.fiscal.objEntity.entity.nickTrade,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.objEntity.entity.nickTrade = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'Inscrição Estadual',
          initialValue: widget.customer?.fiscal.company?.ie,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.done,
          onChanged: (value) {
            widget.customer?.fiscal.company?.ie = value;
          },
        ),
      ],
    );
  }

  Column _buildPerson() {
    return Column(
      children: [
        CustomInput(
          title: 'CPF',
          initialValue: widget.customer?.fiscal.person?.cpf,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.company?.cnpj = "";
            widget.customer?.fiscal.person?.cpf = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'Nome',
          initialValue: widget.customer?.fiscal.objEntity.entity.nameCompany,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.objEntity.entity.nameCompany = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'Apelido',
          initialValue: widget.customer?.fiscal.objEntity.entity.nickTrade,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.objEntity.entity.nickTrade = value;
          },
        ),
        const SizedBox(height: 10.0),
        CustomInput(
          title: 'R.G',
          initialValue: widget.customer?.fiscal.person?.rg,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            widget.customer?.fiscal.person?.rg = value;
          },
        ),
      ],
    );
  }
}
