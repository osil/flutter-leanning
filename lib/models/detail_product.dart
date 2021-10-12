// To parse this JSON data, do
//
//     final detail = detailFromJson(jsonString);

import 'dart:convert';

Detail detailFromJson(String str) => Detail.fromJson(json.decode(str));

String detailToJson(Detail data) => json.encode(data.toJson());

class Detail {
    Detail({
        required this.status,
        required this.statusCode,
        required this.data,
    });

    String status;
    int statusCode;
    List<Datum> data;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        status: json["status"],
        statusCode: json["status_code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.chId,
        required this.courseId,
        required this.chTitle,
        required this.chDateadd,
        required this.chTimetotal,
        required this.chView,
        required this.chUrl,
    });

    int chId;
    int courseId;
    String chTitle;
    DateTime chDateadd;
    String chTimetotal;
    int chView;
    String chUrl;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chId: json["ch_id"],
        courseId: json["course_id"],
        chTitle: json["ch_title"],
        chDateadd: DateTime.parse(json["ch_dateadd"]),
        chTimetotal: json["ch_timetotal"],
        chView: json["ch_view"],
        chUrl: json["ch_url"],
    );

    Map<String, dynamic> toJson() => {
        "ch_id": chId,
        "course_id": courseId,
        "ch_title": chTitle,
        "ch_dateadd": "${chDateadd.year.toString().padLeft(4, '0')}-${chDateadd.month.toString().padLeft(2, '0')}-${chDateadd.day.toString().padLeft(2, '0')}",
        "ch_timetotal": chTimetotal,
        "ch_view": chView,
        "ch_url": chUrl,
    };
}
