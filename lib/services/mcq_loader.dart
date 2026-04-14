import 'data_recovery_service.dart';

class MCQLoader {
  static Future<List<dynamic>> loadMCQs() async {
    // Uses the safety-first recovery service
    return await DataRecoveryService.loadMCQsSafe('assets/data/gpsc_all_mcqs.json');
  }
}
