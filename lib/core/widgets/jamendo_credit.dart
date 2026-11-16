import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/song.dart';

/// Kredit wajib dari syarat API Jamendo: pencipta, penyedia, dan tautan ke halaman lagunya.
class JamendoCredit extends StatelessWidget {
  const JamendoCredit({super.key, required this.song, required this.color});

  final Song song;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      child: InkWell(
        onTap: () => launchUrl(
          Uri.https('www.jamendo.com', '/track/${song.id}'),
          mode: LaunchMode.externalApplication,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Musik oleh ${song.artist} di Jamendo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: color),
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.open_in_new_rounded, size: 14, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
