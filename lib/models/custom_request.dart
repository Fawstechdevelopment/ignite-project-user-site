class CustomRequest {
  final int? id;
  final String? requestType;
  final String? title;
  final String? description;

  CustomRequest({this.id, this.requestType, this.title, this.description});
  factory CustomRequest.fromJson(Map<String, dynamic> j) => CustomRequest(
    id: j['id'],
    requestType: j['request_type'],
    title: j['title'],
    description: j['description'],
  );
}
