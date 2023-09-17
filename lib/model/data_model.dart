class ResponseModel {
  dynamic data;
  ResponseModel({
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['results'] ?? [],
    );
  }
}
