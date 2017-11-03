// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as dom;
import 'package:intl/intl.dart';

//@GlobalQuantifyCapability(r"^dart.core.List", rtest)
//@GlobalQuantifyCapability(r"^dart.core.Iterable", rtest)
//@GlobalQuantifyCapability(r"^dart.core.Iterator", rtest)
import 'package:reflectable/reflectable.dart';
import 'package:reflectable/capability.dart';

import 'package:reflection_test_browser2/rlib.dart';
import 'package:reflection_test_pkgref/anotherlib.dart';

import 'main.reflectable.dart';

class ReflectionTestAnnotation extends Reflectable {
    const ReflectionTestAnnotation() : super(

        //instanceInvokeCapability,
        invokingCapability,
        reflectedTypeCapability,
        typeCapability,
        typingCapability,
        metadataCapability,
    );
}

const ReflectionTestAnnotation rtest = const ReflectionTestAnnotation();

class MyAnnotation {
    final String name;
    const MyAnnotation({final String name: "default"}) : this.name = name;
}
const MyAnnotation myAnnotation = const MyAnnotation();

@rtest @myAnnotation @MyAnnotation(name: "Mike")
class Version {
    final int major;
    final int minor;

    Version(this.major, this.minor);

    String get version => "$major:$minor";
}

@rtest
class DartLang {
    final String name;
    final Version version;
    final String message;

    final List<String> names = [ "Mike", "Sarah", "Gerda"];

    DartLang(this.name, this.version, this.message);

    String getNameByIndex(final int index) => names[index];
}

void main() {
    initializeReflectable();

    final DartLang language = new DartLang("Dart1",new Version(1,13),"Your Dart app is running.");

    final InstanceMirror imLanguage = rtest.reflect(language);
    final ClassMirror cmLanguage = imLanguage.type;

    log("Classes with rtest-Annotation:",rtest.annotatedClasses);

    log("Instance members (keys):",cmLanguage.instanceMembers.keys);

    final methods = new List<String>();
    cmLanguage.instanceMembers.keys
        .where((final String key) => key != "noSuchMethod")
        .where((final String key) => cmLanguage.instanceMembers[key].isRegularMethod)
        .forEach((final String key) => methods.add(key));
    log("Methods:",methods);
    
    log("Type of names: ${cmLanguage.instanceMembers["names"].reflectedReturnType}");

    final Object list = imLanguage.invokeGetter("names");
    log("Last list-element via object-function: ${(list as List).last}");

    // Fails with:
    //      js_helper.dart:1772 Uncaught Error: Reflecting on un-marked type 'JSArray'
    // log("First list-element via invokeGetter: ${rtest.reflect(list).invokeGetter("first")}");

    // instanceInvokeCapability????
    log("Name by index via 'invoke': ${imLanguage.invoke("getNameByIndex", [1])}");

    final Object version = imLanguage.invokeGetter("version");
    final InstanceMirror imVersion = rtest.reflect(version);
    //final ClassMirror cmVersion = rtest.annotatedClasses(version.runtimeType);

    log("Version runtimeType: ${version.runtimeType}");

    final Object major = imVersion.invokeGetter("major");
    log("Major version: ${major.toString()}");

    final String fullVersion = imVersion.invokeGetter("version");
    log("Full version via invokeGetter: ${fullVersion}");

    final ClassMirror cmVersion = imVersion.type;
    log("Version metadata:",cmVersion.metadata);

    final names = new List<String>();
    cmVersion.metadata.where((final Object o) => o is MyAnnotation)
        .forEach((final MyAnnotation my) => names.add(my.name));
    log("MyAnnotation - Names:",names);

    final Animal animal = new Dog();
    final InstanceMirror imAnimal = rlibtest.reflect(animal);
    final ClassMirror cmAnimal = imAnimal.type;
    log("Animal (Dog??) make noise via 'invoke': ${imAnimal.invoke("makeNoise", [])}");

    final Vehicle vehicle = new Car();
    final InstanceMirror imVehicle = rpackagetest.reflect(vehicle);
    final ClassMirror cmVehicle = imVehicle.type;
    log("Vehicle (Car??) #of wheels 'invoke': ${imVehicle.invoke("wheels", [])}");

}

dom.Element _output;
void log(final message,[ final List additionalParams ]) {
    final now = new DateTime.now();

    final time = new dom.SpanElement()
        ..text = "${new DateFormat("HH:mm:ss").format(now)}.${now.millisecond}";

    final text = new dom.SpanElement()
        ..text = message.toString();

    final line = new dom.LIElement()
        ..append(time)
        ..append(text)
    ;
    if(additionalParams != null) {
        final ul = new dom.UListElement();
        additionalParams.forEach((final element) {
            final li = new dom.LIElement()..text = element.toString();
            ul.append(li);
        });
        line.append(ul);
    }

    (_output ??= dom.querySelector('#output')).append(line);
}