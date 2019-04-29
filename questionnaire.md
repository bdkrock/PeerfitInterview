# Reservation Data Analysis Project Questionnaire

Below are three sections related to the project.
1. Project Data Points, which contains the project questionnaire and my answers
2. Project Discussion, which contains the project discussion topics and my responses
3. My Questions/Observations, which contains my notes, questions, and other observations relating to the project and questionnaire solutions

## Project Data Points

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

#### 4. How many members completed at least 1 reservation and had no more than 1 cancelled reservation in January?

#### 5. At what time of day do most users book classes? Attend classes? (Morning = 7-11 AM, Afternoon = 12-4 PM, Evening = 5-10 PM)

#### 6. How many confirmed completed reservations did the member (ID) with the most reserved classes in February have?

#### 7. Write a query that unions the `mindbody_reservations` table and `clubready_reservations` table as cleanly as possible.


## Project Discussion

#### 1. What opportunities do you see to improve data storage and standardization for these datasets?

#### 2. What forecasting opportunities do you see with a dataset like this and why?

#### 3. What other data would you propose we gather to make reporting/forecasting more robust and why?


## My Questions/Observations

#### 1. For Question 1 and all other applicable questions, I defined "completed reservations" as those for which a reservation was made AND a check-in/sign-in datetime exists. This is based on my intuition of what it means to "complete" a reservation, since this particular term was not defined elsewhere.

#### 2. In the `clubready_reservations` dataset, there are cases where the reservation has a boolean value of `TRUE` in the `canceled` column AND has a `datetime` value in the `signed_in_at` column
  - I interpreted these instances as "completed reservations" despite the `canceled` value of `TRUE`, since there was a `NOT NULL` `signed_in_at` value. 
