import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/input_option_card.dart';
import '../widgets/quick_action_button.dart';

class SmartStudyAIScreen extends StatefulWidget {
  const SmartStudyAIScreen({super.key});

  @override
  State<SmartStudyAIScreen> createState() => _SmartStudyAIScreenState();
}

class _SmartStudyAIScreenState extends State<SmartStudyAIScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {'message': 'Hello! How can I help you learn smarter today?', 'isUser': false},
  ];
  final ImagePicker _picker = ImagePicker();

  void _addMessage(String text, bool isUser) {
    setState(() {
      _messages.add({'message': text, 'isUser': isUser});
    });
    _scrollToBottom();
    
    if (isUser) {
      Future.delayed(const Duration(seconds: 1), () {
        _addMessage("I've received your input and I'm analyzing it. (Premium AI Placeholder)", false);
      });
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

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _addMessage('Uploaded Image: ${image.name}', true);
    }
  }

  Future<void> _pickFile() async {
    // Correct syntax for file_picker ^11.0.2
    final result = await FilePicker.instance.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final String fileName = result.files.single.name;
      _addMessage('Uploaded File: $fileName', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Smart Study AI', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Scan. Ask. Learn smarter.',
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: _messages[index]['message'],
                  isUser: _messages[index]['isUser'],
                );
              },
            ),
          ),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      QuickActionButton(label: 'Explain Topic', onTap: () => _addMessage('Explain this topic', true)),
                      QuickActionButton(label: 'Generate MCQs', onTap: () => _addMessage('Generate MCQs from this', true)),
                      QuickActionButton(label: 'Summarize Content', onTap: () => _addMessage('Summarize this content', true)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: [
                    InputOptionCard(icon: Icons.camera_alt_outlined, label: 'Camera', onTap: () => _pickImage(ImageSource.camera)),
                    InputOptionCard(icon: Icons.image_outlined, label: 'Gallery', onTap: () => _pickImage(ImageSource.gallery)),
                    InputOptionCard(icon: Icons.picture_as_pdf_outlined, label: 'PDF', onTap: _pickFile),
                    InputOptionCard(icon: Icons.file_present_outlined, label: 'File', onTap: _pickFile),
                    InputOptionCard(icon: Icons.chat_bubble_outline, label: 'Chat', onTap: () {}),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: 'Ask anything...',
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
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
                    FloatingActionButton.small(
                      onPressed: () {
                        if (_textController.text.trim().isNotEmpty) {
                          _addMessage(_textController.text.trim(), true);
                          _textController.clear();
                        }
                      },
                      elevation: 0,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
