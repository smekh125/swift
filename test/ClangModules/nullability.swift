// RUN: %swift %clang-importer-sdk -parse %s -verify

import nullability;

func testSomeClass(sc: SomeClass, osc: SomeClass?) {
  var ao1: AnyObject = sc.methodA(osc)
  if sc.methodA(osc) == nil { } // expected-error{{binary operator '==' cannot be applied to an AnyObject operand and a nil operand}}

  var ao2: AnyObject = sc.methodB(nil)
  if sc.methodA(osc) == nil { } // expected-error{{binary operator '==' cannot be applied to an AnyObject operand and a nil operand}}

  var ao3: AnyObject = sc.property // expected-error{{value of optional type 'AnyObject?' not unwrapped; did you mean to use '!' or '?'?}}
  var ao3_ok: AnyObject? = sc.property // okay

  var ao4: AnyObject = sc.methodD()
  if sc.methodD() == nil { } // expected-error{{cannot invoke}}

  sc.methodE(sc)
  sc.methodE(osc) // expected-error{{value of optional type 'SomeClass?' not unwrapped; did you mean to use '!' or '?'?}}

  sc.methodF(sc, second: sc)
  sc.methodF(osc, second: sc) // expected-error{{value of optional type 'SomeClass?' not unwrapped; did you mean to use '!' or '?'?}}
  sc.methodF(sc, second: osc) // expected-error{{value of optional type 'SomeClass?' not unwrapped; did you mean to use '!' or '?'?}}

  sc.methodG(sc, second: sc)
  sc.methodG(osc, second: sc) // expected-error{{value of optional type 'SomeClass?' not unwrapped; did you mean to use '!' or '?'?}}
  sc.methodG(sc, second: osc) 
}
