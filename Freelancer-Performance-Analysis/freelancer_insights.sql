create database freelancer_database;
use freelancer_database;

show tables;

select * from freelancers;

alter table freelancers
rename column `Hourly_Rate(USD)` to Hourly_Rate_USD;

# Which top 3 skills has the highest average hourly rates?
select Skill, ROUND(AVG(Hourly_Rate_USD), 2) as Average_Hourly_Rate
from freelancers
group by Skill
order by AVG(Hourly_Rate_USD) desc
limit 3;

# Which 3 countries has the highest average freelancers rating?
select Country, ROUND(AVG(Rating),1) as Average_Freelancer_Rating
from freelancers
group by Country
order by AVG(Rating) desc
limit 3;

# What is the average experience of freelancers per skill?
select Skill, ROUND(AVG(Experience),1) aS Average_Experience
from freelancers
group by Skill;

# How many freelancers exist in each skill category?
select Skill, COUNT(Freelancer_Id) 
from freelancers
group by Skill
order by COUNT(Freelancer_Id) desc;

# Which skills have an average hourly rate greater than overall average?
Select Skill, Round(AVG(Hourly_Rate_USD),2) as Avg_Hourly_Rate
from freelancers
group by Skill
having AVG(Hourly_Rate_USD) > (
	select AVG(Hourly_Rate_USD)
    from freelancers);

# Which countries have more than 50 freelancers?
select Country, COUNT(Freelancer_Id) as Freelancers_Count
from freelancers
group by Country
having COUNT(Freelancer_Id) > 50;

# Which skills have client satisfaction greater than 0.8 on average?
select Skill, ROUND(AVG(Client_Satisfaction),1) as Avg_Client_Satisfaction
from freelancers
group by Skill
having AVG(Client_Satisfaction) > 0.8;

# How many males and females are Freelancers?
Select Gender, COUNT(Freelancer_Id) as Freelancers_Count
from freelancers
group by Gender;

# Which skills have both high rating (>4) and high experience (>10 avg)?
Select Skill, ROUND(AVG(Rating),1), ROUND(AVG(Experience),1)
from freelancers
group by Skill
having AVG(Rating) > 4 AND AVG(Experience) > 10;

# Who are the freelancers earning more than the global average hourly rate?
select * from freelancers
where Hourly_Rate_USD > (
	select AVG(Hourly_Rate_USD)
    from freelancers
    );
    
# Which freelancers have experience higher than the average experience of their skill group?
SELECT *
FROM freelancers
WHERE Experience > (
    SELECT AVG(Experience)
    FROM freelancers
);

# Which freelancers are above the overall average rating AND above average satisfaction?
select * from freelancers
where Rating > (
	select AVG(Rating) from freelancers
    )
AND Client_Satisfaction > (
	select AVG(Client_Satisfaction) from freelancers
    );

# Who are the top 10% highest earning freelancers?
SELECT *
FROM (
    SELECT *,
           NTILE(10) OVER (ORDER BY Hourly_Rate_USD DESC) AS decile
    FROM freelancers
) t
WHERE decile = 1;

# Rank freelancers by hourly rate within each skill category
select * , dense_rank() over(
	partition by Skill order by Hourly_Rate_USD desc) as Hourly_Rate_Rank
from freelancers ;

# Rank freelancers by rating within each country
select * , dense_rank() over(
	partition by Country order by Rating desc) as Rating_Rank
from freelancers ;

# Find each freelancer’s rank compared to others in the same skill
select * , dense_rank() over(
	partition by Skill
    order by Hourly_Rate_USD desc) as Skill_Rank
from freelancers ;

# Find difference between freelancer hourly rate and skill-wise average rate
select *,
	ROUND(Hourly_Rate_USD - AVG(Hourly_Rate_USD) over(partition by Skill), 2) as Hourly_Rate_Difference
from freelancers;

# Identify top performer (rank 1) in each skill based on rating
select * from (
	select *, row_number() over(partition by Skill order by Rating desc) as Top_Rating
    from freelancers) t
where Top_Rating = 1;
