class AppEntity {
  AppEntity(this.packageName, this.appName);
  final String packageName;
  String iconPath = '';
  final String appName;
  @override
  String toString() {
    return 'appName : $appName packageName : $packageName';
  }
}
