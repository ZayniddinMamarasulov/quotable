import 'package:quotable/model/quote.dart';

import '../../core/base_service.dart';
import '../services/random_service.dart';

class RandomRepository {
  final BaseService _randomService = RandomService();

  Future<Quote> fetchRandom() async {
    dynamic response = await _randomService.getResponse("/random");
    final details = Quote.fromJson(response);
    return details;
  }
}
