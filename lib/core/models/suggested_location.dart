class SuggestedLocation {
  final String type;
  final String addr;
  final String elc;
  final String placeName;
  final String alternateName;
  final int orderIndex;

  SuggestedLocation({
    required this.type,
    required this.addr,
    required this.elc,
    required this.placeName,
    required this.alternateName,
    required this.orderIndex,
  });

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) {
    return SuggestedLocation(
      type: json['type'],
      addr: json['addr'],
      elc: json['elc'],
      placeName: json['placeName'],
      alternateName: json['alternateName'] ?? '',
      orderIndex: json['orderIndex'],
    );
  }
}
