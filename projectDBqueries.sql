--1]  List the bus numbers of the top 5 buses that travel to Dallas the most.
SELECT 
    B.BNUMBER AS BUS_NUMBER,
    COUNT(*) AS NUM_TRIPS
FROM 
    S24_S003_T6_CITY C,S24_S003_T6_ROUTE R, S24_S003_T6_TICKET T, S24_S003_T6_BUS B  
WHERE 
    C.CID = R.DEST_CID
AND
    R.RID = T.RID
AND  
    T.BNUMBER = B.BNUMBER
AND 
    C.NAME LIKE 'Dallas%'
GROUP BY
    B.BNUMBER
ORDER BY
    NUM_TRIPS DESC
FETCH FIRST 5 ROWS ONLY;


--OUTPUT

-- Bus_Number             NUM_TRIPS
-- -------------------- ----------
-- EOF640                       41
-- IPUV4E                        8
-- 250FSA                        6
-- V5LCE6                        2
-- VCKLIB                        2

-- 5 row selected


--2] Total number of passengers travelling to a particular city in a particular month and its grand total
SELECT 
    C.NAME AS CITY_NAME,
    TO_CHAR(T.TDATE, 'Month') AS TRAVEL_MONTH,
    COUNT( P.PID) AS TOTAL_PASSENGERS
FROM 
    S24_S003_T6_TICKET T,S24_S003_T6_PASSENGER P,S24_S003_T6_ROUTE R,S24_S003_T6_CITY C 
WHERE 
    T.PID = P.PID
AND 
    T.RID = R.RID
AND 
    C.CID = R.DEST_CID
GROUP BY 
    ROLLUP(C.NAME,TO_CHAR(T.TDATE, 'Month'))
ORDER BY 
     City_Name,Travel_Month;


--OUTPUT

-- CITY_NAME            TRAVEL_MONTH                         TOTAL_PASSENGERS
-- -------------------- ------------------------------------ ----------------
-- Austin               April                                               2
-- Austin               August                                             28
-- Austin               December                                            3
-- Austin               February                                            1
-- Austin               January                                             1
-- Austin               March                                               4
-- Austin               November                                            2
-- Austin               October                                             1
-- Austin               September                                           2
-- Austin                                                                  44
-- Dallas               April                                               1
-- Dallas               December                                            1
-- Dallas               February                                            5
-- Dallas               January                                             7
-- Dallas               July                                                1
-- Dallas               June                                                4
-- Dallas               March                                               3
-- Dallas               November                                            2
-- Dallas               October                                            42
-- Dallas               September                                           2
-- Dallas                                                                  68
-- Houston              April                                               1
-- Houston              August                                              1
-- Houston              December                                            1
-- Houston              February                                            2
-- Houston              January                                             1
-- Houston              July                                                4
-- Houston              June                                                2
-- Houston              March                                              40
-- Houston              October                                             2
-- Houston                                                                 54
-- San Antonio          August                                              1
-- San Antonio          December                                            1
-- San Antonio          February                                            1
-- San Antonio          January                                             2
-- San Antonio          July                                                5
-- San Antonio          June                                                1
-- San Antonio          March                                               1
-- San Antonio          May                                                41
-- San Antonio          October                                             3
-- San Antonio          September                                           1
-- San Antonio                                                             57
--                                                                        223
-- 43 rows selected.



--3]List the details of the drivers who are assigned to all the buses.
SELECT 
    d.*
FROM
    S24_S003_T6_DRIVER d
WHERE 
    NOT EXISTS ( 
    (
        SELECT BNumber 
        FROM S24_S003_T6_BUS 
    )
    MINUS
    (
        SELECT Bnumber 
        FROM S24_S003_T6_BUS_ASSIGNED ba
        WHERE ba.DID = d.DID 
    )
);


--OUTPUT

-- DID                  LICENSE              DOB               NAME                  EMAIL
-- ------------------   -------------------  ----------------  --------------------  ------------------------
-- 17                   9785501445           3/2/1975          Maria Vega            salastodd@example.net

-- 23                   4266529010           4/12/1966         Laura Rangel          kgarza@example.org

-- 38                   9760559992           9/19/1987         Francisco English     katiestewart@example.net

-- 45                   5652831077           1/4/1989          Sheila Walker         harold63@example.net

-- 4 row selected



--4]List the total amount spent by passengers travelling to each city, and its grand totals.
SELECT 
    T.PID, C.CID, SUM(T.PRICE) as TOTAL_AMOUNT
FROM 
    S24_S003_T6_TICKET T, S24_S003_T6_ROUTE R, S24_S003_T6_CITY C
WHERE 
    T.RID = R.RID 
AND 
    (R.SOURCE_CID = C.CID OR R.DEST_CID = C.CID)
GROUP BY 
    CUBE(T.PID, C.CID);


--OUTPUT

-- PID                  CID                  TOTAL_AMOUNT
-- -------------------- -------------------- ------------
--                                                9633.64
--                      201                       3038.93
--                      202                       2794.91
--                      203                        2158.3
--                      204                        1641.5
-- 1                                                186.3
-- 1                    201                         69.95
-- 1                    202                          33.4
-- 1                    203                         59.75
-- 1                    204                          23.2
-- 2                                               236.18
-- 2                    201                         94.89
-- 2                    202                         94.89
-- 2                    203                          23.2
-- 2                    204                          23.2
-- 3                                               274.84
-- 3                    201                         82.73
-- 3                    202                        114.22
-- 3                    203                         54.69
-- 3                    204                          23.2
-- 4                                               220.98
-- 4                    201                         87.29
-- 4                    202                          33.4
-- 4                    203                          23.2
-- 4                    204                         77.09
-- 5                                               174.76
-- 5                    201                         64.18
-- 5                    202                         64.18
-- 5                    203                          23.2
-- 5                    204                          23.2
-- 6                                               383.68
-- 6                    201                        129.73
-- 6                    202                         72.31
-- 6                    203                        139.93
-- 6                    204                         41.71
-- 7                                               270.32
-- 7                    201                        101.76
-- 7                    202                          43.6
-- 7                    203                          33.4
-- 7                    204                         91.56
-- 8                                               200.54
-- 8                    201                         77.07
-- 8                    202                          33.4
-- 8                    203                         66.87
-- 8                    204                          23.2
-- 9                                               231.92
-- 9                    201                          33.4
-- 9                    202                         92.76
-- 9                    203                         82.56
-- 9                    204                          23.2
-- 10                                               190.9
-- 10                   201                          33.4
-- 10                   202                         72.25
-- 10                   203                          33.4
-- 10                   204                         51.85
-- 11                                              182.64
-- 11                   201                          33.4
-- 11                   202                         68.12
-- 11                   203                          33.4
-- 11                   204                         47.72
-- 12                                              226.64
-- 12                   201                         74.45
-- 12                   202                          33.4
-- 12                   203                         38.87
-- 12                   204                         79.92
-- 13                                              193.14
-- 13                   201                          33.4
-- 13                   202                         73.37
-- 13                   203                         63.17
-- 13                   204                          23.2
-- 14                                              146.54
-- 14                   201                          33.4
-- 14                   202                          33.4
-- 14                   203                         39.87
-- 14                   204                         39.87
-- 15                                              221.78
-- 15                   201                         56.05
-- 15                   202                         65.04
-- 15                   203                         56.05
-- 15                   204                         44.64
-- 16                                              223.92
-- 16                   201                         78.56
-- 16                   202                          43.6
-- 16                   203                          33.4
-- 16                   204                         68.36
-- 17                                              243.56
-- 17                   201                         62.63
-- 17                   202                         69.35
-- 17                   203                          33.4
-- 17                   204                         78.18
-- 18                                              173.52
-- 18                   201                         63.56
-- 18                   202                          33.4
-- 18                   203                          23.2
-- 18                   204                         53.36
-- 19                                              255.26
-- 19                   201                         48.91
-- 19                   202                         88.92
-- 19                   203                          43.6
-- 19                   204                         73.83
-- 20                                              157.84
-- 20                   201                          33.4
-- 20                   202                         55.72
-- 20                   203                         45.52
-- 20                   204                          23.2
-- 21                                               113.2
-- 21                   201                          33.4
-- 21                   202                          33.4
-- 21                   203                          23.2
-- 21                   204                          23.2
-- 22                                              240.06
-- 22                   201                         57.69
-- 22                   202                          43.6
-- 22                   203                         62.34
-- 22                   204                         76.43
-- 23                                              367.04
-- 23                   201                        139.92
-- 23                   202                          53.8
-- 23                   203                        112.03
-- 23                   204                         61.29
-- 24                                               358.9
-- 24                   201                         95.83
-- 24                   202                         70.31
-- 24                   203                         83.62
-- 24                   204                        109.14
-- 25                                               677.5
-- 25                   201                        237.08
-- 25                   202                        141.28
-- 25                   203                        254.43
-- 25                   204                         44.71
-- 26                                              360.08
-- 26                   201                        118.93
-- 26                   202                        109.92
-- 26                   203                         61.11
-- 26                   204                         70.12
-- 27                                              255.32
-- 27                   201                        117.46
-- 27                   202                          43.6
-- 27                   203                         94.26
-- 28                                              117.18
-- 28                   201                          33.4
-- 28                   202                          43.6
-- 28                   203                         25.19
-- 28                   204                         14.99
-- 29                                              135.24
-- 29                   201                         67.62
-- 29                   202                         67.62
-- 30                                              102.68
-- 30                   201                          33.4
-- 30                   202                         51.34
-- 30                   203                         17.94
-- 31                                              126.04
-- 31                   201                         52.82
-- 31                   202                          43.6
-- 31                   203                         29.62
-- 32                                              189.08
-- 32                   201                            52
-- 32                   202                          62.2
-- 32                   203                         42.54
-- 32                   204                         32.34
-- 33                                               134.1
-- 33                   201                          33.4
-- 33                   202                          43.6
-- 33                   203                         33.65
-- 33                   204                         23.45
-- 34                                              132.02
-- 34                   201                         66.01
-- 34                   202                          33.4
-- 34                   203                         32.61
-- 35                                               144.5
-- 35                   201                          33.4
-- 35                   202                          43.6
-- 35                   203                         38.85
-- 35                   204                         28.65
-- 36                                               178.5
-- 36                   201                         79.05
-- 36                   202                          43.6
-- 36                   203                         55.85
-- 37                                              116.22
-- 37                   201                         47.91
-- 37                   202                          43.6
-- 37                   203                         24.71
-- 38                                                 132
-- 38                   201                            66
-- 38                   202                          33.4
-- 38                   204                          32.6
-- 39                                              155.52
-- 39                   201                          33.4
-- 39                   202                         77.76
-- 39                   203                         44.36
-- 40                                              146.94
-- 40                   201                          33.4
-- 40                   202                         73.47
-- 40                   203                         40.07
-- 41                                              112.16
-- 41                   201                         35.15
-- 41                   202                         56.08
-- 41                   204                         20.93
-- 42                                              107.36
-- 42                   201                         43.48
-- 42                   202                         53.68
-- 42                   203                          10.2
-- 43                                                63.1
-- 43                   201                         21.35
-- 43                   202                         31.55
-- 43                   203                          10.2
-- 44                                              259.48
-- 44                   201                         88.83
-- 44                   202                        129.74
-- 44                   203                         40.91
-- 45                                               93.96
-- 45                   202                         46.98
-- 45                   203                          10.2
-- 45                   204                         36.78
-- 46                                               58.26
-- 46                   201                         18.93
-- 46                   202                          10.2
-- 46                   203                         29.13
-- 47                                               86.92
-- 47                   202                         43.46
-- 47                   204                         43.46
-- 48                                               54.78
-- 48                   201                         17.19
-- 48                   202                         27.39
-- 48                   203                          10.2
-- 49                                              113.52
-- 49                   201                         46.56
-- 49                   202                          10.2
-- 49                   203                          10.2
-- 49                   204                         46.56
-- 50                                              106.72
-- 50                   201                         43.16
-- 50                   202                          10.2
-- 50                   203                          10.2
-- 50                   204                         43.16

-- 235 rows selected.
    

--5]Sales for each bus going on each route along with its grand totals
SELECT 
    B.BNUMBER, T.RID, SUM(T.PRICE) AS TOTAL_PRICE
FROM 
    S24_S003_T6_BUS B, S24_S003_T6_TICKET T
WHERE 
    B.BNUMBER = T.BNUMBER
GROUP BY 
    ROLLUP(B.BNUMBER, T.RID);


--OUTPUT

-- BNUMBER              RID                  TOTAL_PRICE
-- -------------------- -------------------- -----------
-- 0DOWEA               403                        18.37
-- 0DOWEA                                          18.37
-- 0SWJIV               407                        19.51
-- 0SWJIV               410                        43.16
-- 0SWJIV                                          62.67
-- 1JC83Q               408                        12.12
-- 1JC83Q                                          12.12
-- 250FSA               402                        83.53
-- 250FSA               404                        49.92
-- 250FSA               407                       147.76
-- 250FSA               410                        92.84
-- 250FSA                                         374.05
-- 2CCPO2               408                        17.94
-- 2CCPO2                                          17.94
-- 2KAI6Q               412                        40.02
-- 2KAI6Q                                          40.02
-- 3IEU1P               406                        28.65
-- 3IEU1P                                          28.65
-- 47RYVZ               404                        38.91
-- 47RYVZ                                          38.91
-- 5JNG96               409                        28.65
-- 5JNG96                                          28.65
-- 5O7VSL               402                        36.55
-- 5O7VSL                                          36.55
-- 6R4PHA               412                        23.45
-- 6R4PHA                                          23.45
-- 97PSXB               412                        16.67
-- 97PSXB                                          16.67
-- 9V0BW1               405                       448.07
-- 9V0BW1                                         448.07
-- BWXGRA               401                        38.61
-- BWXGRA                                          38.61
-- C11OW0               405                        17.51
-- C11OW0               408                        34.16
-- C11OW0                                          51.67
-- C27R42               410                        46.56
-- C27R42                                          46.56
-- CJOQCC               410                        30.16
-- CJOQCC                                          30.16
-- EOF640               404                       962.22
-- EOF640                                         962.22
-- EZBAP6               405                        36.56
-- EZBAP6                                          36.56
-- FOVFCQ               405                        31.49
-- FOVFCQ                                          31.49
-- HYPR4R               401                        43.48
-- HYPR4R                                          43.48
-- IMAOG7               403                        26.83
-- IMAOG7                                          26.83
-- IPUV4E               401                         18.6
-- IPUV4E               402                        22.65
-- IPUV4E               403                        78.47
-- IPUV4E               404                       130.96
-- IPUV4E               407                        59.72
-- IPUV4E               410                        94.57
-- IPUV4E                                         404.97
-- J95SYP               407                        43.76
-- J95SYP                                          43.76
-- JVOD6S               410                        45.16
-- JVOD6S                                          45.16
-- L0POOG               401                        21.35
-- L0POOG                                          21.35
-- L6GLX2               402                        45.65
-- L6GLX2                                          45.65
-- MSSETO               409                       635.54
-- MSSETO                                         635.54
-- N1JVHP               405                        49.16
-- N1JVHP                                          49.16
-- NF9A2J               406                        18.51
-- NF9A2J               409                        14.99
-- NF9A2J                                           33.5
-- NJLAI1               406                        20.93
-- NJLAI1                                          20.93
-- OYXJ3S               404                        17.19
-- OYXJ3S                                          17.19
-- OZE7T5               403                        38.09
-- OZE7T5                                          38.09
-- P123L7               409                        21.51
-- P123L7               412                        28.94
-- P123L7                                          50.45
-- PJI6KW               409                        15.67
-- PJI6KW                                          15.67
-- QLCHJX               402                        48.41
-- QLCHJX                                          48.41
-- QVWPR5               408                        20.51
-- QVWPR5               411                        25.75
-- QVWPR5                                          46.26
-- RF3S9K               401                          408
-- RF3S9K                                            408
-- SMSYBT               403                        15.51
-- SMSYBT               406                        21.44
-- SMSYBT                                          36.95
-- TQK99R               401                        30.78
-- TQK99R                                          30.78
-- UMFTHD               406                        43.46
-- UMFTHD                                          43.46
-- UPFHN1               411                        24.52
-- UPFHN1                                          24.52
-- V5LCE6               402                        50.92
-- V5LCE6               404                        65.93
-- V5LCE6                                         116.85
-- VCKLIB               404                        16.51
-- VCKLIB               407                        18.93
-- VCKLIB                                          35.44
-- WO11CP               403                        31.18
-- WO11CP                                          31.18
-- WPXGVM               407                        43.67
-- WPXGVM                                          43.67
-- WZVHUZ               402                        14.51
-- WZVHUZ                                          14.51
-- YY1SDK               411                        36.78
-- YY1SDK                                          36.78
-- Z847YG               408                        29.77
-- Z847YG                                          29.77
-- ZDLL4C               411                        35.12
-- ZDLL4C                                          35.12
--                                               4816.82
-- 117 rows selected.

    
--6] The city which has the most number of tickets booked.
SELECT 
    DISTINCT C.NAME, COUNT(T.TID) OVER (PARTITION BY C.CID) AS NO_OF_TICKETS_BOOKED
FROM 
    S24_S003_T6_TICKET T, S24_S003_T6_ROUTE R, S24_S003_T6_CITY C
WHERE 
    R.RID = T.RID 
AND 
    (R.SOURCE_CID = C.CID OR R.DEST_CID = C.CID)
ORDER BY 
    NO_OF_TICKETS_BOOKED DESC
FETCH FIRST 1 ROWS ONLY;

--OUTPUT

-- NAME                 NO_OF_TICKETS_BOOKED
-- -------------------- --------------------
-- Houston                               154

-- 1 row selected


--7] The age group that books the most tickets for prices less than 50$.
WITH Passenger_Age AS (
    SELECT 
        CASE  
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 0 AND 25 THEN '0-25'
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 26 AND 60 THEN '26-60'
            ELSE '61+'
        END AS AGE_GROUP,
        COUNT(*) AS TICKETS_BOOKED
    FROM 
        S24_S003_T6_PASSENGER P
        JOIN S24_S003_T6_TICKET T ON P.PID = T.PID
    WHERE
	T.PRICE < 50
    GROUP BY 
        CASE 
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 0 AND 25 THEN '0-25'
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 26 AND 60 THEN '26-60'
            ELSE '61+'
        END  
)
SELECT 
    Age_Group,
    Tickets_Booked
FROM 
    Passenger_Age
ORDER BY 
    Tickets_Booked DESC
FETCH FIRST 1 ROWS ONLY;


--OUTPUT

-- AGE_G TICKETS_BOOKED
-- ----- --------------
-- 26-60             96

-- 1 row selected

    
--8] Buses which have less than 5 bookings for a trip.
SELECT 
    T.BNUMBER AS BUS_NUMBER,
    COUNT(*) AS NUM_BOOKINGS
FROM 
    S24_S003_T6_TICKET T
GROUP BY 
    T.BNUMBER
HAVING 
    COUNT(*) < 5;


--OUTPUT

-- BUS_NUMBER           NUM_BOOKINGS
-- -------------------- ------------
-- FOVFCQ                          1
-- C27R42                          1
-- 2KAI6Q                          1
-- C11OW0                          2
-- P123L7                          2
-- L6GLX2                          1
-- OYXJ3S                          1
-- 3IEU1P                          1
-- J95SYP                          1
-- YY1SDK                          1
-- WZVHUZ                          1
-- V5LCE6                          3
-- CJOQCC                          1
-- UPFHN1                          1
-- SMSYBT                          2
-- IMAOG7                          1
-- 2CCPO2                          1
-- WO11CP                          1
-- 47RYVZ                          1
-- NF9A2J                          2
-- QVWPR5                          2
-- 0DOWEA                          1
-- WPXGVM                          1
-- BWXGRA                          1
-- L0POOG                          1
-- N1JVHP                          1
-- 5O7VSL                          1
-- VCKLIB                          2
-- Z847YG                          1
-- PJI6KW                          1
-- 97PSXB                          1
-- UMFTHD                          1
-- 1JC83Q                          1
-- 0SWJIV                          2
-- 5JNG96                          1
-- 6R4PHA                          1
-- HYPR4R                          1
-- ZDLL4C                          1
-- JVOD6S                          1
-- NJLAI1                          1
-- TQK99R                          1
-- QLCHJX                          1
-- OZE7T5                          1
-- EZBAP6                          1

-- 44 rows selected.


--9] The age group which visits a certain city the most. 
WITH Max_Visits AS (
    SELECT 
        C.NAME AS CITY,
        CASE  
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 0 AND 25 THEN '0-25'
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 26 AND 60 THEN '26-60'
            ELSE '61+'
        END AS AGE_GROUP,
        COUNT(*) AS VISITS
    FROM 
        S24_S003_T6_PASSENGER P
        JOIN S24_S003_T6_TICKET T ON P.PID = T.PID
        JOIN S24_S003_T6_ROUTE R ON T.RID = R.RID
        JOIN S24_S003_T6_CITY C ON R.DEST_CID = C.CID
    GROUP BY 
        C.NAME, 
        CASE 
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 0 AND 25 THEN '0-25'
            WHEN FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE(P.DOB, 'MM DD YY')) / 12) BETWEEN 26 AND 60 THEN '26-60'
            ELSE '61+'
        END
)
SELECT 
    CITY,
    AGE_GROUP,
    VISITS
FROM 
    MAX_VISITS M
WHERE 
    (CITY, VISITS) IN (
        SELECT 
            CITY,
            MAX(VISITS) AS MAX_VISITS
        FROM 
            MAX_VISITS
        GROUP BY 
            CITY
    );


--OUTPUT

-- CITY                 AGE_G     VISITS
-- -------------------- ----- ----------
-- San Antonio          61+           28
-- Austin               26-60         21
-- Houston              61+           24
-- Dallas               26-60         32

-- 4 rows selected.


--10] Maximum number of cities a driver has driven to.
SELECT 
    D.DID AS DRIVER_ID,
    COUNT(DISTINCT C.CID) AS MAX_CITIES_DRIVEN
FROM 
    S24_S003_T6_DRIVER D
    JOIN S24_S003_T6_BUS_ASSIGNED BA ON D.DID = BA.DID
    JOIN S24_S003_T6_BUS B ON BA.BNUMBER = B.BNUMBER
    JOIN S24_S003_T6_TICKET T ON B.BNUMBER = T.BNUMBER
    JOIN S24_S003_T6_ROUTE R ON T.RID = R.RID
    JOIN S24_S003_T6_CITY C ON R.SOURCE_CID = C.CID OR R.DEST_CID = C.CID
GROUP BY 
    D.DID
ORDER BY 
    COUNT(DISTINCT C.CID) DESC;


--OUTPUT

-- DRIVER_ID            MAX_CITIES_DRIVEN
-- -------------------- -----------------
-- 45                                   4
-- 17                                   4
-- 38                                   4
-- 16                                   4
-- 22                                   4
-- 23                                   4
-- 40                                   3
-- 11                                   3
-- 54                                   3
-- 51                                   3
-- 39                                   3
-- 37                                   3
-- 30                                   2
-- 34                                   2
-- 32                                   2
-- 12                                   2
-- 36                                   2
-- 52                                   2
-- 24                                   2
-- 41                                   2
-- 15                                   2
-- 48                                   2
-- 25                                   2
-- 47                                   2
-- 42                                   2
-- 18                                   2
-- 28                                   2
-- 29                                   2
-- 53                                   2
-- 10                                   2
-- 21                                   2
-- 19                                   2
-- 26                                   2
-- 49                                   2
-- 35                                   2
-- 46                                   2
-- 14                                   2
-- 33                                   2
-- 27                                   2
-- 44                                   2
-- 50                                   2
-- 13                                   2
-- 31                                   2
-- 20                                   2
-- 43                                   2
-- 55                                   2

--46 rows selected.