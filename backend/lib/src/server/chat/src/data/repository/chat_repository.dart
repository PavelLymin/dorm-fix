import '../../../../../core/database/database.dart';
import '../../../chat.dart';

abstract interface class IChatRepository {
  Future<FullChat> createChat({required PartialChat chat});

  Future<FullChat?> getChatByRequestId({required int requestId});

  Future<void> addMember({required int chatId, required String uid});
}

class ChatRepositoryImpl implements IChatRepository {
  const ChatRepositoryImpl({required Database database}) : _database = database;

  final Database _database;

  @override
  Future<FullChat> createChat({required PartialChat chat}) async {
    final dto = PartialChatDto.fromEntity(chat);
    final data = await _database
        .into(_database.chats)
        .insertReturning(dto.toCompanion());

    return FullChatDto.fromData(chat: data).toEntity();
  }

  @override
  Future<FullChat?> getChatByRequestId({required int requestId}) async {
    final data = await (_database.select(
      _database.chats,
    )..where((row) => row.requestId.equals(requestId))).getSingleOrNull();

    if (data == null) return null;

    return FullChatDto.fromData(chat: data).toEntity();
  }

  @override
  Future<void> addMember({required int chatId, required String uid}) async {
    await _database
        .into(_database.chatMembers)
        .insert(ChatMembersCompanion.insert(chatId: chatId, uid: uid));
  }
}
