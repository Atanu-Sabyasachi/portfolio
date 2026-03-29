class ProjectItem {
  final String title;
  final String subtitle;
  final String description;
  final String? imageUrl;
  final String type; // e.g., 'WEB', 'APP', 'PACKAGE'
  final String? repoUrl;
  final String? actionCommand; // e.g., 'flutter pub add formguard'

  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.description,
    this.imageUrl,
    this.type = 'PROJECT',
    this.repoUrl,
    this.actionCommand,
  });
}
