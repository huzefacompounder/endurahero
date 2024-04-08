class LoginAndRegisterResponse {
  int? status;
  String? message;
  Data? data;

  LoginAndRegisterResponse({this.status, this.message, this.data});

  LoginAndRegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  String? username;
  String? userId;
  String? email;

  Data({this.token, this.username, this.userId, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    username = json['username'];
    userId = json['userId'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['username'] = username;
    data['userId'] = userId;
    data['email'] = email;
    return data;
  }
}
