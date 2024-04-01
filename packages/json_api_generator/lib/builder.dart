import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:json_api_annotation/json_api_annotation.dart';
import 'package:source_gen/source_gen.dart';

Builder jsonApiBuilder(BuilderOptions options) {
  return SharedPartBuilder([FunctionsApiGenerator()], "jsonapi");
}

class FunctionsApiGenerator extends GeneratorForAnnotation<FunctionsApi> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = _FunctionVisitor();
    element.visitChildren(visitor);

    String result =
        "abstract class _\$Functions${visitor.className} implements ${visitor.className} {\n";

    for (final method in visitor.methods) {
      if (method.name == "getFunctions") continue;

      if (method.isPublic &&
          method.isAbstract &&
          method.returnType.isDartAsyncFuture &&
          method.parameters.length == 1) {
        final returnType =
            (method.returnType as ParameterizedType).typeArguments[0];

        final parameter = method.parameters[0];

        result += '''  @override
  $method async {
    final functions = await getFunctions();
    final callable = functions.httpsCallable("${method.name}");
    final response = await callable.call(${parameter.name}.toJson());
    
    ${returnType is DynamicType ? "" : "return $returnType.fromJson(response.data);"}
  }
''';
      }
    }

    result += '''
  Future<FirebaseFunctions> getFunctions();
''';

    result += "}";

    return result;
  }
}

class _FunctionVisitor extends SimpleElementVisitor {
  late DartType className;
  List<MethodElement> methods = [];

  @override
  visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  visitMethodElement(MethodElement element) {
    methods.add(element);
  }
}
