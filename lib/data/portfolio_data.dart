import '../models/experience_item.dart';
import '../models/project_item.dart';

class PortfolioData {
  static const List<ExperienceItem> experiences = [
    ExperienceItem(
      company: "Telemerge IT Services",
      role: "ENTERPRISE BANKING SPECIALIST",
      description:
          "Leading development for critical Enterprise Banking Infrastructure focusing on ReKYC modules. Streamlining complex regulatory workflows into intuitive digital experiences.",
      period: "2024 - PRESENT",
      tags: ["FLUTTER", "BLOC", "CLEAN ARCHITECTURE"],
    ),
    ExperienceItem(
      company: "TNS Mobile Solutions",
      role: "SENIOR MOBILE DEVELOPER",
      highlights: [
        "NIGAM LAHARI\nHigh-performance audio streaming engine with real-time sync and low-latency playback.",
        "TNS HEALTH\nTele-medicine platform integrated with RTC capabilities for seamless patient-doctor consultation.",
        "MY MED STORE\nEnterprise-grade inventory management and retail system for pharmaceutical distribution.",
      ],
      period: "2021 - 2024",
      tags: ["FLUTTER", "FIREBASE", "AGORA RTC", "WEBRTC"],
    ),
  ];

  static const List<ProjectItem> openSourcePackages = [
    ProjectItem(
      title: "next_page",
      subtitle: "State management framework",
      description:
          "Robust navigation and state framework for large scale applications.",
      type: "PACKAGE",
      actionCommand: "flutter pub add next_page",
    ),
    ProjectItem(
      title: "flutter_env_config",
      subtitle: "Environment configuration",
      description:
          "Type-safe environment configuration loader combining dart defines and json files.",
      type: "PACKAGE",
      actionCommand: "flutter pub add flutter_env_config",
    ),
    ProjectItem(
      title: "nest_db",
      subtitle: "Local database wrapper",
      description:
          "NoSQL abstraction layer for local databases within Flutter applications.",
      type: "PACKAGE",
      actionCommand: "flutter pub add nest_db",
    ),
    ProjectItem(
      title: "image_scope",
      subtitle: "Image processing tool",
      description:
          "Advanced image processing and caching framework for fast, robust downloads.",
      type: "PACKAGE",
      actionCommand: "flutter pub add image_scope",
    ),
    ProjectItem(
      title: "formguard",
      subtitle: "Form validation framework",
      description:
          "Robust validation rule engine with support for complex async validation.",
      type: "PACKAGE",
      actionCommand: "flutter pub add formguard",
    ),
    ProjectItem(
      title: "snackify",
      subtitle: "Notification management",
      description:
          "Centralized notification management framework with queuing logic.",
      type: "PACKAGE",
      actionCommand: "flutter pub add snackify",
    ),
  ];
}
