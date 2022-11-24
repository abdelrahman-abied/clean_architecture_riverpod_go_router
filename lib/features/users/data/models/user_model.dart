import 'dart:convert';

class Users {
  late final String id;
  String? name;
  String? gender;
  String? status;
  String? partnerId;
  String? createdAt;

  Users({
    required this.id,
    this.name,
    this.gender,
    this.status,
    this.partnerId,
    this.createdAt,
    // this.statistics,
  });
  Users copyWith({required String name}) {
    return Users(
      id: id,
      name: name,
      gender: gender,
      status: status,
      partnerId: partnerId,
      createdAt: createdAt,
    );
  }

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    gender = json['gender'] as String;
    status = json['status'] as String;
    partnerId = json['partner_id'] as String;
    createdAt = json['created_at'] as String;
    // statistics = json['statistics'].cast<int>() as List<int>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['status'] = status;
    data['partner_id'] = partnerId;
    data['created_at'] = createdAt;
    // data['statistics'] = statistics;
    return data;
  }
}
