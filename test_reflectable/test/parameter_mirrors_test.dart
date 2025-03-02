// Copyright (c) 2015, the Dart Team. All rights reserved. Use of this
// source code is governed by a BSD-style license that can be found in
// the LICENSE file.

library test_reflectable.test.parameter_mirrors_test;

import 'package:test/test.dart';
import 'package:reflectable/reflectable.dart';
import 'parameter_mirrors_lib.dart' as lib;
import 'parameter_mirrors_test.reflectable.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(instanceInvokeCapability, metadataCapability,
            newInstanceCapability, declarationsCapability);
}

class C {
  const C();
}

@Reflector()
class A {
  void f1() {}
  void f2(int a) {}
  void f3(int a, [String? b, @C() String c = 'ten']) {}
  void f4(int a, {@lib.D(3) A? b, C c = const C()}) {}

  var x;
  A({this.x = 42});
}

void main() {
  initializeReflectable();

  test('Parameter mirrors', () {
    var cm = const Reflector().reflectType(A) as ClassMirror;
    var f1 = cm.declarations['f1'] as MethodMirror;
    var f1Parameters = f1.parameters;
    var f2 = cm.declarations['f2'] as MethodMirror;
    var f2Parameters = f2.parameters;
    var f3 = cm.declarations['f3'] as MethodMirror;
    var f3Parameters = f3.parameters;
    var f4 = cm.declarations['f4'] as MethodMirror;
    var f4Parameters = f4.parameters;
    var constructor = cm.declarations['A'] as MethodMirror;
    var constructorParameters = constructor.parameters;

    expect(f1Parameters, []);

    expect(f2Parameters.length, 1);

    expect(f2Parameters[0].isNamed, false);
    expect(f2Parameters[0].hasDefaultValue, false);
    expect(f2Parameters[0].defaultValue, null);
    expect(f2Parameters[0].isConst, false);
    expect(f2Parameters[0].isFinal, false);
    expect(f2Parameters[0].isStatic, false);
    expect(f2Parameters[0].isOptional, false);
    expect(f2Parameters[0].isTopLevel, false);
    expect(f2Parameters[0].owner, f2);
    expect(f2Parameters[0].simpleName, 'a');
    expect(f2Parameters[0].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A.f2.a');
    expect(f2Parameters[0].metadata, []);

    expect(f3Parameters.length, 3);

    expect(f3Parameters[1].isNamed, false);
    expect(f3Parameters[1].hasDefaultValue, false);
    expect(f3Parameters[1].defaultValue, null);
    expect(f3Parameters[1].isConst, false);
    expect(f3Parameters[1].isFinal, false);
    expect(f3Parameters[1].isStatic, false);
    expect(f3Parameters[1].isOptional, true);
    expect(f3Parameters[1].isTopLevel, false);
    expect(f3Parameters[1].owner, f3);
    expect(f3Parameters[1].simpleName, 'b');
    expect(f3Parameters[1].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A.f3.b');
    expect(f3Parameters[1].metadata, []);

    expect(f3Parameters[2].isNamed, false);
    expect(f3Parameters[2].hasDefaultValue, true);
    expect(f3Parameters[2].defaultValue, 'ten');
    expect(f3Parameters[2].isConst, false);
    expect(f3Parameters[2].isFinal, false);
    expect(f3Parameters[2].isStatic, false);
    expect(f3Parameters[2].isOptional, true);
    expect(f3Parameters[2].isTopLevel, false);
    expect(f3Parameters[2].owner, f3);
    expect(f3Parameters[2].simpleName, 'c');
    expect(f3Parameters[2].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A.f3.c');
    expect(f3Parameters[2].metadata, [const C()]);

    expect(f4Parameters.length, 3);

    expect(f4Parameters[1].isNamed, true);
    expect(f4Parameters[1].hasDefaultValue, false);
    expect(f4Parameters[1].defaultValue, null);
    expect(f4Parameters[1].isConst, false);
    expect(f4Parameters[1].isFinal, false);
    expect(f4Parameters[1].isStatic, false);
    expect(f4Parameters[1].isOptional, true);
    expect(f4Parameters[1].isTopLevel, false);
    expect(f4Parameters[1].owner, f4);
    expect(f4Parameters[1].simpleName, 'b');
    expect(f4Parameters[1].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A.f4.b');
    expect(f4Parameters[1].metadata, [const lib.D(3)]);

    expect(f4Parameters[2].isNamed, true);
    expect(f4Parameters[2].hasDefaultValue, true);
    expect(f4Parameters[2].defaultValue, const C());
    expect(f4Parameters[2].isConst, false);
    expect(f4Parameters[2].isFinal, false);
    expect(f4Parameters[2].isStatic, false);
    expect(f4Parameters[2].isOptional, true);
    expect(f4Parameters[2].isTopLevel, false);
    expect(f4Parameters[2].owner, f4);
    expect(f4Parameters[2].simpleName, 'c');
    expect(f4Parameters[2].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A.f4.c');
    expect(f4Parameters[2].metadata, []);

    expect(constructorParameters[0].isNamed, true);
    expect(constructorParameters[0].hasDefaultValue, true);
    expect(constructorParameters[0].defaultValue, 42);
    expect(constructorParameters[0].isConst, false);
    expect(constructorParameters[0].isFinal, true);
    expect(constructorParameters[0].isStatic, false);
    expect(constructorParameters[0].isOptional, true);
    expect(constructorParameters[0].isTopLevel, false);
    expect(constructorParameters[0].owner, constructor);
    expect(constructorParameters[0].simpleName, 'x');
    expect(constructorParameters[0].qualifiedName,
        'test_reflectable.test.parameter_mirrors_test.A..x');
    expect(constructorParameters[0].metadata, []);
  });
}
