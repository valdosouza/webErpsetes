import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:appweb/app/core/shared/utils/validators.dart';
import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/collaborator_register/presentation/bloc/collaborator_register_bloc.dart';
import 'package:appweb/app/modules/collaborator_register/presentation/bloc/collaborator_register_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorRegisterIdentificationWidget extends StatefulWidget {
  const CollaboratorRegisterIdentificationWidget({super.key});

  @override
  State<CollaboratorRegisterIdentificationWidget> createState() =>
      _CollaboratorRegisterIdentificationWidgetState();
}

class _CollaboratorRegisterIdentificationWidgetState
    extends State<CollaboratorRegisterIdentificationWidget> {
  bool selectPersonType = false;
  bool selectWallet = false;

  late final CollaboratorRegisterBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<CollaboratorRegisterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tipo de Pessoa", style: kLabelStyle),
          const SizedBox(height: 10.0),
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
              const SizedBox(width: 10.0),
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
          const SizedBox(height: 30.0),
          selectPersonType ? _buildCompany() : _buildPerson(),
          const SizedBox(height: 30.0),
          CustomInput(
            title: 'e-mail* (não poderá ser alterado neste canal)',
            readOnly: (bloc.model.fiscal.objEntity.entity.id > 0),
            initialValue: bloc.model.userEmail.email,
            keyboardType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            onChanged: (value) {
              bloc.model.userEmail.email = value;
            },
          ),
        ],
      ),
    );
  }

  Column _buildCompany() {
    bloc.model.fiscal.person?.id = 0;
    bloc.model.fiscal.person?.cpf = "";
    return Column(
      children: [
        CustomInput(
          title: 'CNPJ',
          initialValue: bloc.model.fiscal.company?.cnpj,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          sufixIcon: IconButton(
            hoverColor: Colors.transparent,
            onPressed: () {
              if (bloc.model.fiscal.company?.cnpj.length == 14) {
                bloc.add(CollaboratorRegisterCnpjEvent(
                    bloc.model.fiscal.company!.cnpj));
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
          validator: (value) => Validators.validateCNPJ(value),
          onChanged: (value) {
            bloc.model.fiscal.company?.cnpj = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'Nome/Razão Social',
          initialValue: bloc.model.fiscal.objEntity.entity.nameCompany,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          validator: (value) => Validators.validateRequired(value),
          onChanged: (value) {
            bloc.model.fiscal.objEntity.entity.nameCompany = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'Nome Fantasia',
          initialValue: bloc.model.fiscal.objEntity.entity.nickTrade,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          validator: (value) => Validators.validateRequired(value),
          onChanged: (value) {
            bloc.model.fiscal.objEntity.entity.nickTrade = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'Inscrição Estadual',
          initialValue: bloc.model.fiscal.company?.ie,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.done,
          onChanged: (value) {
            bloc.model.fiscal.company?.ie = value;
          },
        ),
      ],
    );
  }

  Column _buildPerson() {
    bloc.model.fiscal.company?.id = 0;
    bloc.model.fiscal.company?.cnpj = "";
    return Column(
      children: [
        CustomInput(
          title: 'CPF',
          initialValue: bloc.model.fiscal.person?.cpf,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            bloc.model.fiscal.person?.cpf = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'Nome',
          initialValue: bloc.model.fiscal.objEntity.entity.nameCompany,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            bloc.model.fiscal.objEntity.entity.nameCompany = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'Apelido',
          initialValue: bloc.model.fiscal.objEntity.entity.nickTrade,
          keyboardType: TextInputType.text,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            bloc.model.fiscal.objEntity.entity.nickTrade = value;
          },
        ),
        const SizedBox(height: 30.0),
        CustomInput(
          title: 'R.G',
          initialValue: bloc.model.fiscal.person?.rg,
          keyboardType: TextInputType.number,
          inputAction: TextInputAction.next,
          onChanged: (value) {
            bloc.model.fiscal.person?.rg = value;
          },
        ),
      ],
    );
  }
}
