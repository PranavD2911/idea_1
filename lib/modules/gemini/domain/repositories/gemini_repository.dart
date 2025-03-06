import 'package:either_dart/either.dart';
import 'package:idea_1/modules/gemini/data/models/gemini_request_model.dart';
import 'package:idea_1/services/error/server_failures.dart';

abstract class GeminiRepository {
  Future<Either<Failure, dynamic>> geminiRequest(
      {required GeminiRequestModel geminiRequestModel});
}
