--Carbohydrate caloric intake Vs increse in BMI in Saudi Arabia
With carbVsBMI 
as
(
Select 
	carb.entity,
	carb.year,
	hBMI.[Indicator:Prevalence of overweight among adults, BMI &GreaterEqu],
	carb.[daily_caloric _intake_per_person_from_carbohydrates],
	([daily_caloric _intake_per_person_from_carbohydrates] - LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY carb.year ASC))/LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY carb.year ASC)*100 AS CarbIntakePercenageChange,
	([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu] - LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY hBMI.year ASC))/LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY hBMI.year ASC)*100 AS BMIpercentageChange

	From Portfolio..BMIShare hBMI
	Join Portfolio..caloricIntake carb

	On hBMI.Entity = carb.entity
	where carb.entity like '%saudi%'
	and  hBMI.year = carb.year

)

--Show caloric Intake in saudi arabi
Select  * from carbVsBMI
select [year],entity,[daily_caloric _intake_per_person_from_carbohydrates],

lag([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY  Year ASC) as pastYearCaloricCarbs, 
lead (([daily_caloric _intake_per_person_from_carbohydrates])) OVER (ORDER BY Year ASC) AS nextYearCaloricIntake,
([daily_caloric _intake_per_person_from_carbohydrates] - LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY year ASC))/LAG ([daily_caloric _intake_per_person_from_carbohydrates]) OVER (ORDER BY year ASC)*100 AS percenageChange
from 
portfolio..CaloricIntake
where entity like '%saudi%'



--BMI rates in Saudi Arabia
select 
[year],
Entity,
[Indicator:Prevalence of overweight among adults, BMI &GreaterEqu],

lag([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY  Year ASC) as ContryAverage, 
lead (([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu])) OVER (ORDER BY Year ASC) AS next_year_revenue,
([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu] - LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY year ASC))/LAG ([Indicator:Prevalence of overweight among adults, BMI &GreaterEqu]) OVER (ORDER BY year ASC)*100 AS percentage_growth

from portfolio..BMIShare
where Entity like '%saudi%'

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