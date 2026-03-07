class MovieTorrent {
  final String hash;
  final String quality;
  final String type;

  MovieTorrent({
    required this.hash,
    required this.quality,
    this.type = '',
  });

  String magnetLink(String movieTitle) {
    final dn = Uri.encodeComponent(movieTitle);
    return 'magnet:?xt=urn:btih:$hash&dn=$dn'
        '&tr=udp://open.demonii.com:1337/announce'
        '&tr=udp://tracker.openbittorrent.com:80'
        '&tr=udp://tracker.coppersurfer.tk:6969'
        '&tr=udp://glotorrents.pw:6969/announce'
        '&tr=udp://tracker.opentrackr.org:1337/announce'
        '&tr=udp://torrent.gresille.org:80/announce'
        '&tr=udp://p4p.arenabg.com:1337'
        '&tr=udp://tracker.leechers-paradise.org:6969';
  }
}
