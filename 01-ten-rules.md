# Ten Simple Rules for Success in STAT 432



[[**STAT 432**](https://stat432.org/)] [Spring 2020](https://spring-2020.stat432.org/)

***

STAT 432 is a difficult course. Although, as a result of the [historical grade distribution](http://waf.cs.illinois.edu/discovery/grade_disparity_between_sections_at_uiuc/) I believe some students enter the course believing that it is an "easy" course. This document was written to help address the reasons for this difference between perception and reality. The style is stolen from the popular "Ten Rules" articles published in PLOS journals. A relevant example is  [Ten Simple Rules for Effective Statistical Practice](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1004961).

***

## Rule 1: There Are No Rules

Perhaps it is odd to begin a list of rules exclaiming that there are no rules.

Many students that enroll in STAT 432 have an extensive mathematics background where everything follows a set of rules. However, statistics is not mathematics. While there are certainly rules in statistics, in applied statistics, an analyst must make decisions that can only be guided by heuristics. Students often ask questions such as "What method should I use in this situation?" hoping for a specific answer. While it would be easy to simply provide an "answer" of some specific model or procedure, the reality is that the answer will almost always be "it depends" and the analyst will have to make a somewhat subjective decision based on an extremely long set of heuristics. (The other answer to "Which method should I use in this situation?" will be "Who knows? Try a few and **evaluate** which is working best. Evaluating methods will be a big focus in the course. We care more about the ability to evaluate methods than understanding the inner workings of each method.)

In other words, while we could simply write some sort of flow-chart that tells you what to do in any situation encountered in the course, we reject this authoritarian approach. We prefer to present some heuristics, some reasoning behind them, and allow you to think for yourself. Skepticism is encouraged. You are allowed to form your own opinions about the course material.

Applied to the data analyses done in STAT 432: There is no single correct answer. There are only good arguments and bad arguments.

***

## Rule 2: Read the Syllabus

**Please.** A familiarity with the syllabus will make your experience in the course much smoother. I would suggest returning to the syllabus a number of times throughout the semester, perhaps shortly before the exams.

***

## Rules 3: Previous Learning is Not Gospel

A trap many students fall into is believing that **everything** they have previously learned is relevant in future courses. This is not the case. Just because a method was taught in STAT 420 or STAT 425 does not mean that it is relevant in STAT 432. The most common example of this is Variance Inflation Factors. Students seem to love to drag this concept into STAT 432. While it is certainly possible to appeal to VIFs in STAT 432, they seem to be misapplied more often than not. This is because VIFs are more relevant for inference than prediction. STAT 432 cares about prediction much more than STAT 420 and STAT 425.

***

## Rule 4: All Statements Are True

Rule 4 is somewhat related to Rule 3. The full rule would read: "All statements are true, given the correct conditions." Rule 3 is relevant here because students will often search for information on the internet. They'll arrive at some prescription such as "Method X is good at Task Y." In reality, this statement is always more correctly stated as "Method X is good at Task Y **under Condition Z**."

In other words, context is extremely important.

***

## Rule 5: Don't Miss The Forest For The Trees

STAT 432 covers a lot of content, sometimes at a surface level. When only scratching the surface, students find the lack of details unsatisfying. This is understandable, but realize that STAT 432 is a **first** course in machine learning. We don't believe it is possible to learn all of machine learning in a single course. STAT 432 is about having an understanding of what machine learning is and what you can do with it. Our goal is not to teach you every single detail. (That is impossible.) Instead, we would like to provide a high level overview that will serve as a foundation for future learning. (Both self-study and future courses.)

***

## Rule 6: You Will Struggle

You will struggle, and that is a good thing. If everything in the course were "easy," very little learning would take place. However, we are not advocating struggle for the sake of struggle. We want to support your "struggle" with the material. The course staff is not the enemy. The material is the "enemy." We are here to help you. **Do not hesitate to ask the course staff questions!** Come to office hours! Post on Piazza!

***

## Rule 7: Keep It Simple

Please keep the [KISS Principle](https://en.wikipedia.org/wiki/KISS_principle) in mind. (The name is somewhat unfortunate. No, we are not calling you stupid.) Complexity does not imply valuable.

Within the context of STAT 432:

- All else being equal, we prefer "simple" methods and models.
- When writing reports, shorter is better. (As long as you convey the necessary information.)

***

## Rule 8: RTFM

Warning, the following link contains foul language: [RTFM](https://en.wikipedia.org/wiki/RTFM). RTFM is a common phrase in coding culture. While extremely insensitive, it is perhaps some of the most relevant advice for STAT 432. 

In short, if you experience a coding issue:

- Read the documentation of the function you are trying to use. (Anything you are doing in `R` involves running a function.)
- Search the internet ("Google") for any error messages you've encountered.

This should always be your first line of defense any time you encounter an issue. **However,** we do not expect you to be able to solve all your problems with this method! That's why office hours exists! We simply would like you to get into this habit. Having gone through this step, you are more likely to solve the problem yourself. Additionally, you will be better prepared to discuss any issue with the course staff if you are unable to solve it yourself.

***

## Rule 9: There Are No Stupid Questions

It sounds cliche, but it is true. **Do not hesitate to ask the course staff questions!** Come to office hours! Post on Piazza!

Do note that while there really are no stupid questions, there are some annoying questions. For example:

- Questions that can be answered by reading the syllabus. ("When is Exam 01?" "When are office hours?")
- "Can you tell me what is wrong with my code?"

The second bullet requires some explaining. The direct answer to that question is technically "Yes." However, please note that the course staff is not a debugging machine. If you simply supply us with a bunch of code and asks us what is wrong, you'll be met with a bit of frustration. We expect that you at least pinpoint *where* there is an issue with the code, within reason. (We will give some advice on how best to do this as the semester progresses.) In other words, try to ask your code question in a way that demonstrates that you have already thought about solving your issue. (See Rule #9.) We will always work with you to resolve your issue, but we ask that we are not your first attempt at a resolution.

***

## Rule 10: Learn By Doing

Students overvalue lecture and undervalue homework. STAT 432 will probably contain less "lecture" than you expect, and far too much "work" in the form of quizzes and analyses.

Watching a lecture is a **passive** activity. Taking quizzes is an **active** activity. Reading is a **passive** activity. Performing an analysis is an **active** activity. In my opinion, students enjoy (or more specifically don't dislike) lecture because it requires zero input from them. On the other hand, quizzes are frustrating, but that is a good thing! That frustration means that there is something to learn!

Stated practically and with relevance to STAT 432:

- The quizzes and other course activities should be given highest priority when allotting your time.
- You should read all posted notes *twice*.
  - The first time you should read every word of the assigned material from top to bottom. Try to understand as best as possible, but don't spend too much time reading any particular section. In a first read, it is somewhat more important to read the material to know what is there than to fully understand it.
  - When taking the quizzes or performing an analysis, return to the relevant section of the reading. (Because you read it once before, you'll know a certain section exists, even if you don't understand it.) Read it again. This time you'll have more context, and a better chance of understanding. Run the code. Modify the code and run it again. Write some similar code from scratch by yourself. Now, return to the quiz.
- Recorded lectures will be sparse, but if they exist, watch it once (possibly at 2x speed) but then go back to focusing on the "active" activities.

***

## Conclusion

In summary, if you bring an open mind and a bit of effort, we believe that you will succeed in STAT 432. We don't believe that the course is easy, but we hope that it is ultimately rewarding.

***
