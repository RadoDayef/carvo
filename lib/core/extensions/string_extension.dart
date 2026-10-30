import 'package:carvo/app/theming/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringExtension on String {
  String get filterUrl {
    String fullPath = "";
    String duplicatedUrl = "";
    List<String> urlStrings = split("/");
    for (int index = 0; index < urlStrings.length; index++) {
      if (duplicatedUrl != urlStrings[index]) {
        if (fullPath.isNotEmpty) {
          fullPath += "/";
        }
        fullPath += urlStrings[index];
        duplicatedUrl = urlStrings[index];
      }
    }
    return fullPath;
  }

  Future<bool?> get showToast => Fluttertoast.showToast(msg: this, timeInSecForIosWeb: 4, backgroundColor: AppColors.lightDarkBlue, textColor: AppColors.white);
}
