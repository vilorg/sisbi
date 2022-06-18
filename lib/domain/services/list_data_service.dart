import 'package:sisbi/domain/data_providers/list_media_data_provider.dart';
import 'package:sisbi/domain/data_providers/session_data_provider.dart';
import 'package:sisbi/models/object_id.dart';

class ListDataService {
  final ListMediaDataProvider _mediaDataProvider = ListMediaDataProvider();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<List<ObjectId>> getCities(String s) async {
    final String token = await _sessionDataProvider.getUserToken();
    return await _mediaDataProvider.getCities(token, s);
  }

  Future<List<ObjectId>> getJobCategories() async {
    final String token = await _sessionDataProvider.getUserToken();
    return await _mediaDataProvider.getJobCategories(token);
  }
}
