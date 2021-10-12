// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
    Product({
        required this.data,
        required this.meta,
    });

    List<Datum> data;
    Meta meta;

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}

class Datum {
    Datum({
        required this.id,
        required this.title,
        required this.detail,
        required this.date,
        required this.view,
        required this.picture,
    });

    int id;
    String title;
    String detail;
    DateTime date;
    int view;
    String picture;

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        detail: json["detail"],
        date: DateTime.parse(json["date"]),
        view: json["view"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "detail": detail,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "view": view,
        "picture": picture,
    };
}

class Meta {
    Meta({
        required this.status,
        required this.statusCode,
    });

    String status;
    int statusCode;

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json["status"],
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
    };
}
