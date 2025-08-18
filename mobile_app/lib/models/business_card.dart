class BusinessCard {
  final String id;
  final String userId;
  final String name;
  final String title;
  final String company;
  final String email;
  final String phone;
  final String website;
  final String? avatar;
  final String bio;
  final List<String> socialLinks;
  final Map<String, String> customFields;
  final DateTime createdAt;
  final DateTime updatedAt;

  BusinessCard({
    required this.id,
    required this.userId,
    required this.name,
    required this.title,
    required this.company,
    required this.email,
    required this.phone,
    required this.website,
    this.avatar,
    this.bio = '',
    this.socialLinks = const [],
    this.customFields = const {},
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) {
    return BusinessCard(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      title: json['title'],
      company: json['company'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      avatar: json['avatar'],
      bio: json['bio'] ?? '',
      socialLinks: List<String>.from(json['social_links'] ?? []),
      customFields: Map<String, String>.from(json['custom_fields'] ?? {}),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'title': title,
      'company': company,
      'email': email,
      'phone': phone,
      'website': website,
      'avatar': avatar,
      'bio': bio,
      'social_links': socialLinks,
      'custom_fields': customFields,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  BusinessCard copyWith({
    String? id,
    String? userId,
    String? name,
    String? title,
    String? company,
    String? email,
    String? phone,
    String? website,
    String? avatar,
    String? bio,
    List<String>? socialLinks,
    Map<String, String>? customFields,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BusinessCard(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      title: title ?? this.title,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      website: website ?? this.website,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      socialLinks: socialLinks ?? this.socialLinks,
      customFields: customFields ?? this.customFields,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
