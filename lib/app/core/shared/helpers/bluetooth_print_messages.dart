import 'package:flutter/services.dart';

/// Mensagem amigável para erros do plugin [bluetooth_print_v2] (Android/iOS).
String bluetoothPrintUserMessage(PlatformException e) {
  final code = e.code.toLowerCase();
  final msg = (e.message ?? '').toLowerCase();
  if (code.contains('not connect') || msg.contains('state not right')) {
    return 'Impressora não conectada. Ligue a impressora, emparelhe e conecte no menu Impressora.';
  }
  final detail = e.message;
  if (detail != null && detail.isNotEmpty) {
    return 'Impressora: $detail';
  }
  return 'Não foi possível comunicar com a impressora.';
}
