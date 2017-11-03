library reflection_test_pkgref.anotherlib.dart;

import 'package:reflectable/reflectable.dart';

class ReflectionTestAnotherPackage extends Reflectable {
    const ReflectionTestAnotherPackage() : super(

        //instanceInvokeCapability,
        invokingCapability,
        reflectedTypeCapability,
        typeCapability,
        typingCapability,
        metadataCapability,
    );
}

const ReflectionTestAnotherPackage rpackagetest = const ReflectionTestAnotherPackage();

class ThisIsACarAnnotation {
    const ThisIsACarAnnotation();
}
const ThisIsACarAnnotation thisIsACar = const ThisIsACarAnnotation();

@rpackagetest
abstract class Vehicle {
    int wheels();
}

@rpackagetest
class MotorBike extends Vehicle {
  @override
  int wheels() => 2;
}

@rpackagetest @thisIsACar
class Car extends Vehicle {
    @override
    int wheels() => 4;
}