![Super Bowl](super_bowl_3.png)

# ETL_Project

In our ETL_Project, we intent to use the NFL game and score information from Kaggle (see link below) to create a database with key Superbowl statistics – including games, stadium, winning/losing teams, mvp player, key highlights, etc.  We will use Pandas to extract and clean up the data, load the data into SQL databases, and use SQL to extract information from different datasets or tables.  

# Data Extract:
- https://www.topendsports.com/events/super-bowl/winners-list.htm
  - The list of all the teams played in Super Bowl since Green Bay won the first in 1967. The years listed indicate the year the Super Bowl was played, the regular season is 
    played during the year before.
  
- https://en.wikipedia.org/wiki/List_of_Super_Bowl_starting_quarterbacks
  - This is a list of NFL quarterbacks with Super Bowl starts.
  
- http://www.espn.com/nfl/superbowl/history/mvps
  - The list of all most valuable players in NFL history with their position and the highlights.
  
- http://stats.washingtonpost.com/fb/glossary.asp
  - This website was mainly scraped to add abbreviation expansion to the MVP list. Containts the abbreviation and and expansion of abbreviation for Player Position. 
  
- https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data
  - scores.csv - NFL football games since the 1966 season with game results and descriptive info including if a playoff game, played at a neutral site, and weather information 
    if available. Data set was built from publicly available NFL data, weather provided by the NOAA, and betting data from a variety of sources but cross referenced with Pro 
    Football Reference.
  - teams.csv - NFL teams, team IDs, and conferences
  - stadiums.csv
- Extraction process:
  - Scraped the data from wbesites using BeautifulSoup and requests. html parser has been used for parsing html.
  - Defined a function to scrape the data as there are 4 different websites to scrape.
  - Parsed html was converted to dataframe using pd.read_html and the csv files were converted to dataframe using pd.read_csv.
   
# Data Transformation:
- Cleaning up data: 
  - The data that was extracted contained special characters, NaNs, and missing data. 
  - In some cases the NaNs were converted to spaces and some were dropped.
  - For removing special characters regular expressions were used.
  - Some columns had additional character at the end to notify if the team belongs to AFC or NFC. 
    - Created a new column for the team conference and populated it with AFC for 'a' and NFC for 'n' and them removed that additional character from original column.
    - Another column had 'MVP' next to the quaterback if they were MVP for that year. This was also stripped out and moved to a new column
    - Scores were separated by a '-' in a single column. Stripped the score column into 2 columns instead of one.
    - Suepr bowl numbers were all in roman numerals except for 50. Replaced 50 with 'L' to be consistent with other Super bowl numbers.
    - Scores file contains scores for all the games. There was no column with unique data. So created an 'id' column and generated the numbers 1 through the length of dataset.   
- Dropped columns that are not considered in this analysis.

# Data Load:
- Loaded the data from pandas dataframes to Postgres Database.
- Created additional tables using 'create table tablename as (select ....)
- Finally one table for retrieving all the information that is needed to dispaly for all 54 Super bowl games. 
- Created a super bowl dataframe from the above table using pd.read_sql_query for data visualization.

# Conclusion:
  - One can do the prediction analysis based this historical data that was captured, transformed and loaded and then transformed again.
