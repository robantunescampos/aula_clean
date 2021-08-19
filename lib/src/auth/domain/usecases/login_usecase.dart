import 'package:aula_clean/src/auth/domain/entities/logged_user.dart';
import 'package:aula_clean/src/auth/domain/errors/errors.dart';
import 'package:aula_clean/src/auth/domain/repositories/auth_repository.dart';
import 'package:string_validator/string_validator.dart';

abstract class ILoginUsecase {
  Future<LoggedUser> call(CredentialsParams params);
}

class LoginUsecase implements ILoginUsecase {
  final AuthRepository repository;

  LoginUsecase(this.repository);
  @override
  Future<LoggedUser> call(CredentialsParams params) async {
    if (!isEmail(params.email)) {
      throw AuthException('Error email');
    }

    if (params.password.isEmpty) {
      throw AuthException('Error password');
    }

    return await repository.login(params);
  }
}

class CredentialsParams {
  final String email;
  final String password;

  CredentialsParams({required this.email, required this.password});
}
