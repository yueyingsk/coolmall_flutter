import 'package:coolmall_flutter/features/goods/model/coupon.dart';
import 'package:coolmall_flutter/features/goods/model/goods.dart';
import 'package:coolmall_flutter/features/goods/model/goods_spec.dart';

class GoodsDetail {
  final Goods goodsInfo;
  final List<Coupon> coupon;
  final List<Comment> comment;

  const GoodsDetail({
    required this.goodsInfo,
    required this.coupon,
    required this.comment,
  });

  factory GoodsDetail.fromJson(Map<String, dynamic> json) {
    return GoodsDetail(
      goodsInfo: Goods.fromJson(json['goodsInfo']),
      coupon: json['coupon'] == null
          ? []
          : (json['coupon'] as List).map((e) => Coupon.fromJson(e)).toList(),
      comment: json['comment'] == null
          ? []
          : (json['comment'] as List).map((e) => Comment.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'goodsInfo': goodsInfo.toJson(),
      'coupon': coupon.map((e) => e.toJson()).toList(),
      'comment': comment.map((e) => e.toJson()).toList(),
    };
  }
}

class Comment {
  final int id;
  final int userId;
  final int goodsId;
  final int orderId;
  final int starCount;
  final String userName;
  final String nickName;
  final String avatarUrl;
  final String content;
  final String createTime;
  final String updateTime;
  final List<String> pics;

  const Comment({
    required this.id,
    required this.userId,
    required this.goodsId,
    required this.orderId,
    required this.starCount,
    required this.userName,
    required this.nickName,
    required this.avatarUrl,
    required this.content,
    required this.createTime,
    required this.updateTime,
    required this.pics,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      goodsId: json['goodsId'],
      orderId: json['orderId'],
      starCount: json['starCount'],
      userName: json['userName'] ?? '',
      nickName: json['nickName'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      content: json['content'] ?? '',
      createTime: json['createTime'] ?? '',
      updateTime: json['updateTime'] ?? '',
      pics: json['pics'] == null ? [] : (json['pics'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'goodsId': goodsId,
      'orderId': orderId,
      'starCount': starCount,
      'nickName': nickName,
      'avatarUrl': avatarUrl,
      'content': content,
      'createTime': createTime,
      'updateTime': updateTime,
      'pics': pics,
    };
  }
}

class SelectedGoods {
  final Goods goods;
  final GoodsSpec? spec;
  final int count;

  const SelectedGoods({required this.goods, this.spec, required this.count});
}
