class ExperienceItem {
  final String company;
  final String role;
  final String description;
  final List<String> highlights;
  final String period;
  final List<String> tags;

  const ExperienceItem({
    required this.company,
    required this.role,
    this.description = '',
    this.highlights = const [],
    required this.period,
    required this.tags,
  });
}
