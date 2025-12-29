class Category {
  final int id;
  final DateTime createTime;
  final DateTime updateTime;
  final dynamic description;
  final dynamic path;
  final String pic;
  final int sortNum;
  final int status;
  final String? name;
  final int? parentId;

  Category({
    required this.id,
    required this.createTime,
    required this.updateTime,
    this.description,
    this.path,
    required this.pic,
    required this.sortNum,
    required this.status,
    this.name,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createTime: DateTime.parse(json["createTime"]),
    updateTime: DateTime.parse(json["updateTime"]),
    description: json["description"],
    path: json["path"],
    pic: json["pic"],
    sortNum: json["sortNum"],
    status: json["status"],
    name: json["name"],
    parentId: json["parentId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createTime": createTime.toIso8601String(),
    "updateTime": updateTime.toIso8601String(),
    "description": description,
    "path": path,
    "pic": pic,
    "sortNum": sortNum,
    "status": status,
    "name": name,
    "parentId": parentId,
  };
}
