class MemberResponse {
  final int id;
  final String name;
  final String certificationSubject;
  final bool notificationConsent;
  final Map<String, dynamic> resource;

  MemberResponse({
    required this.id,
    required this.name,
    required this.certificationSubject,
    required this.notificationConsent,
    required this.resource,
  });

  static MemberResponse fromJson(Map<String, dynamic> json) {
    return MemberResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      certificationSubject: json['certificationSubject'] as String,
      notificationConsent: json['notificationConsent'] as bool,
      resource: json['resource'],
    );
  }

  @override
  String toString() {
    return 'MemberResponse{id: $id, name: $name, certificationSubject: $certificationSubject, notificationConsent: $notificationConsent, resource: $resource}';
  }
}
