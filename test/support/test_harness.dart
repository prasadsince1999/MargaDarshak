import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:margadarshak/core/domain/models/models.dart';
import 'package:margadarshak/core/providers/user_provider.dart';
import 'package:margadarshak/core/storage/local_persistence.dart';
import 'package:margadarshak/core/theme/theme.dart';

/// Seeds a [UserProfile] into [userProvider] without touching disk.
class SeededUserNotifier extends UserNotifier {
  SeededUserNotifier(this.profile);

  final UserProfile? profile;

  @override
  UserProfile? build() => profile;
}

/// Backs [LocalPersistence] with an in-memory store so widget tests never
/// hit the platform channel. Call before creating persistence.
void useInMemoryPreferences() {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
}

/// A [LocalPersistence] backed by the in-memory store.
Future<LocalPersistence> createTestPersistence() async {
  useInMemoryPreferences();
  return LocalPersistence.create();
}

/// Builds a profile for a given stage and role. Only the fields the UI
/// actually reads are set — everything else stays at its real default so a
/// test never accidentally asserts against invented data.
UserProfile profileFor({
  required EducationStage stage,
  required UserRole role,
  AcademicStream stream = AcademicStream.none,
  String name = 'Aarav',
}) {
  final base = UserProfile(
    id: 'test-user',
    name: role == UserRole.parent ? 'Parent' : name,
    role: role,
    currentClass: stage.classLevel,
    board: 'CBSE',
    domicileState: 'OD',
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
    educationStage: stage,
    academicStream: stream,
  );

  if (role != UserRole.parent) return base;

  return base.copyWith(
    childProfile: ChildProfileSnapshot(
      name: name,
      currentClass: stage.classLevel,
      board: 'CBSE',
      domicileState: 'OD',
      educationStage: stage,
      pathwayType: stage.pathwayType,
      academicStream: stream,
    ),
  );
}

/// Pumps [child] inside a ProviderScope with the given profile seeded and
/// persistence backed by memory.
Future<void> pumpScreen(
  WidgetTester tester,
  Widget child, {
  UserProfile? profile,
}) async {
  final persistence = await createTestPersistence();

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        localPersistenceProvider.overrideWithValue(persistence),
        if (profile != null)
          userProvider.overrideWith(() => SeededUserNotifier(profile)),
      ],
      child: MaterialApp(theme: AppTheme.light, home: child),
    ),
  );
  await tester.pump();
}
