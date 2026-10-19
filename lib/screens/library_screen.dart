import 'package:flutter/material.dart';
import '../data/sample_music_data.dart';
import '../models/music_item.dart';
import '../theme/theme.dart';
import '../widgets/library_search_bar.dart';
import '../widgets/playlist_vibe_card.dart';
import '../widgets/stacked_deck_view.dart';

enum LibraryViewMode {
  overview,
  stackedDeck,
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  LibraryViewMode _viewMode = LibraryViewMode.overview;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  late LibraryPlaylistItem _activePlaylist;

  @override
  void initState() {
    super.initState();
    _activePlaylist = SampleMusicData.playlists.first;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openPlaylistStack(LibraryPlaylistItem playlist) {
    setState(() {
      _activePlaylist = playlist;
      _viewMode = LibraryViewMode.stackedDeck;
    });
  }

  void _showCreatePlaylistSheet() {
    final colors = context.appColors;
    final nameController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colors.bgSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.borderDefault,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Create Music Collection',
                style: TextStyle(
                  fontFamily: AppTheme.titleFontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Curate your personal vinyl memory stack with friends',
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 13,
                  color: colors.textTertiary,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                autofocus: true,
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  color: colors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. Midnight Jazz & Rain',
                  hintStyle: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    color: colors.textDisabled,
                  ),
                  filled: true,
                  fillColor: colors.bgCanvas,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.borderSubtle),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.borderSubtle),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: colors.bgBrand, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    final name = nameController.text.trim();
                    if (name.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Created playlist "$name"'),
                          backgroundColor: colors.bgBrand,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Save & Add Tracks',
                    style: TextStyle(
                      fontFamily: AppTheme.bodyFontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterSheet() {
    final colors = context.appColors;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: colors.bgSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.borderDefault,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Sort & Filter Library',
                style: TextStyle(
                  fontFamily: AppTheme.titleFontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.sort_rounded, color: colors.textPrimary),
                title: Text(
                  'Recently Played',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.check_rounded, color: Color(0xFF3B82F6)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.history_rounded, color: colors.textSecondary),
                title: Text(
                  'Recently Added',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    color: colors.textPrimary,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: Icon(Icons.star_border_rounded, color: colors.textSecondary),
                title: Text(
                  'Top Played Memories',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    color: colors.textPrimary,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlaylistTracksSheet(LibraryPlaylistItem playlist) {
    final colors = context.appColors;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: colors.bgSurface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.borderDefault,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: playlist.heroImageUrl.startsWith('assets/')
                              ? Image.asset(
                                  playlist.heroImageUrl,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 52,
                                    height: 52,
                                    color: playlist.accentColor,
                                    child: const Icon(Icons.album, color: Colors.white),
                                  ),
                                )
                              : Image.network(
                                  playlist.heroImageUrl,
                                  width: 52,
                                  height: 52,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 52,
                                    height: 52,
                                    color: playlist.accentColor,
                                    child: const Icon(Icons.album, color: Colors.white),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist.title,
                                style: TextStyle(
                                  fontFamily: AppTheme.bodyFontFamily,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: colors.textPrimary,
                                ),
                              ),
                              Text(
                                '${playlist.genre} • ${playlist.durationText}',
                                style: TextStyle(
                                  fontFamily: AppTheme.bodyFontFamily,
                                  fontSize: 12.5,
                                  color: colors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_circle_fill_rounded, size: 40),
                          color: const Color(0xFF3B82F6),
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Playing "${playlist.title}"'),
                                backgroundColor: const Color(0xFF3B82F6),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: playlist.covers.length * 3,
                      itemBuilder: (context, index) {
                        final cover = playlist.covers[index % playlist.covers.length];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: cover.imageUrl.startsWith('assets/')
                                ? Image.asset(
                                    cover.imageUrl,
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 44,
                                      height: 44,
                                      color: cover.gradientColors.first,
                                      child: const Icon(Icons.music_note, color: Colors.white, size: 20),
                                    ),
                                  )
                                : Image.network(
                                    cover.imageUrl,
                                    width: 44,
                                    height: 44,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 44,
                                      height: 44,
                                      color: cover.gradientColors.first,
                                      child: const Icon(Icons.music_note, color: Colors.white, size: 20),
                                    ),
                                  ),
                          ),
                          title: Text(
                            '${cover.title} (Track ${index + 1})',
                            style: TextStyle(
                              fontFamily: AppTheme.bodyFontFamily,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                          subtitle: Text(
                            cover.artist,
                            style: TextStyle(
                              fontFamily: AppTheme.bodyFontFamily,
                              fontSize: 12,
                              color: colors.textTertiary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.more_vert_rounded,
                            size: 20,
                            color: colors.textDisabled,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.bgCanvas,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading / Title
                  if (_viewMode == LibraryViewMode.stackedDeck)
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _viewMode = LibraryViewMode.overview;
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 20,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _activePlaylist.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: AppTheme.bodyFontFamily,
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: colors.textPrimary,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    )
                  else
                    Text(
                      'Library',
                      style: TextStyle(
                        fontFamily: AppTheme.titleFontFamily,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                        letterSpacing: -0.8,
                      ),
                    ),

                  // Actions row
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Create playlist button
                      InkWell(
                        onTap: _showCreatePlaylistSheet,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colors.bgSurfaceRaised,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: colors.borderSubtle.withValues(alpha: 0.8),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 24,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // View toggle button
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_viewMode == LibraryViewMode.overview) {
                              _viewMode = LibraryViewMode.stackedDeck;
                            } else {
                              _viewMode = LibraryViewMode.overview;
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: colors.bgSurfaceRaised,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: colors.borderSubtle.withValues(alpha: 0.8),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            _viewMode == LibraryViewMode.overview
                                ? Icons.view_carousel_outlined
                                : Icons.segment_rounded,
                            size: 20,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LibrarySearchBar(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.trim();
                  });
                },
                onClear: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
                onFilterTap: _showFilterSheet,
              ),
            ),

            // Main Content View
            Expanded(
              child: _viewMode == LibraryViewMode.overview
                  ? _buildOverviewContent(colors)
                  : _buildStackedDeckContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewContent(AppSemanticColors colors) {
    final query = _searchQuery.toLowerCase();

    final filteredPlaylists = SampleMusicData.playlists.where((playlist) {
      if (query.isEmpty) return true;
      return playlist.title.toLowerCase().contains(query) ||
          playlist.genre.toLowerCase().contains(query) ||
          playlist.subtitle.toLowerCase().contains(query) ||
          playlist.covers.any((c) =>
              c.title.toLowerCase().contains(query) ||
              c.artist.toLowerCase().contains(query));
    }).toList();

    return ListView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 24),
      children: [
        // "Your playlist" header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                query.isEmpty ? 'Your playlist' : 'Your playlist matching "$query"',
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (query.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                '${filteredPlaylists.length} found',
                style: TextStyle(
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 12.5,
                  color: colors.textTertiary,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),

        // Pastel vibe playlist cards
        if (filteredPlaylists.isNotEmpty)
          ...filteredPlaylists.map((playlist) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PlaylistVibeCard(
                playlist: playlist,
                onTap: () => _openPlaylistStack(playlist),
                onAddTrackTap: _showCreatePlaylistSheet,
              ),
            );
          })
        else
          Container(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: 48,
                  color: colors.textDisabled,
                ),
                const SizedBox(height: 12),
                Text(
                  'No playlists found for "$_searchQuery"',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Try searching by title, artist, or music genre',
                  style: TextStyle(
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 12.5,
                    color: colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildStackedDeckContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: StackedDeckView(
        playlist: _activePlaylist,
        onExploreTap: () => _showPlaylistTracksSheet(_activePlaylist),
        onBackTap: () {
          setState(() {
            _viewMode = LibraryViewMode.overview;
          });
        },
      ),
    );
  }
}
