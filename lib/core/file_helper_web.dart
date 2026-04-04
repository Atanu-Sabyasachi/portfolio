// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<void> downloadFile(String url) async {
  // If the URL is just 'assets/resume-Atanu Sabyasachi Jena.pdf', we might want to make it relative to base
  html.AnchorElement(href: url)
    ..setAttribute('download', 'resume-Atanu Sabyasachi Jena.pdf')
    ..target = '_blank'
    ..click();
}
