/// [Mustache template documentation](http://mustache.github.com/mustache.5.html)

library mdlmustache;

import 'package:reflectable/reflectable.dart';
//import 'package:validate/validate.dart';

part 'mustache/LambdaContext.dart';
part 'mustache/lexer.dart';
part 'mustache/node.dart';
part 'mustache/parser.dart';
part 'mustache/renderer.dart';
part 'mustache/template.dart';
part 'mustache/TagType.dart';
part 'mustache/TemplateException.dart';
part 'mustache/token.dart';

typedef Template PartialResolver(String templateName);

typedef Object LambdaFunction(LambdaContext context);

class MustacheMirrorsUsedAnnotation extends Reflectable {
    const MustacheMirrorsUsedAnnotation() : super(

admitSubtypeCapability,
classifyCapability,
correspondingSetterQuantifyCapability,
declarationsCapability,
delegateCapability,
instanceInvokeCapability,
   invokingCapability,
libraryCapability,
libraryDependenciesCapability,
// metadataCapability,
// nameCapability,
// newInstanceCapability,
reflectedTypeCapability,
//staticInvokeCapability,
        
// subtypeQuantifyCapability,
// superclassQuantifyCapability,
// topLevelInvokeCapability,
// typeAnnotationDeepQuantifyCapability,
// typeAnnotationQuantifyCapability,
// typeCapability,
// typeRelationsCapability,
// typingCapability,
// uriCapability
    );
}

const MustacheMirrorsUsedAnnotation mustache = const MustacheMirrorsUsedAnnotation();