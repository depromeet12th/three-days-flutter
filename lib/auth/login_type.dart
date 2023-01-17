enum LoginType {
  kakao,
  apple,
  ;

  String getDisplayName() {
    return name.toUpperCase();
  }
}
