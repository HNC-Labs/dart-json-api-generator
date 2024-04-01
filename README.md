# Example
```test_api.dart```
```dart
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
  Future<Response> request(Request res);
}
```

```test_api.g.dart```
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_api.dart';

// **************************************************************************
// FunctionsApiGenerator
// **************************************************************************

abstract class _$FunctionsTestApi implements TestApi {
  @override
  Future<Response> request(Request res) async {
    final functions = await getFunctions();
    final callable = functions.httpsCallable("request");
    final response = await callable.call(res.toJson());

    return Response.fromJson(response.data);
  }

  Future<FirebaseFunctions> getFunctions();
}
```