import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';
@JsonSerializable(explicitToJson: true)
class RatingModel{
  double? rate;
  int? count;

  RatingModel({this.rate, this.count});
  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

}