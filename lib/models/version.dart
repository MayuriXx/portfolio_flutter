import 'package:flutter/material.dart';

enum VersionStatus { live, soon }

class Version {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final VersionStatus status;
  final String? url;
  final String? githubUrl;
  final String description;
  final List<String> tags;

  const Version({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.status,
    required this.description,
    required this.tags,
    this.url,
    this.githubUrl,
  });

  bool get isLive => status == VersionStatus.live;
}
