_5th_ _February_ _2023_

# Frog Census Data Exploration App

This is an interactive app that allows the user to explore the results of frog census surveys in the Melbourne region from 2001 - 2018.<br>

The app utilizes data from the seven most commonly observed frogs during frog surveys. The dataset is a compilation of data 
from the citizen scientist frog census program through Melbourne Water Corporaton, the Victorian Biodiversity Atlas and 
incidental observations recorded during unrelated surveys, for example surveys of birds.<br>

To use the app, click the link below. Select the year and one of the seven species of frogs listed to view the locations in the Melbourne 
area where that species has been observed.

[Click here to run application](https://slmcrae.shinyapps.io/frog/)

[Click here to view rshiny code](https://github.com/slmcrae/frog/blob/master/app.R)

[Click here to view data cleaning and exploration file](https://github.com/slmcrae/frog/blob/master/frog_census_data_cleaning.Rmd)

## Background

Frogs are sensitive to environmental changes and are therefore good indicators of the overall health of waterways. The Frog Census 
conducted by Melbourne Water Corporation is especially concerned with tracking threatened species.<br>

Ecological surveys can be greatly assisted by adhoc observations of wildlife. However, there can be inaccuracies in the data due 
to mis-identification of species. It has been shown that when data is filtered by the quality of the record, and the quality of the 
process involved in obtaining an observation, useful models can be developed.<br>

In 2016, Melbourne Water released a phone app to help people record frog sounds and the location where they were heard. 
It includes precise instructions for recording observations. These 'citizen scientist' recordings are verified by frog experts. 
Since this app was made public the number of observations recorded each year has increased substantially.<br>

For more information about the frog census app and tips on how to go 'frogging' visit the Melbourne Water website [here](https://www.melbournewater.com.au/education/citizen-science/census/frog-census).<br>

More information about frog species located in Victoria and across Australia can be found at the [Frogs of Australia website](https://frogs.org.au/frogs/).

## Dataset information
The original dataset contains 31,666 observations dating back to January 15th 1960, and includes observations from many different formal
surveys and incidental observations outside of surveys.  

The cleaned dataset that was used for the application contains 21,629 observations taken from 2001. This year was chosen as the cutoff
because it was the year in which Melbourne Water began formal frog census surveying.<br>

Prior to 2001, 2.76% of observations are listed as part of a frog census under "Type_of_observation" and 87.95% are listed as incidental
or general observations.<br>

After the commencement of the Melbourne Water surveying in 2001, 50.14% of observations have been part of a frog census,
10.78% are general or incidental observations, and 20.93% are listed as "unknown" observation type.<br>

It was assumed that the data collected after 2001 was more reliable.<br>

The application utilizes only the top most commonly observed frog species as there were observations in nearly every year.

The Melbourne Water Corporation continues to update frog census data on the [Data Vic website](https://discover.data.vic.gov.au/dataset/frog-census-records3).<br>
This app uses data up to and including December 20th 2018.<br>

Original dataset: Frog_Census_Records.csv

Cleaned dataset: frogs_2001.csv

## References
Dataset from Data Vic: https://discover.data.vic.gov.au/dataset/frog-census-records3<br>
Melbourne Water: https://www.melbournewater.com.au/education/citizen-science/census/frog-census<br>
Victorian Biodiversity Atas:  https://www.environment.vic.gov.au/biodiversity/victorian-biodiversity-atlas<br>
<br>

**_Photo_** **_Credits_**<br>
Eastern Banjo Frog:  _Matt_ _Clancy_, https://backyardbuddies.org.au/backyard-buddies/eastern-banjo-frogs/<br>
Common Eastern Froglet:  _Matt_ _Clancy_, https://backyardbuddies.org.au/backyard-buddies/common-eastern-froglets/<br>
Growling Grass Frog:  _Geoff_ _Heard_, [Merry Creek Management Committee website](https://www.mcmc.org.au/index.php?option=com_content&view=article&id=777:growling-grass-frogs-in-fawkner&catid=29:front-page-blurb&acm=_196)<br>
Southern Brown Tree Frog:  _Sun_ _of_ _Erat_, https://backyardbuddies.org.au/backyard-buddies/southern-brown-tree-frog/<br>
Spotted Marsh Frog:  _Sunphlo_, https://backyardbuddies.org.au/backyard-buddies/spotted-grass-frog/<br>
Striped Marsh Frog:  _Ian_ _Moodie_, https://blackburncreeklands.wordpress.com/fauna-and-flora/our-frogs/<br>
Whistling Tree Frog:  _Wikipedia_, https://en.wikipedia.org/wiki/Whistling_tree_frog<br>
Menu option 'All' (Whistling Tree Frog):  _unknown_, http://mybackyard.info/backyardblog/?p=118<br>
