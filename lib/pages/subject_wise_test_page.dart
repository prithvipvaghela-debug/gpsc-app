import 'package:flutter/material.dart';
import '../widgets/gpsc_page_scaffold.dart';
import '../widgets/section_cards.dart';
import 'full_length_test_page.dart';
import 'dynamic_mcq_page.dart';

class SubjectWiseTestPage extends StatelessWidget {
  const SubjectWiseTestPage({
    super.key,
    this.isExamMode = false,
  });

  final bool isExamMode;

  final List<Map<String, dynamic>> subjects = const [
    {'name': 'History', 'icon': Icons.history_edu_rounded, 'color': Colors.blue},
    {'name': 'Polity', 'icon': Icons.gavel_rounded, 'color': Colors.orange},
    {'name': 'Geography', 'icon': Icons.public_rounded, 'color': Colors.green},
    {'name': 'Economics', 'icon': Icons.trending_up_rounded, 'color': Colors.purple},
    {'name': 'Science', 'icon': Icons.science_rounded, 'color': Colors.red},
    {'name': 'Current Affairs', 'icon': Icons.newspaper_rounded, 'color': Colors.teal},
    {'name': 'General Knowledge', 'icon': Icons.psychology_rounded, 'color': Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    return GpscPageScaffold(
      title: isExamMode ? 'Subject Exam' : 'Subject Practice',
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return SectionItemCard(
            title: subject['name'],
            subtitle: isExamMode ? '50 Qs • 30 Min' : 'Unlimited Practice',
            icon: subject['icon'],
            onTap: () {
              if (isExamMode) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullLengthTestPage(
                      title: '${subject['name']} Exam',
                      examId: 'subject_exam_${subject['name'].toString().toLowerCase().replaceAll(' ', '_')}',
                      subject: subject['name'],
                      isUniversal: false,
                      durationMinutes: 30,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DynamicMCQPage(
                      title: '${subject['name']} Practice',
                      subject: subject['name'],
                      quizId: 'practice_${subject['name'].toString().toLowerCase().replaceAll(' ', '_')}',
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
