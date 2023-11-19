# question_app_flutter
Main Menu The main menu should contain the following actions and views: 1.title of the app 2. start new game 3. high score of the best quiz round
The app consists of two views.
1.main menu
2.question/answer page
Main Menu
The main menu should contain the following actions
and views:
1.title of the app
2. start new game
3. high score of the best quiz round
Question/answer page
The question/answer page should contain the following
actions or displays:

1. In the header
a. number of questions: X of Y
b. current score
2. question area
a. card with the question
b. may also contain an image
c. score of the question
3. list of answers
a. the answers should be displayed in random order
b. If the player answers the question correctly
i. the selected answer is displayed in green
ii. the score is added to the current score
c. If the player answers the question incorrectly
i. the selected answer is shown in red
ii. also the correct answer is shown in green
iii. the score remains unchanged
d. After answering a question
i. it takes 2 seconds until the next question appears
ii. clicking on the answers is no longer possible
e. After answering the last question (end of game)
i. the player should be able to return to the main menu
ii. if the player has outbid the High score it is updated
and displayed in the main menu.

Further requirements
• The highscore should be persisted, i.e. after restarting the app the current highscore is still
saved.
Extensions (optional)
Time limit for answering
• The player has only a limited time to answer (e.g. 10 seconds)
• the presentation is done by a progress bar in the header of the question/answer page
• an unanswered question is considered incorrect
• the correct answer is shown in green
• after another 2 seconds the next question appears
