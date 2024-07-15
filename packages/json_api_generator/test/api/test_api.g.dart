// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_api.dart';

// **************************************************************************
// FunctionsApiGenerator
// **************************************************************************

abstract class _$FunctionsTestApi implements TestApi {
  @override
  Future<Response> request(Request res, {Duration? timeout}) async {
    final functions = await getFunctions();
    final callable = functions.httpsCallable("request",
        options: HttpsCallableOptions(timeout: timeout));
    final response = await callable.call(res.toJson());

    return Response.fromJson(response.data);
  }

  Future<FirebaseFunctions> getFunctions();
}
