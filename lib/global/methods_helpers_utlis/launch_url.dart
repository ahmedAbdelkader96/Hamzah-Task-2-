import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';




class LaunchUrl{



  static Future<void> launchWebPreviewUrl(String link  )async {
    await launchUrlString(link);

    // final Uri _url = Uri.parse(link);
    // if (await canLaunchUrl(_url)) {
    //   await launchWebPreviewUrl(link);
    // } else {
    //   throw "Could not launch $_url";
    // }

  }


  static Future<void> thisUrl(String link , LaunchMode mode)async {


    var url = Uri.parse(link);
    if (await launchUrl(url, mode: LaunchMode.externalApplication,)) {
      print("Success $url");
    }else {
      throw 'Could not launch $url';
    }

  }

  static Future<void> thisEmail(String email)async {
    String encodeQueryParameters(
        Map<String, String> params) {
      return params.entries
          .map((e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<
          String,
          String>{'subject': ''}),
    );
    launchUrl(emailLaunchUri);
  }


  static  Future<void> thisPhone(String phone)async {
    await canLaunchUrl((Uri.parse(
        "tel://${phone}")))
        ? await launchUrl(Uri.parse(
        "tel://${phone}"))
        : throw 'Could not launch';
}


}