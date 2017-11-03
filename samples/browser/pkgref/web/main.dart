// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html' as dom;

@GlobalQuantifyCapability(r"^dart.core.List", rtest)
@GlobalQuantifyCapability(r"^dart.core.Iterable", rtest)
@GlobalQuantifyCapability(r"^dart.core.Iterator", rtest)
import 'package:reflectable/reflectable.dart';
import 'package:reflectable/capability.dart';

class ReflectionTestAnnotation extends Reflectable {
    const ReflectionTestAnnotation() : super(

        invokingCapability,
        reflectedTypeCapability,
        typeCapability,
    );
}

const ReflectionTestAnnotation rtest = const ReflectionTestAnnotation();

@rtest
class Version {
    final int major;
    final int minor;

    Version(this.major, this.minor);
}

@rtest
class DartLang {
    final String name;
    final Version version;
    final String message;

    final List<String> names = [ "Mike", "Sarah", "Gerda"];

    DartLang(this.name, this.version, this.message);
}

void main() {
    final DartLang language = new DartLang("Dart1",new Version(1,13),"Your Dart app is running.");

    final InstanceMirror instanceMirror = rtest.reflect(language);
    final ClassMirror classMirror = instanceMirror.type;

    //instanceMirror.reflectee.
    print("+Instance members: ${classMirror.instanceMembers.keys}");
    print("Type: ${classMirror.instanceMembers["names"].reflectedReturnType}");

    final Object list = instanceMirror.invokeGetter("names");
    print((list as List).last);
    //print(rtest.reflect(list).invokeGetter("last"));

    final Object version = instanceMirror.invokeGetter("version");
    print(version.runtimeType);

    final Object major = rtest.reflect(version).invokeGetter("major");
    dom.querySelector('#output').text = major.toString();
}
