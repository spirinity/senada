import 'package:flutter/material.dart';

/// Representation of an artist in Senada.
class ArtistItem {
  const ArtistItem({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.accentColor,
    this.initials,
  });

  final String id;
  final String name;
  final String role;
  final String avatarUrl;
  final Color accentColor;
  final String? initials;
}

/// Representation of a collaborator / listener avatar in a playlist.
class CollaboratorItem {
  const CollaboratorItem({
    required this.name,
    required this.avatarUrl,
    this.initials,
    this.backgroundColor,
  });

  final String name;
  final String avatarUrl;
  final String? initials;
  final Color? backgroundColor;
}

/// Representation of an album art card in a fanned deck.
class DeckCoverItem {
  const DeckCoverItem({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.rotationDegrees,
    required this.gradientColors,
    this.icon,
  });

  final String title;
  final String artist;
  final String imageUrl;
  final double rotationDegrees;
  final List<Color> gradientColors;
  final IconData? icon;
}

/// Representation of a playlist or collection in the Library.
class LibraryPlaylistItem {
  const LibraryPlaylistItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.trackCount,
    required this.yearsRange,
    required this.cardBackgroundColor,
    required this.accentColor,
    required this.covers,
    required this.collaborators,
    required this.extraCollaboratorsCount,
    required this.heroImageUrl,
    required this.genre,
    required this.durationText,
  });

  final String id;
  final String title;
  final String subtitle;
  final int trackCount;
  final String yearsRange;
  final Color cardBackgroundColor;
  final Color accentColor;
  final List<DeckCoverItem> covers;
  final List<CollaboratorItem> collaborators;
  final int extraCollaboratorsCount;
  final String heroImageUrl;
  final String genre;
  final String durationText;
}
