import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tooflix/models/webtoon.dart';
import 'package:tooflix/models/webtoon_detail_model.dart';
import 'package:tooflix/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebToonModel>> getTodaysToons() async {
    List<WebToonModel> webToonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webToons = jsonDecode(response.body);
      for (var webToon in webToons) {
        final toon = WebToonModel.fromJson(webToon);
        webToonInstances.add(toon);
      }
      return webToonInstances;
    }
    throw Error();
  }

  static Future<WebToonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webToon = jsonDecode(response.body);
      return WebToonDetailModel.fromJson(webToon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
