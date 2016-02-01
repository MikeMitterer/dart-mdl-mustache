/// [Mustache template documentation](http://mustache.github.com/mustache.5.html)

library mdlmustache;

import 'package:reflectable/reflectable.dart';
import 'package:validate/validate.dart';

part 'mustache/LambdaContext.dart';
part 'mustache/lexer.dart';
part 'mustache/node.dart';
part 'mustache/parser.dart';
part 'mustache/renderer.dart';
part 'mustache/template.dart';
part 'mustache/TemplateException.dart';
part 'mustache/token.dart';

typedef Template PartialResolver(String templateName);

typedef Object LambdaFunction(LambdaContext context);

///// Use new Template(source) instead.
//@deprecated
//Template parse(String source, {bool lenient: false}) =>
//    new Template(source, lenient: lenient);


class MustacheMirrorsUsedAnnotation extends Reflectable {
    const MustacheMirrorsUsedAnnotation() : super(
        invokingCapability,
        reflectedTypeCapability
    );
}

const MustacheMirrorsUsedAnnotation mustache = const MustacheMirrorsUsedAnnotation();