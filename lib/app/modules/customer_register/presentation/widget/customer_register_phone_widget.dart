import 'package:appweb/app/core/shared/widgets/custom_input.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

class CustomerRegisterPhoneWidget extends StatelessWidget {
  final CustomerRegisterBloc bloc;
  final CustomerMainModel? customer;
  const CustomerRegisterPhoneWidget({
    super.key,
    this.customer,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInput(
            title: 'Telefone',
            initialValue: customer?.fiscal.objEntity.phoneList[0]?.number,
            keyboardType: TextInputType.number,
            inputAction: TextInputAction.next,
            onChanged: (value) {
              customer?.fiscal.objEntity.phoneList[0]?.number = value;
            },
          ),
        ],
      ),
    );
  }
}
