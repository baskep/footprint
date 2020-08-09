class LoginFormDataModel {
  String mobile = '';
  String password = '';
  String verifyCode = '';
  String invitionCode = '';

  LoginFormDataModel(this.mobile, this.password, this.verifyCode, this.invitionCode);

  @override
  String toString() {
    return ' \n$mobile:$mobile,\n$password:$password,\n$verifyCode:$verifyCode,\n$invitionCode:$invitionCode\nnext:/';
  }

}
