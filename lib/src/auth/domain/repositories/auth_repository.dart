import 'package:aula_clean/src/auth/domain/entities/logged_user.dart';
import 'package:aula_clean/src/auth/domain/usecases/login_usecase.dart';

abstract class AuthRepository {
  Future<LoggedUser> login(CredentialsParams params);
}
