import 'package:either_dart/either.dart';
import 'package:idea_1/common/common_variable_class.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_request_model.dart';
import 'package:idea_1/services/api_providers.dart';
import 'package:idea_1/services/error/server_failures.dart';

class GeminiRepoImpl {
  final ApiProvider _apiProvider = ApiProvider();

  Future postData({required GeminiRequestModel geminiRequestModel}) async {
    try {
      var url =
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${CommonVariableClass.geminiKey}";
      final response = await _apiProvider.callTypePost(
          url: url, body: geminiRequestModel.toJson());
      if (response is Left) {
        return Left(ServerFailure(message: 'Error: Something Went Wrong'));
      }
      return response;
    } catch (e) {
      return Left(ServerFailure(message: 'Error: $e'));
    }
  }
}
