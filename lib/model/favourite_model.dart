import 'package:flutter/foundation.dart';

class FavouriteModel {
  final String fid;
  final String uid;
  final List<String> pid;
  FavouriteModel({
    required this.fid,
    required this.uid,
    required this.pid,
  });

  FavouriteModel copyWith({
    String? fid,
    String? uid,
    List<String>? pid,
  }) {
    return FavouriteModel(
      fid: fid ?? this.fid,
      uid: uid ?? this.uid,
      pid: pid ?? this.pid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fid': fid,
      'uid': uid,
      'pid': pid,
    };
  }

  factory FavouriteModel.fromMap(Map<String, dynamic> map) {
    return FavouriteModel(
        fid: map['fid'] as String,
        uid: map['uid'] as String,
        pid: List<String>.from(
          (map['pid'] ?? []),
        ));
  }

  @override
  String toString() => 'FavouriteModel(fid: $fid, uid: $uid, pid: $pid)';

  @override
  bool operator ==(covariant FavouriteModel other) {
    if (identical(this, other)) return true;

    return other.fid == fid && other.uid == uid && listEquals(other.pid, pid);
  }

  @override
  int get hashCode => fid.hashCode ^ uid.hashCode ^ pid.hashCode;
}
