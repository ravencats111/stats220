---
output: 
  md_document:
    preserve_yaml: true
    variant: gfm
layout: page
title: Assignment 3
---

This assignment is **due 23:59 Friday 28 May (NZST)**.

-   You should submit an R Markdown file (i.e. file extension `.Rmd`).
-   You should submit your Rmd file on Canvas.
-   Late assignments are NOT accepted unless prior arrangement for
    medical/compassionate reasons.
-   Your submission should NOT contain any plagiarism.

------------------------------------------------------------------------

In this assignment, you will present your findings about 2018 Citi Bike
trip data in New York City (`2018-citibike-tripdata.csv`).

Suppose that you have created an `Rproj` for this course. You need to
download `2018-citibike-tripdata.csv`
[here](https://github.com/STATS-UOA/stats220/releases/download/v1.0/2018-citibike-tripdata.csv)
to `data/` under your `Rproj` folder.

-   **You MUST use the Rmd template provided.** Download the template
    [here]() and save it to your `Rproj` folder. If you fail to compile
    the Rmd due to some missing packages, install these packages on your
    computer.
-   **NO marks will be given to the submission that cannot be reproduced
    on the hosted runner.**
-   **Show and place all relevant source code, output, and narratives to
    the appropriate sections; otherwise, marks will be deducted.**
-   Set each figure’s size appropriately for clear presentation.
-   If you use other sources of data to enrich the exploration, please
    fill [the Google form]() and upload your data. Make sure that all
    data files are placed under the `data/` folder.

### [Citi <i class="fas fa-biking"></i> NYC offical website](http://citibikenyc.com)

### Web scraping \[3 pts\]

[<img src="/figures/citibike-plan.png" width="840" style="display: block; margin: auto;" />](https://www.citibikenyc.com/pricing)

Scrape Citi bike membership plan from [this web
page](https://www.citibikenyc.com/pricing), and present the scraped data
as **an HTML table**.

{{<table "table table-striped table-hover table-bordered table-responsive">}}

| Plan              | Price       | Minutes                                                          |
|:------------------|:------------|:-----------------------------------------------------------------|
| Single Ride       | $3.50/trip  | one ride up to 30 minutes on a Classic bike.                     |
| Day Pass          | $15/day     | unlimited 30-minute rides in a 24-hour period on a Classic bike. |
| Annual Membership | $15\*/month | unlimited 45-minute rides on a Classic bike.                     |

{{</table>}}

### Self-criticism \[1 pts\]

Your instructor unintentionally made a minor mistake when designing
Assignment 2 Question 4, due to inadequate research on the Citi bike
data. Point out what the issue is, and provide reference to support your
argument. (**NOTE:** NO marks given for pointing out the issue alone
without any reference.)

### Polishing \[1 pts\]

Pick one plot (or its variants) from Assignment 2, and make improvements
to get a polished one for the purpose of **communication**. For example,

-   add informative titles and labels
-   apply appropriate scales if needed
-   use colour-blind friendly colours if needed
-   highlight something of interest, etc.

### Curiosity \[5 pts\]

1.  Create **a publication-ready plot** that has NOT been seen in
    Assignment 1 and 2, in the meantime reveals some new insights about
    the data. Provide a description of:

    -   what question you had in mind motivated this plot;
    -   what you found interesting from this plot.
    -   You might want to briefly mention some of the dead ends you went
        down to demonstrate that you have done more than just the
        obvious. Provide your code in the “Appendix” section.

2.  Summarise what you learned from this data in general. Try and weave
    your findings together into a consistent story.

3.  Reflect on other questions that the exploration raised, and what you
    would do next in terms of further questions or ways to investigate
    the data.

**NOTE:**

-   Interactive graphics are NOT acceptable.
-   DO NOT share any of your ideas on Piazza.
-   Hadley Wickham’s ([grading
    rubric](http://stat405.had.co.nz/homework/rubric.pdf)) will be
    adapted for grading this section.
