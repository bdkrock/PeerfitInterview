# Reservation Data Analysis Project Questionnaire

Below are three sections related to the project.
1. Project Data Points, which contains the project questionnaire and my answers
2. Project Discussion, which contains the project discussion topics and my responses
3. My Questions/Observations, which contains my notes, questions, and other observations relating to the project and questionnaire solutions

# Project Data Points

#### 1. Across all reservation partners for January & February, how many completed reservations occurred?
  - NOTE: refer to "My Questions/Observations" note 1
  - Across both partners, there were 135 total completed reservations in January and February.
  - Refer to `Data Solution 1.sql` file for associated query

#### 2. Which studio has the highest rate of reservation abandonment (did not cancel but did not check-in)?
  - NOTE: refer to "My Questions/Observations" notes 1 and 2
  - NOTE: this calculation includes 1 observation from dataset `mindbody_reservations` for which the `checked_in_at` is in March. It was included since the question did not specify a date range
  - Across both partners, the highest rate of reservation abandonment per studio was `studio_key` "crossfit-control-jacksonville-beach" with a total of 4 abandoned reservations.
  - Refer to `Data Solution 2.sql` file for associated query

#### 3. Which fitness area (i.e., tag) has the highest number of completed reservations for February?
  - Across both partners in February, the fitness area with the highest number of completed reservations was `class_tag` "yoga" with a total of 12 completed reservations.
  - Refer to `Data Solution 3.sql` file for associated query

#### 4. How many members completed at least 1 reservation and had no more than 1 cancelled reservation in January?
  - NOTE: refer to "My Questions/Observations" notes 2 and 3
  - In January, there were 28 members across both platforms who completed at least 1 reservation and had no more than 1 cancelled reservation
  - Refer to `Data Solution 4.sql` file for associated query

#### 5. At what time of day do most users book classes? Attend classes? (Morning = 7-11 AM, Afternoon = 12-4 PM, Evening = 5-10 PM)
  - NOTE: There are two alternative solutions to this question based on the wording provided. 
  - `Data Solution 5a.sql` contains the answers to both "book classes" and "attend classes" portions of the question. In this solution in which "book classes" is interpreted to mean the reservation time of the classes; it is applicable to both datasets. 
    - According to times of reservation for 200 reservations, most users book classes in the morning (133 classes), as well as attend classes (122 classes).
  - `Data Solution 5b.sql` contains a solution for the "book classes" part of the question in which "book classes" is interpreted to refer to the `reserved_at` field of the `mindbody_reservations` table, which shows a datetime for when a member actually booked the class (not the time of the class they are booking). There is no data in the `clubready_observations` table corresponding to the time at which members booked a class.
    - According to the time at which reservations were made in the `mindbody_reservations` dataset, most classes were booked by users in the evening (53 bookings).

#### 6. How many confirmed completed reservations did the member (ID) with the most reserved classes in February have?
  - NOTE: refer to "My Questions/Observations" notes 2 and 3
  - Across both partners for February, there is a three-way tie for members with most reserved classes: 6-mb, 4-mb, and 12-mb (all with 5 reserved classes in February). Member 6-mb attended all 5 classes, while the other two members attended 4 of their 5 reserved classes.
  - Refer to `Data Solution 6.sql` file for associated query

#### 7. Write a query that unions the `mindbody_reservations` table and `clubready_reservations` table as cleanly as possible.
  - Refer to `Data Solution 7.sql` file for associated query
  - As shown in the associated UNION query, I identified 7 fields that were somewhat uniform across both tables. One field included that was not uniform was `canceled` from `clubready_reservations`, which contained BOOLEAN `t` or `f` to indicate whether a reservation was canceled in advance for that partner. The corresponding field in `mindbody_reservations` is `canceled_at`, which contains a datetime recording when a reservation was canceled in advance for that partner. In my UNION query, I converted the latter to BOOLEAN `t` or `f` to match the format in the former; I opted to coerce datetime data to boolean, since there was no data in `clubready_reservations` to indicate the datetime at which cancellations were made. Finally, I added a `partner` column to indicate the table from which each record originated.



# Project Discussion

### 1. What opportunities do you see to improve data storage and standardization for these datasets?
There is quite a bit that can be improved for these datasets in terms of data storage/design and standardization. I'll try to keep my observations at a high level for the sake of sticking to the time limit. 

Normalization would greatly improve the storage requirements, database speed, and usability of these datasets. For the purposes of this discussion question, I'll work backwards (e.g. from what was provided) instead of from the ground up (e.g. how I would design it from scratch). 

First, I'll focus on data storage and performance. I noticed that all of the fields except for `id` are `DEFAULT NULL`, which can slow down database and query performance when the model is scaled. Likewise, the data types used are inconsistent across the two datasets. For instance, `studio_key` is `varchar(40)` in `clubready_observations` but `varchar(100)` in `mindbody_reservations`; these should be standardized and the data type should be set to the lowest possible variable length. There are other possibilities for data type changes, depending on the future state model of the database.

Next, actual database schema is inefficient in terms of design. These datasets contain many repeating groups, redundant data, and fields that are not dependent on the primary keys. A unique identifier variable needs to be created to identify the partners. Additionally, the `id` field exists in both datasets and contains non-unique values between the two and needs to be distinguished; these should be moved to a new table containing two primary keys (the newly-distinguished `id` field with the reservation id, and the newly-created `partner_id`). Similarly, `member_id` is not unique between tables, and needs to be uniquely identified at a higher level to correspond with partners; a new `member` table should be created to store this data. `member_id` should be included in the new `reservation_id` table discussed before.

Then, separate tables should be used to eliminate repeating data/groups within reservation data. This could be accomplished by having one table containing unique for each of the following: `studio_key` data (including any additional information associated with that studio), and class information (including `class_tag`, `instructor_full_name`, and `level`). 

Finally, the column names and formats are not consistent and need to be standardized. This is primarily true of the datetime fields.

I could go into more detail, but I need to be wary of time.

### 2. What forecasting opportunities do you see with a dataset like this and why?
Option 1: compare the relationship between canceled/abandoned reservations across multiple potential drivers contained in these datasets, such as studio, class tag, level of class, and time of class. Are any of these variables more likely to result in a cancelled/abandoned reservation? Can they be benchmarked and compared across historical data to predict future behavior?

Option 2: compare the relationship between individual members and their likelihood to cancel/abandon a reservation. Are their results comparable to overall results? Are any variables driving their likelihood to cancel/abandon (e.g. time of class, level of difficulty, etc.)? Do these variable-based patterns correlate to established benchmarks?

Option 3: compare the usage/cancellation data above to member subscription/benefit data to observe patterns such as "are members who cancel frequently more likely to quit the program or rescind the benefit?"

Option 4: given the revenue model associated with reservation completion and/or cancellation/abandonment, utilize the models built above to forecast future income and cash flows.

Of course all of this could be fed into machine learning models to enhance predictive ability and pinpoint further topics for exploration.

### 3. What other data would you propose we gather to make reporting/forecasting more robust and why?
This is a broad question with far-reaching implications, but I'll try to keep it short. 

Geographic data for both studio/class locations and member workplace/home could be useful to determine whether commute time influences likelihood to keep/abandon a reservation.

Further member demographic data could be utilized to add more variables and further increase the value, depth, and breadth of predictive models. 

Review data around individual studios, their class offerings, and their instructors could also shed light on historical trends in cancelled/abandoned reservations and help model future behavior. 

Obviously, financial data regarding the income and income lost is important, and is necessary if financial models are to be built.


# My Questions/Observations

#### 1. For Question 1 and all other applicable questions, I defined "completed reservations" as those for which a reservation was made AND a check-in/sign-in datetime exists. This is based on my intuition of what it means to "complete" a reservation, since this particular term was not defined elsewhere.

#### 2. In the `clubready_reservations` dataset, there are cases where the reservation has a boolean value of `TRUE` in the `canceled` column AND has a `datetime` value in the `signed_in_at` column
  - I interpreted these instances as "completed reservations" despite the `canceled` value of `TRUE`, since there was a `NOT NULL` `signed_in_at` value. 
    - For Question 4, the implication on my solution is two-fold:
      - I include these as completed for determining which members completed at least 1 reservation in January, BUT
      - I ALSO consider these reservations to be canceled for the sake of calculating members who had no more than 1 cancellation


#### 3. I was unsure whether the `member_id` field across both tables was unique for that partner, or for Peerfit. For my solution, I decided that the `member_id` was unique at the PARTNER level; i.e. `member_id` 1 from `clubready_reservations` is NOT the same person as `member_id` 1 from `mindbody_reservations`. Note that if this interpretation is incorrect, then any solutions involving distinct member id's will also be incorrect.
  - The effect of this interpretation on Question 4 is material, since members who use both partner platforms would have been excluded from the count if they had been recognized as identical
