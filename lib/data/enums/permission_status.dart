enum PermissionStatus {
  denied,
  granted,

  /// only use for ios
  restricted,
  permanentlyDenied,

  /// only use for iOS (iOS14+).
  limited,

  /// only use for iOS (iOS12+).
  provisional,
  unableToDetermine
}
