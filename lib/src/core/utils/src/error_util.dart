import 'package:firebase_core/firebase_core.dart';
import 'package:ui_kit/ui.dart';
import '../../rest_client/rest_client.dart';

abstract final class ErrorUtil {
  static String errorToString(Object error) => switch (error) {
    String value => value,
    FirebaseException e => _firebaseExceptionToString(e),
    RestClientException e => _restClientExceptionToString(e),
    Object value => 'Неизвестная ошибка: $value',
  };

  static String _firebaseExceptionToString(
    FirebaseException exception,
  ) => switch (exception.code.split('/').last.trim().toLowerCase()) {
    'invalid-email' => 'Неверный формат e-mail (адрес некорректен)',
    'user-disabled' => 'Учётная запись пользователя отключена',
    'user-not-found' => 'Пользователь с таким e-mail не найден',
    'wrong-password' => 'Неверный пароль',
    'email-already-in-use' => 'Учётная запись с таким e-mail уже существует',
    'operation-not-allowed' =>
      'Метод аутентификации не разрешён (не включён в Firebase Console)',
    'weak-password' => 'Слишком слабый пароль (например, слишком короткий)',
    'too-many-requests' => 'Слишком много попыток входа — временная блокировка',
    'account-exists-with-different-credential' =>
      'Аккаунт с этим e-mail уже существует с другим провайдером',
    'invalid-credential' =>
      'Неверные учётные данные (например, неверный токен/учётные данные)',
    'invalid-verification-code' =>
      'Неверный код подтверждения (чаще для Phone Auth)',
    'invalid-verification-id' =>
      'Неверный идентификатор подтверждения (Phone Auth)',
    'user-mismatch' => 'Учётные данные не соответствуют текущему пользователю',
    'requires-recent-login' => 'Требуется повторная недавняя авторизация',
    _ => 'Неизвестная ошибка: ${exception.message}',
  };

  static String _restClientExceptionToString(RestClientException exception) =>
      switch (exception.statusCode) {
        400 => 'Неправильный запрос (Bad Request)',
        401 => 'Неавторизовано (требуется аутентификация)',
        403 => 'Доступ запрещён (Forbidden)',
        404 => 'Не найдено (ресурс отсутствует)',
        405 => 'Метод не разрешён (Method Not Allowed)',
        406 => 'Неприемлемо (Not Acceptable)',
        408 => 'Истекло время ожидания запроса (Request Timeout)',
        409 => 'Конфликт (Conflict)',
        412 => 'Предварительное условие не выполнено (Precondition Failed)',
        413 => 'Слишком большой запрос (Payload Too Large)',
        422 => 'Невозможно обработать (Unprocessable Entity)',
        429 => 'Слишком много запросов (Too Many Requests)',
        500 => 'Внутренняя ошибка сервера (Internal Server Error)',
        501 => 'Не реализовано (Not Implemented)',
        502 => 'Плохой шлюз (Bad Gateway)',
        503 => 'Сервис недоступен (Service Unavailable)',
        504 => 'Шлюз: время ожидания истекло (Gateway Timeout)',
        _ => 'Ошибка: ${exception.message}',
      };

  static void showSnackBar(BuildContext context, Object error) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorPalette.destructiveCard,
        duration: const Duration(seconds: 3),
        padding: AppPadding.allMedium,
        behavior: .floating,
        content: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .start,
          spacing: 8.0,
          children: [
            UiText.bodyLarge(
              'Произошла ошибка',
              style: TextStyle(color: palette.destructiveForeground),
            ),
            UiText.bodyLarge(
              errorToString(error),
              style: TextStyle(
                color: Theme.of(context).colorPalette.mutedForeground,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16.0),
          side: BorderSide(color: palette.borderDestructive),
        ),
      ),
      snackBarAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      ),
    );
  }
}
