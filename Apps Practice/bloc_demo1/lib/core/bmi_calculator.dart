double calculateBmi({required double weightKg, required double heightCm}){
  final hM=heightCm/100;
  if(hM<=0) return 0;
  return weightKg / (hM*hM);
}

enum BmiCategory {underweight,normal,overweight,obese}

BmiCategory classifyBmi(double bmi){
  if(bmi<18.5) return BmiCategory.underweight;
  if(bmi<25) return BmiCategory.normal;
  if(bmi<30) return BmiCategory.overweight;
  return BmiCategory.obese; 
}