-- MAKE SOME PLOTS FOR PRESENTING IN TABLEAU 
select distinct "STATUS" from sales_data_sample

select distinct "PRODUCTLINE" from sales_data_sample

select distinct "COUNTRY" from sales_data_sample

select distinct "DEALSIZE" from sales_data_sample

select distinct "TERRITORY" from sales_data_sample

--GROUPING SALES BY PRODUCT LINE 
select "PRODUCTLINE", SUM("SALES") as REVENUE
from sales_data_sample sds 
group by 1 
order by REVENUE desc

select "YEAR_ID", SUM("SALES") as REVENUE
from sales_data_sample sds 
group by 1 
order by REVENUE desc

--WHY THE SALES IN 2005 IS THE LOWEST (1.791.486)? HERE WE CAN SEE THE ANSWER, IT MAYBE BECAUSE THE PRODUCTION ONLY HAPPEN FROM MONTH 1-5 
--OTHER YEAR PRODUCTION HAPPEN FROM MONTH 1-12
select distinct ("MONTH_ID") as month, "PRODUCTLINE"
from sales_data_sample sds 
where "YEAR_ID" = 2005
order by 1 asc

select "DEALSIZE", SUM("SALES") as REVENUE
from sales_data_sample sds 
group by 1 
order by REVENUE desc

--WHAT WAS THE BEST MONTH FOR SALES IN A SPECIFIC YEAR? 
--HOW MUCH WAS EARNED THAT MONTH ? 
select distinct ("MONTH_ID") as MONTH, SUM("SALES") as REVENUE,
COUNT("ORDERNUMBER") as TOTAL_NUMBER_ORDER, "PRODUCTLINE"
from sales_data_sample sds  
where "YEAR_ID" = 2004 and "MONTH_ID" = 11
group by 1,4
order by 2 desc, 1 asc

--WHO IS OUR BEST CUSTOMER (THIS COULD BE BEST ANSWERED WITH RFM ANALYSIS)
-- R = RECENCY 
-- F = FREQUENCY 
-- M = MONETARY 
drop table if exists RFM_TEMP;

create temp table RFM_TEMP AS
with RFM AS
(select 
"CUSTOMERNAME",
SUM("SALES") as TOTAL_MONETARY,
AVG("SALES") as AVG_MONETARY,
COUNT("ORDERNUMBER") as FREQUENCY,
MAX("ORDERDATE") as LAST_ORDER_DATE,
(select MAX("ORDERDATE") from sales_data_sample sds) as MAX_ORDER_DATE,
(select MAX("ORDERDATE"::DATE) from sales_data_sample sds) - MAX("ORDERDATE"::DATE) as RECENCY
from sales_data_sample sds 
group by 1
order by RECENCY DESC
),
RFM_CALC as
(
select *,
NTILE(4) OVER(order by RECENCY) as RFM_RECENCY,
NTILE(4) OVER(order by FREQUENCY) as RFM_FREQUENCY,
NTILE(4) OVER(order by TOTAL_MONETARY) as RFM_MONETARY
from RFM
)
select *, RFM_RECENCY + RFM_FREQUENCY + RFM_MONETARY as RFM_TOTAL,
cast(RFM_RECENCY as VARCHAR) || cast(RFM_FREQUENCY as VARCHAR) || cast(RFM_MONETARY as VARCHAR) as RFM_CELL 
from RFM_CALC


select * from RFM_TEMP;
----
--R tinggi (4) = new customer

--F tinggi (4) = most buy

--M tinggi (4) = most spend
select
"CUSTOMERNAME",rfm_recency, rfm_frequency, rfm_monetary,
case
	WHEN rfm_cell IN ('111','112','113','114','121','122','123','131','132','141') THEN 'CHAMPIONS'
    WHEN rfm_cell IN ('133','134','142','143','144','232','233','234','242','243','244') THEN 'POTENTIAL_LOYALIST'
    WHEN rfm_cell IN ('311','312','313','321','322','331') THEN 'NEW_CUSTOMERS'
    WHEN rfm_cell IN ('332','333','334','341','342','343') THEN 'NEED_ATTENTION'
    WHEN rfm_cell IN ('411','412','413','421','422','423','431','432','441','442','443') THEN 'AT_RISK'
    WHEN rfm_cell IN ('444') THEN 'LOST_CUSTOMERS'
    ELSE 'OTHER'
    END AS rfm_segment
from RFM_TEMP

---HERE WE'RE USING 64 COMBINATIONS / 8 SEGMENTATIONS TO KNOW ALL OF THE VALUE FOR EACH CUSTOMER
--MOSTLY COMPANY USING STANDARD 5-8 SEGMENTATIONS TO MAKE A DECISION

select "CUSTOMERNAME", "rfm_cell",
CASE
    -- 1. CHAMPIONS (R=1, F>=3, M>=3)
    WHEN rfm_cell IN ('131','132','133','134','141','142','143','144') THEN 'CHAMPIONS'
    -- 2. LOYAL (R=1, F>=3, M<=2 OR F=2, M>=3)
    WHEN rfm_cell IN ('121','122','123','124','111','112','113','114') THEN 'LOYAL'
    -- 3. POTENTIAL LOYALISTS (R=1, F=2, M=2–3)
    WHEN rfm_cell IN ('231','232','233','234') THEN 'POTENTIAL_LOYALISTS'
    -- 4. PROMISING (R=2)
    WHEN rfm_cell IN ('211','212','213','214','221','222','223','224') THEN 'PROMISING'
    -- 5. NEED ATTENTION (R=3, F<=2)
    WHEN rfm_cell IN ('311','312','313','314','321','322','323','324') THEN 'NEED_ATTENTION'
    -- 6. AT RISK (R=3, F>=3)
    WHEN rfm_cell IN ('331','332','333','334','341','342','343','344') THEN 'AT_RISK'
    -- 7. HIBERNATING (R=4, F<=2)
    WHEN rfm_cell IN ('411','412','413','414','421','422','423','424') THEN 'HIBERNATING'
    -- 8. LOST (R=4, F>=3)
    WHEN rfm_cell IN ('431','432','433','434','441','442','443','444') THEN 'LOST'
END AS rfm_segment_2,
---SUBQUERY TO SEE LOYAL CUSTOMER
(select case WHEN rfm_cell IN ('121','122','123','124','111','112','113','114') THEN 'LOYAL' end as rfm_segment_2) as LOYAL
from RFM_TEMP

---WE WANT TO KNOW THE TOTAL(COUNT) OF THE LOYAL CUSTOMER 
SELECT 
    COUNT(*) AS LOYAL_COUNT
FROM RFM_TEMP
WHERE rfm_cell IN ('121','122','123','124','111','112','113','114');


