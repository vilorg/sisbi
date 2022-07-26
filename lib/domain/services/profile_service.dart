import 'package:http/http.dart' as http;
import 'package:sisbi/domain/data_providers/card_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/user_data_model.dart';

class ProfileService {
  final SessionDataProvider _sessionProvider = SessionDataProvider();
  final CardMediaDataProvider _mediaProvider = CardMediaDataProvider();

  Future<UserDataModel> getUserData() async {
    String token = await _sessionProvider.getUserToken();
    return await _mediaProvider.getUserData(token);
  }

  Future<void> logout() async => await _sessionProvider.logout();
}
