import '../../../../../core/database/database.dart';
import '../../../chat.dart';

abstract interface class IChatRepository {
  Future<ChatDto> createChat();

  Stream<ChatEntity> watchChat({required int id});

  Future<ChatEntity?> getChat({required int id});

  Future<void> addMember({required int chatId, required String uid});
}

class ChatRepositoryImpl implements IChatRepository {
  const ChatRepositoryImpl({required this._database});

  final Database _database;

  @override
  Future<ChatDto> createChat() async {
    final data = await _database
        .into(_database.chats)
        .insertReturning(ChatsCompanion());

    final result = ChatDto.fromData(chat: data);

    return result;
  }

  @override
  Stream<ChatEntity> watchChat({required int id}) =>
      (_database.select(_database.chats)..where((row) => row.id.equals(id)))
          .watchSingle()
          .map((row) => ChatDto.fromData(chat: row).toEntity());

  @override
  Future<ChatEntity?> getChat({required int id}) async {
    final data = await (_database.select(
      _database.chats,
    )..where((row) => row.id.equals(id))).getSingleOrNull();

    if (data == null) return null;

    final chat = ChatDto.fromData(chat: data).toEntity();

    return chat;
  }

  @override
  Future<void> addMember({required int chatId, required String uid}) async {
    await _database
        .into(_database.chatMembers)
        .insert(ChatMembersCompanion.insert(chatId: chatId, uid: uid));
  }
}
