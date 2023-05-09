import 'auth_provider.dart';
import 'auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  @override
  // implement createUser
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  // implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  // implement logOut
  Future<void> logOut() => provider.logOut();

  @override
  //implement login
  Future<AuthUser> login({
    required String email,
    required String password,
  }) =>
      provider.login(
        email: email,
        password: password,
      );

  @override
  // implement sendEmailverification
  Future<void> sendEmailverification() => provider.sendEmailverification();
}
