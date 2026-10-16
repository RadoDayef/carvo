import 'package:carvo/app/theming/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StringExtension on String {
  Future<bool?> get showToast => Fluttertoast.showToast(msg: this, timeInSecForIosWeb: 4, backgroundColor: AppColors.lightDarkBlue, textColor: AppColors.white);
}
