import 'package:aula_clean/src/auth/domain/entities/logged_user.dart';
import 'package:aula_clean/src/auth/domain/errors/errors.dart';
import 'package:aula_clean/src/auth/domain/repositories/auth_repository.dart';
import 'package:aula_clean/src/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRepositoryMock implements AuthRepository {
  @override
  Future<LoggedUser> login(CredentialsParams params) async {
    return LoggedUser(email: params.email, name: 'Robson');
  }
}

void main() {
  final repository = AuthRepositoryMock();
  final usecase = LoginUsecase(repository);
  testWidgets('deve efetuar login', (tester) async {
    final result = await usecase(CredentialsParams(
        email: 'robantunescampos@gmail.com', password: '123'));

    expect(result, isA<LoggedUser>());
    expect(result.name, 'Robson');
  });
  testWidgets('deve dar erro quando o email for invalido', (tester) async {
    final result =
        usecase(CredentialsParams(email: 'robantunescampos', password: '123'));

    expect(() async => await result, throwsA(isA<AuthException>()));
  });
  testWidgets('deve dar erro quando o password for invalido', (tester) async {
    final result = usecase(
        CredentialsParams(email: 'robantunescampos@gmail.com', password: ''));

    expect(() async => await result, throwsA(isA<AuthException>()));
  });
}
