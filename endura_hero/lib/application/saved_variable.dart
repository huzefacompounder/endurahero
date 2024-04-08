import 'package:endura_hero/application/api_strings.dart';
import 'package:get_storage/get_storage.dart';

storeAuthName(String name) {
  GetStorage().write(authName, name);
}

///
/// Get Stored User Auth Token
///
storeAuthToken(String token) {
  GetStorage().write(authToken, token);
}

String getAuthToken() {
  return GetStorage().read(authToken) ?? '';
}

///
/// Get Stored User ID
///
String getUserId() {
  return GetStorage().read(userId) ?? '';
}

storUserId(String id) {
  GetStorage().write(userId, id);
}

getLoginActivity() {
  return GetStorage().read(userLogin);
}

String getUserProfileImagePath() {
  return GetStorage().read(profileImage) ?? '';
}

storeUserProfileImage(String getPath) {
  GetStorage().write(profileImage, getPath);
}

///
/// Get Stored User Name
//
Future<void> storeUserName(String name) async {
  await GetStorage().write(userName, name);
}

getUserName() {
  return GetStorage().read(userName);
}
