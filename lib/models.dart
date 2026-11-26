// models.dart – data classes for LegalNepal frontend

class User {
  final String id;
  final String fullName;
  final String emailOrPhone;
  final String role; // 'client' or 'lawyer'
  User({required this.id, required this.fullName, required this.emailOrPhone, required this.role});
}

class Category {
  final String id;
  final String title;
  final String? description;
  const Category({required this.id, required this.title, this.description});
}

class Lawyer {
  final String id;
  final String name;
  final String specialization;
  final int experienceYears;
  final String location;
  final List<String> languages;
  final double? fee; // per consultation
  final bool verified;
  final String avatarUrl;
  Lawyer({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experienceYears,
    required this.location,
    required this.languages,
    this.fee,
    this.verified = false,
    required this.avatarUrl,
  });
}

class Guide {
  final String id;
  final String title;
  final String category;
  final String summary;
  final int readingTimeMins;
  final String content; // full article markdown/plain text
  Guide({
    required this.id,
    required this.title,
    required this.category,
    required this.summary,
    required this.readingTimeMins,
    required this.content,
  });
}

class Consultation {
  final String id;
  final String clientId;
  final String lawyerId;
  final String category;
  final DateTime preferredDate;
  final String method; // 'in-person' or 'online'
  final String status; // 'pending', 'accepted', 'completed', 'cancelled'
  final String? notes;
  Consultation({
    required this.id,
    required this.clientId,
    required this.lawyerId,
    required this.category,
    required this.preferredDate,
    required this.method,
    required this.status,
    this.notes,
  });
}