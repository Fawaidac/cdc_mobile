class QuestionnaireCheck {
  int id;
  String userId;
  int identitasSection;
  int mainSection;
  int furtheStudySection;
  int competentLevelSection;
  int studyMethodSection;
  int jobsStreetSection;
  int howFindJobsSection;
  int companyAppliedSection;
  int jobSuitabilitySection;
  DateTime createdAt;
  DateTime updatedAt;

  QuestionnaireCheck({
    required this.id,
    required this.userId,
    required this.identitasSection,
    required this.mainSection,
    required this.furtheStudySection,
    required this.competentLevelSection,
    required this.studyMethodSection,
    required this.jobsStreetSection,
    required this.howFindJobsSection,
    required this.companyAppliedSection,
    required this.jobSuitabilitySection,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionnaireCheck.fromJson(Map<String, dynamic> json) {
    return QuestionnaireCheck(
      id: json['id'],
      userId: json['user_id'],
      identitasSection: json['identitas_section'],
      mainSection: json['main_section'],
      furtheStudySection: json['furthe_study_section'],
      competentLevelSection: json['competent_level_section'],
      studyMethodSection: json['study_method_section'],
      jobsStreetSection: json['jobs_street_section'],
      howFindJobsSection: json['how_find_jobs_section'],
      companyAppliedSection: json['company_applied_section'],
      jobSuitabilitySection: json['job_suitability_section'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
