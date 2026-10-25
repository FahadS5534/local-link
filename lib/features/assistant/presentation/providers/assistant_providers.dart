import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_link/features/routing/presentation/providers/routing_providers.dart';
import 'package:local_link/features/timetable/presentation/providers/timetable_providers.dart';
import '../../domain/services/journey_assistant_service.dart';

/// Provides the conversational [JourneyAssistantService].
final journeyAssistantServiceProvider = Provider<JourneyAssistantService>((
  ref,
) {
  final timetableRepo = ref.watch(timetableRepositoryProvider);
  final routeGraphService = ref.watch(routeGraphServiceProvider);

  return JourneyAssistantService(
    timetableRepo: timetableRepo,
    routeGraphService: routeGraphService,
  );
});

/// A single message in the assistant chat stream.
class ChatMessage {
  final String text;
  final bool isUser;
  final AssistantResponse? responseData;
  final DateTime timestamp;

  const ChatMessage({
    required this.text,
    required this.isUser,
    this.responseData,
    required this.timestamp,
  });
}

/// State notifier managing the assistant conversation history.
class AssistantChatNotifier extends StateNotifier<List<ChatMessage>> {
  final JourneyAssistantService _service;

  AssistantChatNotifier(this._service)
    : super([
        ChatMessage(
          text:
              'Namaskar! I am your LocalLink Journey Assistant. Ask me how to travel between any stations, find fast routes, or check Sunday Mega Blocks.',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      ]);

  Future<void> sendQuery(String query, {String lang = 'en'}) async {
    if (query.trim().isEmpty) return;

    final userMsg = ChatMessage(
      text: query,
      isUser: true,
      timestamp: DateTime.now(),
    );
    state = [...state, userMsg];

    final response = await _service.processQuery(query, lang: lang);
    final botMsg = ChatMessage(
      text: response.message,
      isUser: false,
      responseData: response,
      timestamp: DateTime.now(),
    );
    state = [...state, botMsg];
  }

  void clearChat() {
    state = [
      ChatMessage(
        text: 'Chat history cleared. How can I help you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    ];
  }
}

final assistantChatProvider =
    StateNotifierProvider<AssistantChatNotifier, List<ChatMessage>>((ref) {
      final service = ref.watch(journeyAssistantServiceProvider);
      return AssistantChatNotifier(service);
    });
