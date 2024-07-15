import 'package:json_api_annotation/json_api_annotation.dart';

part 'test_api.g.dart';

abstract class FirebaseFunctions {
  dynamic httpsCallable(String name);
}

class Response {
  const Response();

  factory Response.fromJson(Map<String, Object?> json) {
    return Response();
  }
}

class Request {
  Map<String, Object?> toJson() => {};
}

@FunctionsApi()
abstract class TestApi {
  Future<Response> request(Request res, {Duration? timeout});
}
