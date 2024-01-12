import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/customer_register/data/model/customer_main_model.dart';
import 'package:appweb/app/modules/customer_register/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

class CustomerRegisterOthersDesktopWidget extends StatefulWidget {
  final CustomerRegisterBloc bloc;
  final CustomerMainModel? customer;
  const CustomerRegisterOthersDesktopWidget({
    Key? key,
    required this.bloc,
    this.customer,
  }) : super(key: key);

  @override
  State<CustomerRegisterOthersDesktopWidget> createState() =>
      _CustomerRegisterOthersDesktopWidgetState();
}

class _CustomerRegisterOthersDesktopWidgetState
    extends State<CustomerRegisterOthersDesktopWidget> {
  @override
  Widget build(BuildContext context) {
    bool active = (widget.customer?.customer.active == "S");
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ativo", style: kLabelStyle),
          const SizedBox(height: 0.0),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: active,
                    activeColor: Colors.red,
                    onChanged: active
                        ? (value) {}
                        : (value) {
                            setState(() {
                              active = true;
                            });
                            widget.customer?.customer.active = "S";
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
                      groupValue: active,
                      activeColor: Colors.red,
                      onChanged: active
                          ? (value) {
                              setState(() {
                                active = false;
                              });
                              widget.customer?.customer.active = "N";
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
    );
  }
}
