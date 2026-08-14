import 'package:drift/drift.dart';
import '../db/database.dart';
import '../../domain/models/chat_message.dart';

class ChatRepository {
  final AppDatabase db;
  ChatRepository(this.db);

  Future<List<ChatMessage>> getForPlan(int planId) async {
    final rows = await (db.select(db.chatMessages)
          ..where((m) => m.planId.equals(planId))
          ..orderBy([(m) => OrderingTerm.asc(m.createdAt)]))
        .get();
    return rows
        .map((r) => ChatMessage(
              planId: r.planId,
              role: ChatRole.values.byName(r.role),
              content: r.content,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  Future<void> add(ChatMessage m) async {
    await db.into(db.chatMessages).insert(
      ChatMessagesCompanion.insert(
        planId: m.planId,
        role: m.role.name,
        content: m.content,
        createdAt: m.createdAt,
      ),
    );
  }
}