import 'package:dart_code_metrics/metrics_analyzer.dart';
import 'package:dart_code_metrics/reporters.dart';

// Using the dependency "dart_code_metrics" from
// https://pub.dev/packages/dart_code_metrics#-readme-tab-

void main() {
  // Files be to analyzed
  final filesToAnalyze = ['lib/auth/auth.dart', 'lib/auth/register.dart', 
  'lib/auth/signin.dart', 'lib/home/home.dart', 'lib/models/user.dart',
  'lib/services/auth_verify.dart', 'lib/services/database.dart',
  'lib/shared/constants.dart', 'lib/shared/loading.dart', 
  'lib/FirstScreen.dart', 'lib/FourthScreen.dart', 'lib/main.dart',
  'lib/SecondScreen.dart', 'lib/Settings.dart', 'lib/ThirdScreen.dart',
  'lib/wrapper.dart'];

  // Root folder path is used to resolve relative file paths
  final rootFolder = '/';
  
  // Recorder keeps reported issues in format-agnostic way
  final recorder = MetricsAnalysisRecorder();

  // Analyzer traverses files and report its findings to passed recorder
  final analyzer = MetricsAnalyzer(recorder);

  // Runner coordinates recorder and analyzer
  final runner = MetricsAnalysisRunner(recorder, analyzer, filesToAnalyze,
      rootFolder: rootFolder);

  // Execute run() to analyze files and collect results
  runner.run();

  // Now runner.results() contains some insights about analyzed code. Let's report it!
  // For a simple example we would report results to terminal

  // First of all config has to be created for a reporter
  final reporterConfig = Config(
      cyclomaticComplexityWarningLevel: 10,
      linesOfCodeWarningLevel: 120,
      numberOfArgumentsWarningLevel: 4);

  // Now the reporter itself
  final reporter = ConsoleReporter(reportConfig: reporterConfig);

  // Now pass collected analysis reports from runner to reporter and that's it
  reporter.report(runner.results()).forEach(print);
}