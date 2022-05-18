class UserProfileResponse {
  int? statusCode;
  FlaqUser? data;

  UserProfileResponse({this.statusCode, this.data});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new FlaqUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FlaqUser {
  int? rewardMultiplier;
  String? synFlaqBalance;
  late bool isAllowed;
  String? sId;
  String? referralCode;
  String? email;
  String? uid;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FlaqUser(
      {this.rewardMultiplier,
      this.synFlaqBalance,
      this.isAllowed = false,
      this.sId,
      this.referralCode,
      this.email,
      this.uid,
      this.createdAt,
      this.updatedAt,
      this.iV});

  FlaqUser.fromJson(Map<String, dynamic> json) {
    rewardMultiplier = json['rewardMultiplier'];
    synFlaqBalance = json['synFlaqBalance'];
    isAllowed = json['isAllowed'] ?? false;
    sId = json['_id'];
    referralCode = json['referralCode'];
    email = json['email'];
    uid = json['uid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rewardMultiplier'] = this.rewardMultiplier;
    data['synFlaqBalance'] = this.synFlaqBalance;
    data['isAllowed'] = this.isAllowed;
    data['_id'] = this.sId;
    data['referralCode'] = this.referralCode;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
