class SearchModel {
  final String query;
  final List<String> results;

  SearchModel({required this.query, required this.results});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      query: json['query'],
      results: List<String>.from(json['results']),
    );
  }
}
