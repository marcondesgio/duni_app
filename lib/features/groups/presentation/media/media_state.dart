import 'package:duni_app/core/design_system/design_system.dart';

class MediaState {
  const MediaState({
    this.isLoading = true,
    this.mediaUrls = const [],
    this.mode = DuniMediaGridMode.grid,
  });

  final bool isLoading;
  final List<String> mediaUrls;
  final DuniMediaGridMode mode;

  MediaState copyWith({
    bool? isLoading,
    List<String>? mediaUrls,
    DuniMediaGridMode? mode,
  }) {
    return MediaState(
      isLoading: isLoading ?? this.isLoading,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mode: mode ?? this.mode,
    );
  }
}
