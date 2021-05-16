---
layout: page
output:
  md_document:
    preserve_yaml: true
    variant: gfm
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

-   **You should use the Rmd template provided.** Download the template
    [<i class="fas fa-download"></i>](https://github.com/STATS-UOA/stats220/releases/download/v3.0/a3-template.Rmd)
    and save it to your `Rproj` folder. If you fail to compile the Rmd
    due to some missing packages, install these packages on your
    computer.
-   **NO marks will be given to the submission that cannot be reproduced
    on the hosted runner.**
-   Marking is based on the rendered document, instead of the Rmd file.
-   **Show and place all relevant source code, output, and narratives to
    the appropriate sections; otherwise, marks will be deducted.**
-   Set each figure’s size appropriately for clear presentation.
-   If you use other sources of data to enrich the exploration, please
    fill [the Google
    form](https://docs.google.com/forms/d/1Vf3T6_fkG9vrLuFFZzQ7tHGea9Zxga3wZX6C1V5f02g/edit?usp=sharing)
    and upload your data. Make sure that all data files are placed under
    the `data/` folder.

### [Citi <i class="fas fa-biking"></i> NYC offical website](http://citibikenyc.com)

### Q1: Web scraping \[3 pts\]

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

### Q2: Critique \[1 pts\]

Your instructor deliberately introduced a decision mistake to Assignment
2 Question 4. This decision didn’t do any harm to the analysis, but it
could certainly be improved to better fit the context by more adequate
research about the Citi bike data. Point out what the issue is, and
provide reference to support your argument. (**NOTE:** NO marks given
for pointing out the issue alone without any reference.)

### Q3: Polishing \[1 pts\]

Pick one plot (or its variants) from Assignment 2, and make improvements
to get a polished one for the purpose of **communication**. For example,

-   add informative titles and labels
-   apply appropriate scales if needed
-   use colour-blind friendly colours if needed
-   highlight something of interest, etc.

### Q4: Exploration \[5 pts\]

1.  Create at least **one publication-ready plot** that have NOT been
    seen in Assignment 1 and 2, in the meantime reveal some **new
    insights** (i.e. interesting and meaningful) about the data. Provide
    a description of:

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

-   Interactive graphics are NOT accepted.
-   DO NOT share any of your ideas or explorations on Piazza or other
    venues.

**Grading rubric:**

<table style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif; display: table; border-collapse: collapse; margin-left: auto; margin-right: auto; color: #333333; font-size: 16px; font-weight: normal; font-style: normal; background-color: #FFFFFF; width: auto; border-top-style: solid; border-top-width: 2px; border-top-color: #A8A8A8; border-right-style: none; border-right-width: 2px; border-right-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #A8A8A8; border-left-style: none; border-left-width: 2px; border-left-color: #D3D3D3;">
  
  <thead style="border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3;">
    <tr>
      <th style="color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" rowspan="1" colspan="1"><strong>Pts</strong></th>
      <th style="color: #333333; background-color: #FFFFFF; font-size: 100%; font-weight: normal; text-transform: inherit; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: bottom; padding-top: 5px; padding-bottom: 6px; padding-left: 5px; padding-right: 5px; overflow-x: hidden; text-align: left;" rowspan="1" colspan="1"><strong>Criteria</strong></th>
    </tr>
  </thead>
  <tbody style="border-top-style: solid; border-top-width: 2px; border-top-color: #D3D3D3; border-bottom-style: solid; border-bottom-width: 2px; border-bottom-color: #D3D3D3;">
    <tr>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Outstanding<br>(5)</p>
</div></td>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Intense exploration and evidence of many trials and failures (e.g. demonstrations of some dead ends). You have looked at the data in many different ways before coming to your final answer.<br>You have gone beyond what was asked: additional research from other sources (e.g. web scraping for membership price) used to help understand/explain findings.<br>You suggest multiple explanations for a given finding, and use multiple approaches to explore surprising results. You present one or two as the most plausible, but have allowed for the possibility that you are wrong.<br>You don't blindly accept perceived wisdom (e.g. collecting more contextual information), but challenge preconceived notions and come up with interesting new ways of testing them.</p>
</div></td>
    </tr>
    <tr>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Good<br>(4)</p>
</div></td>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Plenty of exploration and investigation. Some additional research helps explain findings, and some of your ideas are creatively presented and explained.<br>You are sceptical and self-critical, but not consistently. There is some critical analysis, and some use of multiple techniques to answer the same question.</p>
</div></td>
    </tr>
    <tr>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Acceptable<br>(3)</p>
</div></td>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Some exploration, but little evidence that you have selected the best of many ideas. Little or no additional research.<br>You haven't blinded accepted findings, but you haven't come up with many ways to check your results either.<br>There is little self-criticism and little evidence to suggest you have thought about how to do better in the future.</p>
</div></td>
    </tr>
    <tr>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Needs work<br>(2)</p>
</div></td>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>You have done the bare minimum that was asked. There is no evidence to suggest that you tried multiple approaches (tables, graphics, or models) before coming to your final conclusion.<br>Some findings accepted without question. Self-criticism weak.</p>
</div></td>
    </tr>
    <tr>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Inadequate<br>(1)</p>
</div></td>
      <td style="padding-top: 8px; padding-bottom: 8px; padding-left: 5px; padding-right: 5px; margin: 10px; border-top-style: solid; border-top-width: 1px; border-top-color: #D3D3D3; border-left-style: none; border-left-width: 1px; border-left-color: #D3D3D3; border-right-style: none; border-right-width: 1px; border-right-color: #D3D3D3; vertical-align: middle; overflow-x: hidden; text-align: left;"><div class='gt_from_md'><p>Questions are simple, and there is no evidence of exploration. You have not come up with your own questions of the data, but relied on those discussed in assignments.<br>Findings accepted uncritically.<br>Leaps of logic without justification.<br>You have not thought about how to do better next time.</p>
</div></td>
    </tr>
  </tbody>
  
  
</table>
