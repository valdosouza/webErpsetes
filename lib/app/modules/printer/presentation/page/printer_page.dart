import 'dart:convert';

import 'package:appweb/app/core/shared/helpers/local_storage.dart';
import 'package:appweb/app/core/shared/local_storage_key.dart';
import 'package:appweb/app/core/shared/theme.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PrinterPage extends StatefulWidget {
  const PrinterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends State<PrinterPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice? _device;

  String tips = 'Nenhuma impressora conectada';
  final f = NumberFormat("#.00", "pt_BR");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: const Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Conectado com sucesso';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Desconectado com sucesso';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const Text('Selecione a impressora'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Modular.to.navigate('/home/');
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              const Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                stream: bluetoothPrint.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                            title: Text(d.name ?? ''),
                            subtitle: Text(d.address ?? ''),
                            onTap: () async {
                              setState(() {
                                _device = d;
                                LocalStorageService.instance.saveItem(
                                  key: LocalStorageKey.blthPrinter,
                                  value: json.encode(d.toJson()),
                                );
                                d.toJson();
                              });
                            },
                            trailing:
                                _device != null && _device!.address == d.address
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : null,
                          ))
                      .toList(),
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'Connectando...';
                                    });
                                    await bluetoothPrint.connect(_device!);
                                  } else {
                                    setState(() {
                                      tips = 'Por favor seleciona a Impressora';
                                    });
                                  }
                                },
                          child: const Text('Conectar'),
                        ),
                        const SizedBox(width: 10.0),
                        OutlinedButton(
                          onPressed: _connected
                              ? () async {
                                  setState(() {
                                    tips = 'disconnectando...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                          child: const Text('Desconectar'),
                        ),
                      ],
                    ),
                    const Divider(),
                    OutlinedButton(
                      onPressed: _connected
                          ? () async {
                              Map<String, dynamic> config = {};

                              config['width'] = 40; // 标签宽度，单位mm
                              config['height'] = 70; // 标签高度，单位mm
                              config['gap'] = 2;
                              List<LineText> list = [];

                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: '********************************',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1));

                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: 'Teste de impressao',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1));
                              list.add(LineText(linefeed: 1));

                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: 'Executado com sucesso!',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  linefeed: 1));
                              list.add(LineText(
                                  type: LineText.TYPE_TEXT,
                                  content: 'Impressora selecionada',
                                  weight: 1,
                                  align: LineText.ALIGN_CENTER,
                                  x: 0,
                                  relativeX: 0,
                                  linefeed: 0));

                              await bluetoothPrint.printReceipt(config, list);
                            }
                          : null,
                      child: const Text('Teste de impressão'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              onPressed: () => bluetoothPrint.stopScan(),
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => bluetoothPrint.startScan(
                    timeout: const Duration(seconds: 4)));
          }
        },
      ),
    );
  }
}
