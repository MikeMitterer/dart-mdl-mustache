library reflection_test_browser2.rlib;

import 'package:reflectable/reflectable.dart';

class ReflectionTestInLib extends Reflectable {
    const ReflectionTestInLib() : super(

        //instanceInvokeCapability,
        invokingCapability,
        reflectedTypeCapability,
        typeCapability,
        typingCapability,
        metadataCapability,
    );
}

const ReflectionTestInLib rlibtest = const ReflectionTestInLib();

@rlibtest
abstract class Animal {
    String makeNoise();
}

@rlibtest
class Dog extends Animal {
  @override
  String makeNoise() => "Wuff";
}

@rlibtest
class Cat extends Animal {
    @override
    String makeNoise() => "Miau";
}