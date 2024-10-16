class AssetsImages {
  // Singleton instance
  static final AssetsImages instance = AssetsImages._internal();

  // Private constructor for singleton
  AssetsImages._internal();

  // Base path for images
  static const String _imagePath = "assets/images";

  // Image paths
  String get logoImage => '$_imagePath/logoImage.jfif';
  String get noInternetImage => '$_imagePath/no-internet.png';
  String get manProfile => '$_imagePath/man.png';
  String get notification => '$_imagePath/notification_14244646.png';
}
