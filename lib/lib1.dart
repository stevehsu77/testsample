
library lib1;

import 'dart:mirrors';

class cls1
{
  String s;
  cls1([this.s]){}
  void pp(String ss)
  {
    print(s+ss);

  }
  dynamic noSuchMethod(Invocation invocation)
  {
    print(invocation.memberName);
    return null;
  }

  operator [](key)
  {
    return reflect(this).getField(new Symbol(key));
  }
}