import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
class AnnouncementModel with _$AnnouncementModel {
  const factory AnnouncementModel({
    @JsonKey(name: '_id') required String id,
    required String title,
    required String description,
    required DateTime date,
    required String location,
    String? image,
    @JsonKey(name: 'postedBy') required PostedByModel postedBy,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    // Handle postedBy as either a String or a Map
    final postedByRaw = json['postedBy'];
    PostedByModel postedBy;
    if (postedByRaw is Map<String, dynamic>) {
      postedBy = PostedByModel.fromJson(postedByRaw);
    } else if (postedByRaw is String) {
      postedBy = PostedByModel(id: postedByRaw, name: ''); // name is empty if not provided
    } else {
      throw Exception('Invalid postedBy type');
    }
    return AnnouncementModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      location: json['location'] as String,
      image: json['image'] as String?,
      postedBy: postedBy,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

@freezed
class PostedByModel with _$PostedByModel {
  const factory PostedByModel({
    @JsonKey(name: '_id') required String id,
    required String name,
  }) = _PostedByModel;

  factory PostedByModel.fromJson(Map<String, dynamic> json) => _$PostedByModelFromJson(json);
}

extension AnnouncementModelExtension on AnnouncementModel {
  String? get fullImageUrl {
    if (image == null) return null;
    final baseUrl = 'http://localhost:5000'; // Replace with your actual base URL
    final imagePath = image!.replaceAll('\\', '/');
    return '$baseUrl/public$imagePath';
  }
}
