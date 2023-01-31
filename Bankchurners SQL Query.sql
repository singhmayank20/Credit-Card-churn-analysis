use bankchurners;

 /* Distribution of Attrited customers based on age range */

     select case when Customer_Age < 20 then "0-20"
     when Customer_Age between 20 and 30 then "20-30"
     when Customer_Age between 30 and 40 then "30-40"
     when Customer_Age between 40 and 50 then "40-50"
     when Customer_Age between 50 and 60 then "50-60"
     when Customer_Age between 60 and 70 then "60-70" 
     when Customer_Age > 70 then "above 70" end as Age_Range,
     count(*) as Total 
     from bankchurners where Attrition_Flag = 'Attrited Customer'
     group by Age_Range order by Age_Range;
     
 /* Total Customers*/
     select count(Attrition_Flag) as Total
     from bankchurners;
 
     select count(Attrition_Flag) as Total
     from bankchurners
     where Attrition_Flag = 'Existing customer';

     select count(Attrition_Flag) as Total
     from bankchurners
     where Attrition_Flag = 'Attrited customer';



 /*Total Numbers of Male and Female In Existing and Attrited Customers*/

    select Attrition_Flag, sum(if(gender='M',1,Null)) as Male_Existing_Customer,
    sum(if(gender='F',1,Null)) as Female_Existing_Customer
    from bankchurners where Attrition_Flag='Existing Customer'
    union
    select Attrition_Flag, sum(if(gender='M',1,Null)) as Male_Attrited_Customer,
    sum(if(gender='F',1,Null)) as Female_Attrited_Customer
    from bankchurners where Attrition_Flag='Attrited Customer';



 /* Education Level Wise Distribution Of Existing and Attrited Customer */

     with Exisitng_total as (
     select Education_Level, count(*) as Existing from bankchurners
     where Attrition_Flag = 'Existing Customer'
     group by Education_Level order by Existing),
     Attrited_total as (
     select Education_Level, count(*) as Attrited from bankchurners
     where Attrition_Flag = 'Attrited Customer'
     group by Education_Level order by Attrited)
     select e.Education_Level, e.Existing, a.Attrited
     from Exisitng_total e inner join
     Attrited_total a on
     e.Education_Level = a.Education_Level;


  /* Marital Wise Distribution Of Existing and Attrited Customer*/

     with Existing_Total as (
     select Marital_Status, count(*) as Existing from bankchurners
     where Attrition_Flag = 'Existing Customer'
     group by Marital_Status ),
     Attrited_Total as (
     select Marital_Status, count(*) as Attrited from bankchurners
     where Attrition_Flag = 'Attrited Customer'
     group by Marital_Status )
     select e.Marital_Status, e.Existing, a.Attrited
     from Existing_Total e inner join
     Attrited_Total a on
     e.Marital_Status = a.Marital_Status;


  /* Attrited Customers Distribution Based On Months On Book*/

    select case When Months_on_book<20 then '0-20'
    when Months_on_book between 20 and 30 then '20-30'
    when Months_on_book between 30 and 40 then '30-40'
    when Months_on_book between 40 and 50 then '40-50'
    when Months_on_book between 50 and 60 then '50-60'
    when Months_on_book between 60 and 70 then '60-70'
    when Months_on_book > 70 then 'above 70' end as Monthbook_range,
    Count(*) as total from bankchurners 
    where Attrition_Flag = 'Attrited customer'
    group by Monthbook_range order by Monthbook_range;



 /* customers Distribution Based On Inactive Months*/

   with Existing_total as (
   select Months_Inactive_12_mon, count(*) as Existing from bankchurners
   where Attrition_Flag = 'Existing customer'
   group by Months_Inactive_12_mon),
   Attrited_total as (
   select Months_Inactive_12_mon, count(*) as Attrited from bankchurners
   where Attrition_Flag = 'Attrited customer'
   group by Months_Inactive_12_mon)
   select e.Months_Inactive_12_mon, e.Existing, a.Attrited
   from Existing_total e inner join
   Attrited_total a on
   e.Months_Inactive_12_mon = a.Months_Inactive_12_mon;

 /* customers Distribution Based On Avg Utilization*/

   with Average_Utilization as (
   select  Round(Avg(Avg_Utilization_Ratio)*100,2) as Avg
   from bankchurners 
   union
   select  Round(Avg(Avg_Utilization_Ratio)*100,2) as Avg
   from bankchurners where Attrition_Flag = 'Existing Customer'
   union
   select  Round(Avg(Avg_Utilization_Ratio)*100,2) as Avg
   from bankchurners where Attrition_Flag = 'Attrited Customer')
   select *, case when Avg = '27.49' then 'Total Customer' 
   when  Avg = '29.64' then 'Existing Customer' 
   else 'Attrited Customer' end as Attrition_Flag
   from Average_Utilization;


 /* customers Distribution Based On Card Category */

    with Exsiting_Total as (
   select Card_Category, Count(*) as Existing from bankchurners
   where Attrition_Flag = 'Existing Customer'
   group by Card_Category),
   Attrited_Total as (
   select Card_Category, Count(*) as Attrition from bankchurners
   where Attrition_Flag = 'Attrited Customer'
   group by Card_Category)
   select e.Card_Category, e.Existing, a.Attrition
   from Exsiting_Total e inner join
   Attrited_Total a on
   e.Card_Category = a.Card_Category;


 /* customers Distribution Based On Income Category */

   with Existing_Total as(
   select Income_Category, count(*) as `Existing Customer` from bankchurners
   where Attrition_Flag = 'Existing Customer'
   group by Income_Category),
   Attrited_Total as (
   select Income_Category, count(*) as `Attrited Customer` from bankchurners
   where Attrition_Flag = 'Attrited Customer'
   group by Income_Category)
   select e.Income_Category, e.`Existing Customer`, a.`Attrited Customer`
   from Existing_Total e inner join
   Attrited_Total a on
   e.Income_Category = a.Income_Category;
