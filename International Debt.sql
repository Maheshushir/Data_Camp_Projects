 create database International_debt;
 use International_debt;

/* 
To manage their economies, countries sometimes take on debt, just as individuals do to meet their basic needs. 
Infrastructure investments, which are essential for the well-being of a nation's citizens, can be quite costly. 
The World Bank is a key institution that provides debt to countries.
we will be examining an international debt dataset from The World Bank, which encompasses information about the debt amounts (in USD)
 owed by developing countries across different categories. Our analysis will focus on unraveling the complexities of international debt and its implications.
 */
  
 select *
 from main
 limit 5;
 
 /* Number of distinct countries - 
 we can observe the debt owed by Afghanistan across various debt indicators in the first ten rows of the table. 
 However, we lack information about the number of unique countries featured in the table. 
 Since country names may repeat due to multiple debt indicators, understanding the count of unique countries is crucial for a comprehensive statistical analysis. 
 Let's proceed with extracting the number of unique countries present in the dataset. */
 
 select count(distinct(country_name)) as Total_Distinct_Countries
 from main ; 
 
 /* distinct debt indicators -
 In the dataset, we have identified a total of 124 unique countries listed. 
 Additionally, the column "indicator_name" provides a brief description of the purpose of the debt, while the "indicator_code" column categorizes these debts. 
 Understanding these diverse debt indicators is essential for gaining insights into the areas where countries may hold debt. */
 
 select distinct(indicator_code) as Distinct_Debt_Indicator
 from main
 order by Distinct_Debt_Indicator;
 
 /* Total amount of debt owed by the countries - 
 Considering the impact of a country's financial debt on its economic condition, it's pertinent to extend our analysis to a global scale. 
 Thus, shifting focus from the specific debt indicators, we aim to determine the total debt amount (in USD) owed by various countries.
 This broader perspective will provide valuable insights into the overall economic status of the world. */
 
 SELECT ROUND(SUM(debt)/1000000, 2) AS Total_Debt
FROM main;

/* Country with the highest debt -
Quantifying the total debt amounts owed by numerous countries reveals staggering figures that are challenging for us to comprehend, as highlighted by Daniel Kahneman. 
Now, let's focus on identifying the country with the highest total debt and the corresponding amount. 
This valuable insight will offer a deeper understanding of the socio-economic landscape of the country. 
Delving into the specific debt category with the highest amount of debt belonging to the same country will be deferred for the moment. */

SELECT country_name, SUM(debt) AS Total_Debt
FROM main
GROUP BY country_name
ORDER BY total_debt DESC 
LIMIT 1; 

/* Average amount of debt across indicators - 
After exploring the dataset and reviewing some summary statistics, we've gained insights into the various debt indicators across countries.
To deepen our analysis, let's now investigate the average debt amount owed by each country. 
Calculating this average will provide a clearer picture of how debt is distributed across different indicators, enhancing our understanding of the dataset. */

SELECT indicator_code AS Debt_Indicator, indicator_name, AVG(debt) AS Average_Debt
FROM main
GROUP BY Debt_Indicator, indicator_name
ORDER BY Average_Debt DESC
LIMIT 10;

/*  Highest amount of principal repayments -
A notable observation from the previous analysis is the significant disparity among the debt amounts in the various debt indicators, particularly after the second indicator. 
This discrepancy suggests that the first two indicators may represent the most critical categories in which countries accumulate debt.

To delve deeper, let's focus on identifying the country with the highest debt amount in the long-term debt category (DT.AMT.DLXF.CD).
By pinpointing this information, we can gain a more nuanced understanding of the economic status of that specific country, 
considering the unique economic challenges and circumstances faced by different nations.  */ 

SELECT country_name, indicator_name
FROM main
WHERE debt = (SELECT 
                 MAX(debt)
             FROM main
             WHERE indicator_code = 'DT.AMT.DLXF.CD');
             
             
/*  Most common debt indicator -              
China emerges as the country with the highest debt amount in the long-term debt category (DT.AMT.DLXF.CD), confirming our earlier analysis. 
Validating our findings is crucial to ensuring the accuracy of our investigations.

Having identified long-term debt as the top category in terms of average debt amounts, the next question arises: 
Is long-term debt the most prevalent indicator in which countries accrue debt? 
Let's delve into the dataset to uncover whether long-term debt is indeed the most common category for countries to owe their debts. */

SELECT indicator_code, COUNT(indicator_code) AS Indicator_Count
FROM main
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC
LIMIT 20;

/* Other viable debt issues and conclusion - 
Our examination of global debt levels has uncovered key insights and summary statistics, shedding light on the economic challenges faced by various countries. 
As we shift our focus from debt indicators to the total amount of debt owed, we aim to uncover another layer of economic issues that these countries may be experiencing. 
By identifying the maximum debt amount held by each country, we can gain a deeper understanding of the diverse economic challenges across the globe.

We've navigated through the complexities of international debt, extracting valuable insights and validating our findings to ensure the accuracy of our analyses. */

SELECT country_name, MAX(debt) AS Maximum_Debt
FROM main
GROUP BY country_name
ORDER BY maximum_debt DESC
LIMIT 10;

