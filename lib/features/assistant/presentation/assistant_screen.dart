import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../timetable/presentation/screens/timetable_results_screen.dart';
import 'providers/assistant_providers.dart';

/// Screen presenting the trilingual Conversational Journey Assistant.
class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? quickText]) {
    final text = quickText ?? _textController.text;
    if (text.trim().isEmpty) return;

    final lang = Localizations.localeOf(context).languageCode;
    ref.read(assistantChatProvider.notifier).sendQuery(text, lang: lang);
    _textController.clear();

    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatMessages = ref.watch(assistantChatProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.smart_toy_outlined, color: AppColors.freshReportGreen),
            SizedBox(width: 8),
            Text('Journey Assistant'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Clear Chat',
            onPressed: () =>
                ref.read(assistantChatProvider.notifier).clearChat(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Offline truth in data banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: theme.colorScheme.surfaceContainerHighest.withAlpha(50),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_outlined,
                  size: 16,
                  color: AppColors.freshReportGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Offline Assistant • All answers derived from verified local railway timetables.',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),

          // Message stream list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final msg = chatMessages[index];
                return _ChatBubble(message: msg);
              },
            ),
          ),

          // Quick Prompt Suggestion Chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _PromptChip(
                  label: 'Bandra to Borivali',
                  onTap: () =>
                      _sendMessage('How to go from Bandra to Borivali?'),
                ),
                _PromptChip(
                  label: 'Fastest route to Dadar',
                  onTap: () =>
                      _sendMessage('Show me the fastest route to Dadar'),
                ),
                _PromptChip(
                  label: 'Thane to CSMT',
                  onTap: () => _sendMessage('Trains from Thane to CSMT'),
                ),
                _PromptChip(
                  label: 'Sunday Mega Block?',
                  onTap: () => _sendMessage('Is there any Mega Block today?'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Text entry field
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: theme.colorScheme.outlineVariant.withAlpha(60),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Ask in English, मराठी, or हिंदी...',
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const _ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.82,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUser
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isUser ? 16 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 16),
              ),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ),

          // If the response contains recommended routes, render action card
          if (!isUser &&
              message.responseData != null &&
              message.responseData!.recommendedRoutes.isNotEmpty) ...[
            const SizedBox(height: 8),
            ...message.responseData!.recommendedRoutes.take(2).map((route) {
              return Card(
                margin: const EdgeInsets.only(top: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.train_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${route.departureTimeFormatted} → ${route.arrivalTimeFormatted}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.freshReportGreen.withAlpha(30),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${route.totalDurationMinutes} mins',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.freshReportGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${route.intermediateStopsCount} stops • ${route.transferCount == 0 ? "Direct" : "${route.transferCount} Transfer"}',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            final origin = message.responseData?.origin;
                            final dest = message.responseData?.destination;
                            if (origin != null && dest != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => TimetableResultsScreen(
                                    origin: origin,
                                    destination: dest,
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.open_in_new, size: 14),
                          label: const Text(
                            'View Full Journey',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}

class _PromptChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PromptChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        onPressed: onTap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
