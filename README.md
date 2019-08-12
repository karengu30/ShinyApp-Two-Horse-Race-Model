# ShinyApp-Two-Horse-Race-Model
Shiny application for simulating the Two Horse Race Model

The stop-signal task is used as a measure of response inhibition (impulse control), which is impaired in psychiatric diseases such as ADHD and OCD. In the stop-signal paradigm, a subject is given a primary task and sometimes a stop signal is given telling the subject to withhold the primary task (stopping). The probability of stopping the response depends on when the stop signal occurs. For example, the earlier the stop signal occurs, the higher the probability that the action is inhibited, as it is more likely that the stop-signal is processed before the action is completed. The probability of stopping in the stop-signal paradigm is explained by the two-horse race model. According to this model, a go process and a stop process are racing. Whichever process finishes first will be executed. If the go process wins, the response happens, and if the stop process wins, the response is inhibited. 
Based on the model, this simulation shows how mean reaction time (mRT), standard deviation (SD), stop signal reaction time (SSRT), and different stop signal delays (relative to the mRT) impact the probability of inhibition. This simulation also shows the effect of including or excluding the trials where a response occurred before the stop signal was presented (denoted as “early”). This simulation allows up to six stop signal delays to be viewed at once and setting a delay slider to 1 will exclude that delay.

### “Type of graph” drop down menu has 4 options:
1. **Histogram**: View a histogram of the simulated reaction times for an individual by using mRT, SD, and number of observations as parameters
2. **Histogram with Inhibition**: Fits stop signal delay and stopping time to the histogram by using SSRT and stop signal delay as additional parameters. These graphs show the proportion of early responses before stop signal (“early”, blue), responses after stop signal and before the stopping time (“responded”, green), and responses after the stopping time (“inhibited”, red). 
3. **Sigmoidal Fit**: Fits calculated inhibition probabilities of different delays to an inhibition curve. Two types of inhibitions are calculated: “early” which excludes the early trials and “normal” which includes the early trials. 
4. **All graphs**: All graphs are shown together 

## Further Readings
* Logan, G.D. and Cowan, W.B. (1984) On the Ability to Inhibit Thought and Action: A Theory of an Act of Control. Psychological Review, Vol. 91, No. 3, 295-327
* Eagle, D.M., Bari, A., & Robbins, T.W. (2008) The neuropsychopharmacology of action inhibition: cross-species translation of the stop-signal and go/no-go tasks. Psychopharmacology 199:439–456. DOI: 10.1007/s00213-008-1127-6

## Getting Started
1. Run in web browser from this link
https://two-horse-race-model.shinyapps.io/two-horse-race-model/
2. Download the files and run in R

## Prerequisites
* Web browser for #1
* R software for #2

# Authors
* Karen Gu 
* Alican Caglayan

# Acknowledgements
* Winter Lab at Humboldt Universitat zu Berlin
* DAAD RISE Program for funding this project

# Support
Karen Gu - kgu30@gatech.edu
Alican Caglayan - alican.caglayan@hu-berlin.de
