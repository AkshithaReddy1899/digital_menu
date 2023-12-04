class ResponseModel {
  String? message;
  Object? object;

  ResponseModel({this.message, this.object});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    object = json['object'] != null ? Object.fromJson(json['object']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (object != null) {
      data['object'] = object!.toJson();
    }
    return data;
  }
}

class Object {
  List<String>? categories;
  List<Param>? menu;
  List<Orders>? orders;

  Object({this.categories, this.menu, this.orders});

  Object.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <String>[];
      json['categories'].forEach((v) {
        categories!.add(v);
      });
    }
    if (json['menu'] != null) {
      menu = <Param>[];
      json['menu'].forEach((v) {
        menu!.add(Param.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categories'] = categories;
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? ordersId;
  int? dateTime;
  List<Param>? items;
  int? total;

  Orders({this.ordersId, this.dateTime, this.items, this.total});

  Orders.fromJson(Map<String, dynamic> json) {
    ordersId = json['ordersId'];
    dateTime = json['dateTime'];
    if (json['items'] != null) {
      items = <Param>[];
      json['items'].forEach((v) {
        items!.add(Param.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ordersId'] = ordersId;
    data['dateTime'] = dateTime;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

// class Orders {
//   int? ordersId;
//   List<Param>? items;
//   int? total;

//   Orders({this.ordersId, this.items, this.total});

//   Orders.fromJson(Map<String, dynamic> json) {
//     ordersId = json['ordersId'];
//     if (json['items'] != null) {
//       items = <Param>[];
//       json['items'].forEach((v) {
//         items!.add(Param.fromJson(v));
//       });
//       total = json['total'];
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['ordersId'] = ordersId;
//     if (items != null) {
//       data['items'] = items!.map((v) => v.toJson()).toList();
//     }
//     data['total'] = total;
//     return data;
//   }
// }

class Param {
  int? id;
  String? categoryName;
  String? name;
  String? description;
  int? price;
  int? quantity;
  String? customization;
  String? orderStatus;
  int? ordersId;

  Param({
    this.id,
    this.categoryName,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.customization,
    this.orderStatus,
    this.ordersId,
  });

  Param.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    customization = json['customization'];
    orderStatus = json['orderStatus'];
    ordersId = json['ordersId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryName'] = categoryName;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['customization'] = customization;
    data['orderStatus'] = orderStatus;
    data['ordersId'] = ordersId;
    return data;
  }
}
