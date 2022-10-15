import 'package:br_ipti_tag_app/app/features/classroom/domain/entities/classroom_entity.dart';

class ClassroomModel extends ClassroomEntity {
  ClassroomModel({
    required super.edcensoStageVsModalityFk,
    required super.name,
    required super.startTime,
    required super.endTime,
    required super.modalityId,
    required super.typePedagogicMediationId,
    required super.stage,
    required super.id,
    super.schooling = false,
    super.complementaryActivity = false,
    super.aee = false,
    super.moreEducationParticipator = false,
    super.aeeBraille = false,
    super.aeeOpticalNonOptical = false,
    super.aeeCognitiveFunctions = false,
    super.aeeMobilityTechniques = false,
    super.aeeLibras = false,
    super.aeeCaa = false,
    super.aeeCurriculumEnrichment = false,
    super.aeeSoroban = false,
    super.aeeAccessibleTeaching = false,
    super.aeePortuguese = false,
    super.aeeAutonomousLife = false,
  });

  factory ClassroomModel.fromJson(Map<String, dynamic> map) {
    return ClassroomModel(
      name: map['name'],
      id: map['_id'],
      startTime: '${map['initial_hour']}:${map['initial_minute']}',
      endTime: '${map['final_hour']}:${map['final_minute']}',
      modalityId: map['modality'],
      typePedagogicMediationId: map['pedagogical_mediation_type'],
      stage: map['edcenso_stage_vs_modality_fk'],
      edcensoStageVsModalityFk: map['edcenso_stage_vs_modality_fk'],
      schooling: map['schooling'] ?? false,
      aee: map['aee'] ?? false,
      aeeAccessibleTeaching: map['aee_accessible_teaching'] ?? false,
      aeeAutonomousLife: map['aee_autonomous_life'] ?? false,
      aeeBraille: map['aee_braille'] ?? false,
      aeeCaa: map['aee_caa'] ?? false,
      aeeCognitiveFunctions: map['aee_cognitive_functions'] ?? false,
      aeeCurriculumEnrichment: map['aee_curriculum_enrichment'] ?? false,
      aeeLibras: map['aee_libras'] ?? false,
      aeeMobilityTechniques: map['aee_mobility_techniques'] ?? false,
      aeeOpticalNonOptical: map['aee_optical_nonoptical'] ?? false,
      aeePortuguese: map['aee_portuguese'] ?? false,
      aeeSoroban: map['aee_soroban'] ?? false,
      complementaryActivity: map['complementary_activity'] ?? false,
      moreEducationParticipator: map['mais_educacao_participator'] ?? false,
    );
  }
}
