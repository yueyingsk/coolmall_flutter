class Coupon {
  final int id;
  final String createTime;
  final String updateTime;
  final String title;
  final String description;
  final int type;
  final int amount;
  final int num;
  final int receivedNum;
  final String startTime;
  final String endTime;
  final int status;
  final Condition condition;

  /// 使用状态 0-未使用 1-已使用 2-已过期
  /// 注意：此字段仅在"我的优惠券"接口中返回，领取优惠券时不包含此字段
  final int? useStatus;

  Coupon({
    required this.id,
    required this.createTime,
    required this.updateTime,
    required this.title,
    required this.description,
    required this.type,
    required this.amount,
    required this.num,
    required this.receivedNum,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.condition,
    this.useStatus,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    createTime: json["createTime"],
    updateTime: json["updateTime"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    amount: json["amount"],
    num: json["num"],
    receivedNum: json["receivedNum"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    status: json["status"],
    condition: Condition.fromJson(json["condition"]),
    useStatus: json["useStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime,
    "updateTime": updateTime,
    "title": title,
    "description": description,
    "type": type,
    "amount": amount,
    "num": num,
    "receivedNum": receivedNum,
    "startTime": startTime,
    "endTime": endTime,
    "status": status,
    "condition": condition.toJson(),
    "useStatus": useStatus,
  };
  Coupon copyWith({
    int? id,
    String? createTime,
    String? updateTime,
    String? title,
    String? description,
    int? type,
    int? amount,
    int? num,
    int? receivedNum,
    String? startTime,
    String? endTime,
    int? status,
    Condition? condition,
    int? useStatus,
  }) => Coupon(
    id: id ?? this.id,
    createTime: createTime ?? this.createTime,
    updateTime: updateTime ?? this.updateTime,
    title: title ?? this.title,
    description: description ?? this.description,
    type: type ?? this.type,
    amount: amount ?? this.amount,
    num: num ?? this.num,
    receivedNum: receivedNum ?? this.receivedNum,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    status: status ?? this.status,
    condition: condition ?? this.condition,
    useStatus: useStatus ?? this.useStatus,
  );
}

class Condition {
  final int fullAmount;

  Condition({required this.fullAmount});

  factory Condition.fromJson(Map<String, dynamic> json) =>
      Condition(fullAmount: json["fullAmount"]);

  Map<String, dynamic> toJson() => {"fullAmount": fullAmount};
}
