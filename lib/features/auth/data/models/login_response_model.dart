class LoginResponseModel {
  final String? token;

  LoginResponseModel({this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(token: json['token']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
