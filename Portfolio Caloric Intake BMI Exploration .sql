Create View CarbIntakePercentageVsHighBMI as
Select 
	carb.entity,
	carb.year,
	hBMI.[Indicator:Prevalence of overweight among adults, BMI &GreaterEqu],
	carb.[daily_caloric _intake_per_person_from_carbohydrates],
	([daily_caloric _intake_per_person_from_carbohydrates] - LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY carb.year ASC))/LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY carb.year ASC)*100 AS CarbIntakePercenageChange,
	([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu] - LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY hBMI.year ASC))/LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY hBMI.year ASC)*100 AS BMIpercentageChange

From Portfolio..BMIShare hBMI
Join Portfolio..CaloricIntake carb
	On hBMI.Entity = carb.entity
	where carb.entity like '%states%'
	and  hBMI.year = carb.year