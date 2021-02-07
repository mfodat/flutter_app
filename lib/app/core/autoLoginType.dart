enum AutoLoginType{
  none,
  rememberMe,
  bio,
}



void main() {

  AutoLoginType autoLoginType  ;
  int x = autoLoginType?.index ?? -1;
  print(x);
}
