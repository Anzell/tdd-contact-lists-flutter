import 'package:contactlistwithhive/domain/entities/common/search_filter.dart';

class SearchFilterModel extends SearchFilter {
  SearchFilterModel({
    String? name,
    String? number,
  }) : super(
          name: name,
          number: number,
        );

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) {
    return SearchFilterModel(name: json["name"], number: json['number']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "number": number,
    };
  }
}
