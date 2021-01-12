class GoodsListModel {
  String count;
  String hasMore;
  String currentPage;
  List<GoodsListModelData> data;

  GoodsListModel({this.count, this.hasMore, this.currentPage, this.data});

  GoodsListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    hasMore = json['hasMore'];
    currentPage = json['currentPage'];
    if (json['data'] != null) {
      data = new List<GoodsListModelData>();
      json['data'].forEach((v) {
        data.add(new GoodsListModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['hasMore'] = this.hasMore;
    data['currentPage'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoodsListModelData {
  String startAddress;
  String endAddress;
  String goodsType;
  String createTime;
  String status;
  String needsCar;
  String id;

  GoodsListModelData(
      {this.startAddress,
        this.endAddress,
        this.goodsType,
        this.createTime,
        this.status,
        this.needsCar,
        this.id});

  GoodsListModelData.fromJson(Map<String, dynamic> json) {
    startAddress = json['startAddress'];
    endAddress = json['endAddress'];
    goodsType = json['goodsType'];
    createTime = json['createTime'];
    status = json['status'];
    needsCar = json['needsCar'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startAddress'] = this.startAddress;
    data['endAddress'] = this.endAddress;
    data['goodsType'] = this.goodsType;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['needsCar'] = this.needsCar;
    data['id'] = this.id;
    return data;
  }
}