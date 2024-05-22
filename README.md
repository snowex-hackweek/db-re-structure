# DB-Re-Structure
Slack channel: DBRS

## Project Title and Introduction

### Collaborators

| Name | Personal goals | Can help with | Role |
| ------------- | ------------- | ------------- | ------------- |
| Anthony A. |  |  | Project Lead |
| Joe M. | Make SnowEx data easier and faster to access | DB design, Software Development | Project Lead |

### The problem
This project aims to accelerate seasonal snow science discoveries using data from the 7-year NASA SnowEx Mission (2017-2023) by reducing technical data access challenges and expanding data accessibility. During the past Hackweek, the Snow Ex DB enabled new research by allowing efficient integration of data across platforms. However, the event participants identified challenges with slow data access times and a steep learning curve for discovering data. This project will address the identified challenges by redesigning the database schema to conform with industry database standards, increasing performance and robustness.

## Data and Methods

### Data
All published [SnowEx datasets at the NSIDC](https://nsidc.org/data/snowex/data).

### Existing methods
With the initial prototype design, the database layout holds as much information within central tables and thus maximizes data retrieval with a single query. However, this design principle was identified as a major contributing factor to the slow query times during increased database traffic during the workshops.

### Proposed methods/tools
Best practices from the industry (Chen, 1976) established a different design, where information gets broken up into multiple tables to increase data integrity, durability, and consistency.


#### Example
As a specific SnowEx DB example, the current design holds the location information with every measurement entry in one table. The improvement to this is creating two tables, where every measurement gets associated with one location. As a result, it reduces the amount of redundant data returned and speeds up request times. For the location, it creates integrity as only one standardized form is stored. Using this design also improves indexing capabilities, further speeding up data lookup.

### Additional resources or background reading
Chen, P. P.-S. (1976). The entity-relationship model—toward a unified view of data. ACM Transactions on Database Systems, 1(1), 9–36. https://doi.org/10.1145/320434.320440

## Project goals and tasks

### Project goals

### Tasks


## Project Results
