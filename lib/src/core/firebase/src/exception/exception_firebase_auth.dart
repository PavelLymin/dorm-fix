class AuthException implements Exception {
  AuthException({required String code}) {
    switch (code) {
      case 'user-null':
        message = 'Такого пользователя нет';
      case 'email-already-in-use':
        message = 'Указанный email уже занят другим пользователем.';
      case 'invalid-email':
        message = 'Указан некорректно сформированный email.';
      case 'weak-password	':
        message = 'Пароль слишком слабый.';
      case 'user-not-found':
        message = 'Пользователя с таким email не существует.';
      case 'wrong-password':
        message = 'Неправильный пароль.';
      case 'too-many-requests':
        message = 'Слишком много запросов, доступ временно заблокирован.';
      case 'user-disabled':
        message = 'Учетная запись пользователя отключена администратором.';
      case 'invalid-credential':
        message = 'Введенные учетные данные неверны.';
      default:
        message = code;
    }
  }

  late String message;

  @override
  String toString() => 'AuthException(message: $message)';
}
