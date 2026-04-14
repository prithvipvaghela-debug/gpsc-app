import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/ai_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/gpsc_page_scaffold.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! I am your GPSC Smart Tutor. How can I help you today?', 'isUser': false},
  ];
  bool _isTyping = false;

  // SUBJECT SELECTION
  String _selectedSubject = "General";
  final List<String> _subjects = ["General", "Economy", "Science & Tech", "Environment"];

  // SYSTEM PROMPT BASE
  final String _systemPrompt = """Explain in simple language.
Give structured answers.
If possible, include:
- key points
- examples
- short summary

""";

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  // LOAD MESSAGES FROM LOCAL STORAGE
  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedChat = prefs.getString('chat_history');
    if (savedChat != null) {
      try {
        final List<dynamic> decodedChat = jsonDecode(savedChat);
        setState(() {
          _messages = decodedChat.map((msg) => Map<String, dynamic>.from(msg)).toList();
        });
        _scrollToBottom();
      } catch (e) {
        debugPrint('Error loading chat history: $e');
      }
    }
  }

  // SAVE MESSAGES TO LOCAL STORAGE
  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedChat = jsonEncode(_messages);
    await prefs.setString('chat_history', encodedChat);
  }

  void _addMessage(String text, bool isUser) async {
    setState(() {
      _messages.add({'text': text, 'isUser': isUser});
    });
    _saveMessages();
    _scrollToBottom();
    
    if (isUser) {
      setState(() => _isTyping = true);
      try {
        // PREPEND SUBJECT CONTEXT AND SYSTEM PROMPT
        final subjectHeader = "Subject: $_selectedSubject\nYou are a GPSC expert.\nAnswer strictly for this subject.\n\n";
        final aiInput = subjectHeader + _systemPrompt + text;
        
        final response = await AiService().getAiResponse(aiInput);
        
        if (mounted) {
          setState(() {
            _messages.add({'text': response, 'isUser': false});
            _isTyping = false;
          });
          _saveMessages();
          _scrollToBottom();
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _messages.add({'text': 'Sorry, I encountered an error. Please try again.', 'isUser': false});
            _isTyping = false;
          });
          _saveMessages();
          _scrollToBottom();
        }
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GpscPageScaffold(
      title: 'Smart Tutor',
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: _messages[index]['text'],
                  isUser: _messages[index]['isUser'],
                );
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Tutor is thinking...',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          _buildInputPanel(theme),
        ],
      ),
    );
  }

  Widget _buildInputPanel(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SUBJECT & QUICK ACTIONS
          Row(
            children: [
              _buildSubjectDropdown(theme),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      QuickActionButton(
                        label: 'Explain Topic', 
                        onTap: () => _addMessage('Explain this topic clearly for GPSC exam: ', true)
                      ),
                      QuickActionButton(
                        label: 'Generate MCQs', 
                        onTap: () => _addMessage('Generate 5 MCQs with answers for: ', true)
                      ),
                      QuickActionButton(
                        label: 'Short Notes', 
                        onTap: () => _addMessage('Give short revision notes for: ', true)
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // TEXT INPUT
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Ask your query...',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                  ),
                  onSubmitted: (val) {
                    if (val.trim().isNotEmpty) {
                      _addMessage(val.trim(), true);
                      _textController.clear();
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (_textController.text.trim().isNotEmpty) {
                    _addMessage(_textController.text.trim(), true);
                    _textController.clear();
                  }
                },
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedSubject,
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: theme.colorScheme.primary),
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSubject = newValue;
              });
            }
          },
          items: _subjects.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
