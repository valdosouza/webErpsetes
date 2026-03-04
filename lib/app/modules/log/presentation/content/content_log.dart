import 'dart:io';

import 'package:appweb/app/core/shared/theme.dart';
import 'package:appweb/app/modules/log/data/model/log_model.dart';
import 'package:appweb/app/modules/log/presentation/bloc/bloc.dart';
import 'package:appweb/app/modules/log/presentation/bloc/event.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ContentLog extends StatefulWidget {
  final List<LogModel> listLog;
  const ContentLog({
    super.key,
    required this.listLog,
  });

  @override
  State<ContentLog> createState() => _ContentLogState();
}

class _ContentLogState extends State<ContentLog> {
  late final LogBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = Modular.get<LogBloc>();
  }

  void _onShareLog(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final files = <XFile>[];
    Directory dir = await getApplicationDocumentsDirectory();
    files.add(XFile('${dir.path}/app_logs.json', name: 'app_logs.json'));
    ShareResult shareResult;
    shareResult = await SharePlus.instance.share(ShareParams(
        files: files,
        text: 'Arquivo de Log',
        subject: 'Logs',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size));
    scaffoldMessenger.showSnackBar(getResultSnackBar(shareResult));
  }

  SnackBar getResultSnackBar(ShareResult result) {
    return SnackBar(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Resultado: ${result.status}"),
          if (result.status == ShareResultStatus.success)
            Text("Compartilhado: ${result.raw}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: kBoxDecorationflexibleSpace,
        ),
        title: const AutoSizeText(
          'Registro de atividades',
          maxFontSize: 14,
          minFontSize: 8,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Modular.to.navigate('/home/');
          },
        ),
      ),
      body: buildListView(size),
      bottomSheet: _footer(),
    );
  }

  SizedBox buildListView(Size size) {
    return SizedBox(
      height: size.height - 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.listLog.isEmpty
            ? const Center(
                child: Text("Não encontramos nenhum registro em nossa base."))
            : ListView.separated(
                itemCount: widget.listLog.length,
                itemBuilder: (context, index) => InkWell(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _fields('Data      :', widget.listLog[index].tmRecord!),
                        _fields(
                            'Interface :', widget.listLog[index].interfaceName),
                        _fields('Operação  :', widget.listLog[index].operation),
                        _fields('Referência:', widget.listLog[index].reference),
                        _fields('Observação:', widget.listLog[index].note),
                      ]),
                ),
                separatorBuilder: (_, __) =>
                    const Divider(height: 3, color: kPrimaryColor),
              ),
      ),
    );
  }

  SizedBox _fields(String label, String field) {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(label),
          ),
          Expanded(
            flex: 3,
            child: Text(field),
          ),
        ],
      ),
    );
  }

  Row _footer() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 60),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () async {
                _onShareLog(context);
                //bloc.add(SendLogEvent());
              },
              child: const Text(
                'Enviar Lista',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(100, 60),
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              onPressed: () {
                bloc.add(DeleteLogEvent());
              },
              child: const Text(
                'Limpar Lista',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
