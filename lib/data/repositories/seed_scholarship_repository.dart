import '../../core/domain/models/models.dart';
import '../../core/domain/repositories/scholarship_repository.dart';
import '../seed/scholarship_seeds.dart';

/// In-memory seed implementation of [ScholarshipRepository].
class SeedScholarshipRepository implements ScholarshipRepository {
  const SeedScholarshipRepository([this._scholarships = seedScholarships]);

  final List<Scholarship> _scholarships;

  @override
  Future<List<Scholarship>> getScholarships({
    String? stateCode,
    bool? isNational,
  }) async {
    return _scholarships.where((sch) {
      if (isNational != null && sch.isNational != isNational) return false;
      if (stateCode != null &&
          sch.stateCode != null &&
          sch.stateCode != stateCode) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Future<Scholarship?> getScholarshipById(String id) async {
    try {
      return _scholarships.firstWhere((sch) => sch.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<Scholarship>> getEligibleScholarships(UserProfile user) async {
    final catString = switch (user.socialCategory) {
      SocialCategory.general => 'General',
      SocialCategory.obcNcl => 'OBC',
      SocialCategory.sc => 'SC',
      SocialCategory.st => 'ST',
      SocialCategory.ews => 'EWS',
      SocialCategory.unspecified => 'General',
    };

    return _scholarships.where((sch) {
      // 1. Category check
      if (sch.eligibilityCategory.isNotEmpty &&
          !sch.eligibilityCategory.contains(catString) &&
          !sch.eligibilityCategory.contains('General')) {
        return false;
      }

      // 2. State Domicile check
      if (!sch.isNational && sch.stateCode != null) {
        final stateMatch =
            user.domicileState.toLowerCase().contains(
              sch.stateCode!.toLowerCase(),
            ) ||
            (sch.stateCode == 'OD' &&
                user.domicileState.toLowerCase().contains('odisha')) ||
            (sch.stateCode == 'MH' &&
                user.domicileState.toLowerCase().contains('maharashtra'));
        if (!stateMatch && user.domicileState.isNotEmpty) {
          return false;
        }
      }

      // 3. Gender check (e.g. Pragati for girls)
      if (sch.id == 'sch_aicte_pragati' && user.gender != Gender.female) {
        return false;
      }

      // 4. PwD check (e.g. Saksham)
      if (sch.id == 'sch_aicte_saksham' && user.pwdStatus != PwdStatus.pwd) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  Future<List<Scholarship>> searchScholarships(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return _scholarships;

    return _scholarships.where((sch) {
      return sch.name.toLowerCase().contains(q) ||
          sch.provider.toLowerCase().contains(q) ||
          (sch.description?.toLowerCase().contains(q) ?? false) ||
          (sch.portalName?.toLowerCase().contains(q) ?? false);
    }).toList();
  }
}
