import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_provider.dart';

/// Manages parent-child pair code linking.
///
/// **MVP: Local simulation only.**
/// A local pair code cannot connect two real phones. This is UI scaffolding
/// that prepares for Firebase-backed linking in a future phase:
/// ```
/// pairCodes/{code}
/// parentChildLinks/{linkId}
/// users/{userId}
/// ```
class PairCodeNotifier extends Notifier<PairCodeState> {
  static const _codeLength = 6;
  static const _codeChars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // no I/O/0/1

  @override
  PairCodeState build() {
    final user = ref.watch(userProvider);
    if (user == null) return const PairCodeState();
    return PairCodeState(
      code: user.pairCode,
      linkStatus: user.pairCode != null
          ? LinkStatus.pending
          : LinkStatus.notLinked,
      generatedAt: user.pairCode != null ? DateTime.now() : null,
    );
  }

  /// Generate a new random pair code for the student.
  void generateCode() {
    final rng = Random.secure();
    final code = String.fromCharCodes(
      Iterable.generate(
        _codeLength,
        (_) => _codeChars.codeUnitAt(rng.nextInt(_codeChars.length)),
      ),
    );
    ref.read(userProvider.notifier).setPairCode(code);
    state = PairCodeState(
      code: code,
      linkStatus: LinkStatus.pending,
      generatedAt: DateTime.now(),
    );
  }

  /// Regenerate — invalidates old code.
  void regenerateCode() => generateCode();

  /// Clear pair code (unlink).
  void clearCode() {
    ref.read(userProvider.notifier).setPairCode(null);
    state = const PairCodeState();
  }

  /// Simulate a parent entering a child's pair code.
  /// In MVP, this just sets the link status to "linked" locally.
  void simulateLink(String enteredCode) {
    // In real implementation, this would validate against Firebase.
    state = PairCodeState(
      code: enteredCode,
      linkStatus: LinkStatus.linked,
      generatedAt: state.generatedAt,
    );
  }
}

/// Link status for pair code UI.
enum LinkStatus { notLinked, pending, linked }

/// Pair code state.
class PairCodeState {
  const PairCodeState({
    this.code,
    this.linkStatus = LinkStatus.notLinked,
    this.generatedAt,
  });

  final String? code;
  final LinkStatus linkStatus;
  final DateTime? generatedAt;

  /// Whether the code is expired (>24 hours).
  bool get isExpired {
    if (generatedAt == null) return false;
    return DateTime.now().difference(generatedAt!) > const Duration(hours: 24);
  }

  String get statusLabel => switch (linkStatus) {
    LinkStatus.notLinked => 'Not linked',
    LinkStatus.pending => isExpired ? 'Expired' : 'Pending',
    LinkStatus.linked => 'Linked',
  };
}

final pairCodeProvider = NotifierProvider<PairCodeNotifier, PairCodeState>(() {
  return PairCodeNotifier();
});
