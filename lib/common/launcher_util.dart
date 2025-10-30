import 'package:url_launcher/url_launcher.dart';

class LauncherUtil {
  LauncherUtil._();

  static Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  static Future<bool> sendEmail(String email, {String? subject, String? body}) async {
    final uri = Uri(scheme: 'mailto', path: email, queryParameters: {
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
    });
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}


