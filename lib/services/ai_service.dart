import 'dart:async';

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  /// Mock API call to get an AI response.
  /// Replace this with a real API call (e.g., OpenAI, Google Gemini, etc.)
  Future<String> getAiResponse(String userQuery) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    final query = userQuery.toLowerCase();

    if (query.contains('explain this topic')) {
      return 'Of course! Which topic would you like me to explain for GPSC? I can cover anything from Ancient History to Indian Polity.';
    } else if (query.contains('generate mcqs')) {
      return 'Sure! Here are some sample MCQs for you:\n\n1. Who discovered the first Paleolithic tool in India?\n   A. H.D. Sankalia\n   B. Robert Bruce Foote\n   C. Dayaram Sahni\n   D. John Marshall\n\nCorrect Answer: B. Robert Bruce Foote';
    } else if (query.contains('summarize chapter')) {
      return 'I can summarize any chapter for you. Please let me know which one you\'re studying, and I\'ll give you the key highlights and important points for GPSC exams.';
    } else if (query.contains('hello') || query.contains('hi')) {
      return 'Hello! I am your GPSC AI Assistant. How can I help you with your preparation today? You can ask me to explain topics, generate MCQs, or summarize chapters.';
    }

    return 'That\'s an interesting question! For the GPSC exam, it\'s important to focus on the historical context and the impact on Gujarat. Let me look that up for you or try rephrasing with "Explain this topic".';
  }

  Future<String> getHistorySummary() async {
    await Future.delayed(const Duration(seconds: 1));
    return """
### 📜 History Summary for GPSC

**1. Ancient India & Gujarat:**
- **Indus Valley:** Focus on Lothal (maritime hub) and Dholavira (water management).
- **Mauryan & Gupta:** Ashoka's edicts in Junagadh and the Golden Age of Guptas.
- **Vedic Period:** Early vs Later Vedic social structures.

**2. Medieval Period:**
- **Solanki Dynasty:** Known as the Golden Age of Gujarat.
- **Delhi Sultanate & Mughals:** Impact of administrative reforms like Mansabdari system.
- **Marathas:** Gaekwads of Baroda and their contribution to education.

**3. Modern History (The Core):**
- **1857 Revolt:** Role of local leaders in Gujarat.
- **Gandhian Era:** Major Satyagrahas (Kheda, Ahmedabad Mill, Bardoli).
- **Freedom Struggle:** Dandi March and the Quit India Movement.

**4. Key Personalities:**
- Sardar Patel (Unification), Mahatma Gandhi (Non-violence), and local heroes like Shyamji Krishna Varma.

**Focus Area:** Always link national events with their impact or parallel events in Gujarat for GPSC Mains.
""";
  }
}
