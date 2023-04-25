# Bitextor Swahili-English models

# Teacher
We trained a new model using Opustrainer and Marian.
For data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data), as well as the [SAWA corpus](https://aclanthology.org/W09-0702.pdf) (shared by the author) and the [Gourmet corpus](https://gourmet-project.eu/data-model-releases/). We also used backtranslated data from English NewsCrawl2021 with a [backward model](https://object.pouta.csc.fi/OPUS-MT-models/en-sw/opus-2020-01-08.zip).

# Students
We used the Firefox pipeline to train new students, with tiny and base architectures. For data, we used Tatoeba, SaWa and Gourmet. We used the translations by the teacher of Flores as development set.

# Evaluation
BLEU scores for the teacher and the students.

|Model|Flores200-dev|Flores200-devtest|
|---|---|---|
|Teacher | 40,7 | 39,8 |
|Studemt-base | 37,6 | 36,5 |
|Student-tiny | 36 | 35 |

