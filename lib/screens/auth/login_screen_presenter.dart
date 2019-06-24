import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/user.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = RestDatasource();
  LoginScreenPresenter(this._view);

  doLogin(String email, String password) async {
    api.login(email, password).then((u) {
      _view.onLoginSuccess(u);
    }).catchError((e) {
      _view.onLoginError(e.message);
    });
  }
}