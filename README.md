# Readme
## Description of the file

## Methodology
While the rise of antisemitism on X is no longer questionable since the last Hamas attack on October 7th in Israel, the quantitative part of this study aims to observe the trend of antisemitic behavior on Twitter/X before and after the acquisition of Twitter by Elon Musk on October 27th, 2022. The quantitative part aims to provide an overview of the largest possible sample of antisemitic tweets through relevant hashtags and quantification of how much changes in Twitter’s policies have impacted the rise of antisemitism. The methodology hinges on several crucial steps, described below. Moreover, all codes and datasets are available both on the GitHub. 

### Building of the dataset of all tweets
The first step was to gather a sufficient quantity of possible antisemitic tweets in order to treat them and try to find significant insights into the impact of X’s decisions. To gather the tweets, the strategy chosen was the direct scraping of X rather than finding an existing dataset, this strategy has 2 main issues to tackle: first, since August 2023, Elon Musk has blocked all “simple solutions” to scrap X from X’s API (which is now charged) and from well-known Python’s scraping libraries (Tweepy), second the scraping need a precise query, that is to say the user has to specify what specific tweets he wants to scrap (part of the text, dates, user, …).

To tackle the first issue, a new coding strategy has been developed (see [notebook](url) with all technical insights), largely inspired by Python’s library Minet, developed by the Media Lab of Sciences Po. This semi-automatic solution allows us to scrap all tweets needed even if the process has taken a huge amount of time, not to mention technical issues. The strategy to select tweets to be scraped is based on the scraping of relevant hashtags that could potentially be antisemitic.

### Choice of sensitive hashtags
Hashtags have been selected on 2 different strategies: the main one was based on literature and reports of agencies fighting antisemitism that have identified sensitive hashtags and the second one was more based on our observations.

According to the article “Platformed antisemitism on Twitter”, several hashtags have been targeted during the 2018 mid-term election as antisemitic thanks to quantitative content analysis. Among them, we picked out some that are not directly linked to the theme of the election, the selected hashtags are #rotschild, #soros, #zionist, and #jew, with a respective likelihood of being antisemitic of 82%, 81%, 48% and 24% (in the context of that study). Moreover, other relevant hashtags both mentioned in the last study and in a report from the Anti-Defamation League can be used:  #thejew, #jews, #jew. The rest of the hashtags have been chosen whether by personal confrontation to them or by similarities: basically, a sample of tweets have been scraped based on the previous hashtags, and other hashtags used among these tweets have been selected if their occurrence seemed to be sufficient. Finally, we restrict the analysis to the use of 18 hashtags because of the level of time-consuming of the scraping:
 
### Choice of the timeline
In order to evaluate the impact of Elon Musk’s acquisition of Twitter and the implementation of new policies on content moderation, the timeline of the data harvested has been fixed from 01/08/2022 T00:00:00 until 30/09/2023 T23:59:59. By doing this choice, we acknowledge to not cover the last burning emergence of antisemitism on X, especially from the Hamas attack on Israel on 07/10/2023. This choice was motivated by two reasons. First, we tried to scrap tweets during this period and the daily number of tweets was far larger than before October 7th, so it has been a huge time-saving for the study. Second, the study argues that proving a rise in antisemitic behavior on X before October 7th is a much more honest approach regarding the exceptional aspect of this tragic event, not to mention all the consequences after the attack.

### Final Result
The scraping allows the harvest of 230,905 tweets, based on the research of 18 different hashtags, from 01/08/2022 T00:00:00 until 30/09/2023 T23:59:59, with less than 0,02% dates missed (Final_tweet.csv, whose the merging has been made in the part “Data Merging” of this notebook). The percentage of tweets unscraped is due to the fact that because of the ban on simple solutions to scrap Twitter, the process implemented is really long and some dates (second by second) are more difficult to scrap than others, so the most difficult dates have been skipped in the process (see the annex for more information).

### Make the difference between antisemitic and non-antisemitic tweets
The current dataset contains all tweets that include at least one of the targeted hashtags, nonetheless, it doesn’t necessarily imply that all tweets containing one of the hashtags are antisemitic, they are just more likely to include an antisemitic message than other tweets. On the contrary, these hashtags can be also used to denounce antisemitic behaviors. In this second main step, the challenge was to make the difference between antisemitic and non-antisemitic tweets. To do that, we use a pre-trained Natural Language Processing (NLP) model, which is a specific field of Deep Learning, including the well-known Large Language Models (LLMs). To achieve our goal, the main concern was to find a training dataset with a sufficient number of tweets labeled as hate speech or not. The next step was the find a pre-trained model efficient enough and in accordance with our resources both in time and in GPU.

### The training dataset
The training dataset has been extracted from the study “Automated Hate Speech Detection and the Problem of Offensive Language”   which aims to give insights intothe challenges of hate-speech detection on social media concerning the different classifications of hate speech. We used one of their dataset dealing with hate speech, it contains 24,783 labeled tweets classified as “hate speech” (1,430), “offensive language” (19,190), and “neither” (4,163). As the scope of our study is about antisemitism only, we considered only “hate speech” tweets as the targeted ones.

### The NLP model
The selected model is the pre-trained Long-Short-Term Memory (LSTM), a deep learning architecture. The architecture has been built thanks to a sample of 2 billion tweets, mostly to be able to catch the “attention” of a tweet, that is to say, the sentiments behind a tweet. We made the choice to work with 50 dimensions tokens instead of 300 to save time. Then, we perform the training of the dataset on the previous training dataset. The evaluation of the training gives the following metrics: 89,91% of accuracy, 95,26% of recall, and 91,88% of precision. All the code of the model is available on this notebook.

### Application on our dataset
The last model has been trained on English tweets only, because the most important resources of tweets and research are based on the English language. Thus, we predict the character “antisemitic” (or the classification of “hate speech”) of the scraped dataset which contains 158,439 tweets in English (68,8% of all tweets). The prediction classified 26,934 tweets as antisemitic (17% of English tweets), the dataset labeled is available (Data_label.csv).

### R regression
The last dataset with tweets classified as antisemitic only has been used to provide both the data visualization and the regression. The regression used the model of the Event Study (advanced regression) which measures the impact of a specific date on the increase in the number of antisemitic tweets.

#### Dates of interest
Five different dates since the acquisition of Twitter by Elon Musk have been chosen, as they are relevant in their possible impact on content moderation on Twitter. The impact and changes of these dates will be developed in the report.
* 27-10-2022: Acquisition of Twitter by Elon Musk
* 18-11-2022: Implementation of new policy on content moderation “Freedom of Speech, not Reach”
* 12-12-2022: Dissolution of the “Trust and Safety Council” of Twitter
* 17-04-2023: First update of the Freedom of Speech, not Reach” policy
* 12-07-2023: Last update of the Freedom of Speech, not Reach” policy

#### Groups 
The Event Study, which is basically a difference in difference requires two groups of interest that will be compared to provide the linear regression. Obviously, the testing group is the dataset considered as antisemitic composed of 26,934 tweets. The controlling group will be the dataset of all English tweets targeted by our list of sensitive hashtags that haven’t been flagged as antisemitic, composed of 131,505 tweets.

#### Results
As it is said earlier, the only measure of impact will be the number of antisemitic tweets even though other metrics could have been used such as the number of retweets. Then, the final dataset to perform the regression (Event_study.csv) has been built in the part “Regression” of this notebook. Finally, the event studies (one for each date) has been performed thanks to R (code, full results interpreted in the report).

