import 'package:appweb/app/core/shared/utils/toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareMessages {
  static Future<bool> sendWhatsAppMessage(
      String phoneNumber, String message) async {
    final Uri url =
        Uri.parse('whatsapp://send?phone=$phoneNumber&text=$message');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return true;
    } else {
      CustomToast.showToast("WhatsApp não instalado");
      return false;
    }
  }

  static Future<bool> sendFile(String message, XFile file) async {
    return true;
  }
}
