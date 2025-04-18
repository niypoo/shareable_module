import 'package:shareable_module/enums/role.enum.dart';

class ShareInvitation {
  final String? id;
  final String? objectId;
  final DateTime? endAt;
  final Role role;

  ShareInvitation({
    this.id,
    this.objectId,
    this.endAt,
    this.role = Role.viewer,
  });

  // convert json to object
  factory ShareInvitation.fromData(Map<dynamic, dynamic> data) =>
      ShareInvitation(
        id: data['id'],
        objectId: data['objectId'],
        endAt: DateTime.fromMillisecondsSinceEpoch(data['endAt']),
        role: stringToRole(data['role']),
      );

  // convert object to json
  Map<String, dynamic> toData() => {
        'id': id,
        'objectId': objectId,
        'endAt': endAt!.millisecondsSinceEpoch,
        'role': role.name,
      };

  static List<ShareInvitation> fromMap(Map<dynamic, dynamic>? data) {
    // define list t return back
    final List<ShareInvitation> payloadList = [];

    // if null or empty return array
    if (data == null || data.isEmpty) return payloadList;

    // iterable
    for (final x in data.values) {
      payloadList.add(ShareInvitation.fromData(x));
    }

    // return payload after iterable
    return payloadList;
  }

  static Map<dynamic, dynamic> toMap(List<ShareInvitation>? objects) {
    // define list t return back
    final Map<dynamic, dynamic> payloadMap = {};

    // if null or empty return array
    if (objects == null || objects.isEmpty) return payloadMap;

    // iterable
    for (final x in objects) {
      payloadMap.addAll({x.id.toString(): x.toData()});
    }

    // return payload after iterable
    return payloadMap;
  }
}
