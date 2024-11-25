import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/presentation/providers/providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(moviesSiliceShowProvider).isEmpty;
  final step2 = ref.watch(nowPlayingMoviesProvider).isEmpty;

  if (step1 || step2) return true;

  return false;
});
