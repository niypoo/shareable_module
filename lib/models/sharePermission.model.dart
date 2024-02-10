class ShareablePermission {
  final String name;
  final String key;
  final String description;
  final bool defaultValue;

  ShareablePermission({
    required this.name,
    required this.key,
    this.description ='',
    this.defaultValue = true,
  });
}
