class Assestment {
  int? age;
  String? jobDescription;
  String? existingCondition;
  String? familyHistory;
  bool? smoker;
  bool? married;

  Assestment({
    this.age,
    this.jobDescription,
    this.existingCondition,
    this.familyHistory,
    this.smoker,
    this.married,
  });

  factory Assestment.fromMap(Map<String, dynamic> data) => Assestment(
      age: data['age'],
      jobDescription: data['job_description'],
      existingCondition: data['existing_condition'],
      familyHistory: data['family_history'],
      smoker: data['smoker'],
      married: data['married']);

  toMap() => {
        'age': age,
        'job_description': jobDescription,
        'existing_condition': existingCondition,
        'family_history': familyHistory,
        'smoker': smoker,
        'married': married,
      };
}
