import '../../../domain/entities/products/product.dart';
import '../base/data_model.dart';

class DataProduct extends DataModel {
  String? id;
  String? title;
  String? instructor;
  String? coverImage;
  String? description;
  int? primaryCoins;
  int? secondaryCoins;

  DataProduct({
    this.id,
    this.title,
    this.instructor,
    this.coverImage,
    this.description,
    this.primaryCoins,
    this.secondaryCoins,
  });

  DataProduct.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    instructor = json['instructor'];
    coverImage = json['coverImage'];
    description = json['description'];
    primaryCoins = json['primaryCoins'];
    secondaryCoins = json['secondaryCoins'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['instructor'] = instructor;
    data['coverImage'] = coverImage;
    data['description'] = description;
    data['primaryCoins'] = primaryCoins;
    data['secondaryCoins'] = secondaryCoins;
    return data;
  }

  @override
  Product toEntity() {
    return Product(
      id: id ?? '',
      title: title ?? '',
      instructor: instructor ?? '',
      coverImage: coverImage ?? '',
      description: description ?? '',
      primaryCoins: primaryCoins ?? 0,
      secondaryCoins: secondaryCoins,
    );
  }
}
