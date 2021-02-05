enum AutoLoginType{
  rememberMe,
  bioFinger,
  bioFace,
}

void main() {

  AutoLoginType autoLoginType  ;
  int x = autoLoginType?.index ?? -1;
  print(x);
}
