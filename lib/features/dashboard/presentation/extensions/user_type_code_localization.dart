import '../../domain/enums/user_type_code.dart';

extension UserTypeCodeLocalization on UserTypeCode {
  String get labelKey => switch (this) {
    UserTypeCode.full => 'user_type.full',
    UserTypeCode.student => 'user_type.student',
    UserTypeCode.elderly => 'user_type.elderly',
  };
}
