class Assestment {
  int? age;
  String? gender;
  String? jobTitle;
  String? existingCondition;
  String? familyHistory;
  bool? smoker;
  bool? married;

  Assestment({
    this.age,
    this.gender,
    this.jobTitle,
    this.existingCondition,
    this.familyHistory,
    this.smoker,
    this.married,
  });

  factory Assestment.fromMap(Map<String, dynamic> data) => Assestment(
      age: data['age'],
      gender: data['gender'],
      jobTitle: data['job_title'],
      existingCondition: data['existing_condition'],
      familyHistory: data['family_history'],
      smoker: data['smoker'],
      married: data['married']);

  toMap() => {
        'age': age,
        'gender': gender,
        'job_title': jobTitle,
        'existing_condition': existingCondition,
        'family_history': familyHistory,
        'smoker': smoker,
        'married': married,
      };
}
