import '../../../../../core/database/database.dart';
import '../../../chat.dart';

abstract interface class IMessageRepository {
  Future<FullMessage> createMessage({required PartialMessage message});

  Future<List<FullMessage>> getMessages({
    required int chatId,
    int? beforeId,
    int limit = 50,
  });
}

class MessageRepositoryImpl implements IMessageRepository {
  const MessageRepositoryImpl({required Database database})
    : _database = database;

  final Database _database;

  @override
  Future<FullMessage> createMessage({required PartialMessage message}) async {
    final dto = PartialMessageDto.fromEntity(message);
    final data = await _database
        .into(_database.messages)
        .insertReturning(dto.toCompanion());

    final fullMessage = FullMessageDto.fromData(message: data).toEntity();
    return fullMessage;
  }

  @override
  Future<List<FullMessage>> getMessages({
    required int chatId,
    int? beforeId,
    int limit = 50,
  }) async {
    final data =
        await (_database.select(_database.messages)
              ..where((row) => row.chatId.equals(chatId))
              ..orderBy([(message) => .asc(message.createdAt)]))
            .get();

    final messages = data
        .map((e) => FullMessageDto.fromData(message: e).toEntity())
        .toList();

    return messages;
  }
}
