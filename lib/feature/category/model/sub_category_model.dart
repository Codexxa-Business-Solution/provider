import 'package:demandium_provider/core/helper/core_export.dart';

class ServiceSubCategoryModel {
  String? _id;
  String? _parentId;
  String? _name;
  String? _image;
  int? _position;
  String? _description;
  int? _isActive;
  String? _createdAt;
  String? _updatedAt;
  int? _isSubscribed;
  List<Service>? _services;

  ServiceSubCategoryModel(
      {String? id,
        String? parentId,
        String? name,
        String? image,
        int? position,
        String? description,
        int? isActive,
        String? createdAt,
        String? updatedAt,
        int? isSubscribed,
        List<Service>? services}) {
    if (id != null) {
      this._id = id;
    }
    if (parentId != null) {
      this._parentId = parentId;
    }
    if (name != null) {
      this._name = name;
    }
    if (image != null) {
      this._image = image;
    }
    if (position != null) {
      this._position = position;
    }
    if (description != null) {
      this._description = description;
    }
    if (isActive != null) {
      this._isActive = isActive;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (isSubscribed != null) {
      this._isSubscribed = isSubscribed;
    }
    if (services != null) {
      this._services = services;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get parentId => _parentId;
  set parentId(String? parentId) => _parentId = parentId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get image => _image;
  set image(String? image) => _image = image;
  int? get position => _position;
  set position(int? position) => _position = position;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get isActive => _isActive;
  set isActive(int? isActive) => _isActive = isActive;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get isSubscribed => _isSubscribed;
  set isSubscribed(int? isSubscribed) => _isSubscribed = isSubscribed;
  List<Service>? get services => _services;
  set services(List<Service>? services) => _services = services;

  ServiceSubCategoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _name = json['name'];
    _image = json['image'];
    _position = int.parse(json['position'].toString());
    _description = json['description'];
    _isActive = int.parse(json['is_active'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _isSubscribed = json['is_subscribed'];
    if (json['services'] != null) {
      _services = <Service>[];
      json['services'].forEach((v) {
        _services!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['parent_id'] = this._parentId;
    data['name'] = this._name;
    data['image'] = this._image;
    data['position'] = this._position;
    data['description'] = this._description;
    data['is_active'] = this._isActive;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    data['is_subscribed'] = this._isSubscribed;
    if (this._services != null) {
      data['services'] = this._services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


