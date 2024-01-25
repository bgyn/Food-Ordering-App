import 'package:food_app/core/utils/alert_dialog_model.dart';

class LogOutDialog extends AlertDialogModel<bool> {
  const LogOutDialog()
      : super(
          title: 'LogOut',
          message: 'Are you sure you want to logout from this app',
          buttons: const {
            'Cancel': false,
            'Logout': true,
          },
        );
}
