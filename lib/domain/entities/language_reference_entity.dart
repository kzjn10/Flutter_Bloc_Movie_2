import 'package:equatable/equatable.dart';

class LanguageReferenceEntity with EquatableMixin {
  final String code;
  final String vietnamese;
  final String english;
  final int updatedAt;

  LanguageReferenceEntity({
    this.code,
    this.vietnamese,
    this.english,
    this.updatedAt,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        code,
        vietnamese,
        english,
      ];
}
