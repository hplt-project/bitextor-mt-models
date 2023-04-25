# Bitextor Galician-English models

# Teacher
We trained a new many2one model using Opustrainer and Marian for the directions Spanish, Portuguese, Galician to English.
For data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data), as well as the [CLUVI corpus](https://github.com/xavier-gz/SLI_Galician_Corpora/blob/main/SLI_CLUVI_EN_GL_TMX_3.4.tar.gz). We also used backtranslated data from English NewsCrawls with a [backward model](https://object.pouta.csc.fi/Tatoeba-MT-models/eng-roa/opus-2020-06-28.zip) and also Tatoeba pivoted data.

# Students
We used the Firefox pipeline to train new students, with tiny and base architectures. For data, we used Tatoeba and CLUVI. We used the translations by the teacher of Flores as development set.

# Evaluation
BLEU scores for the teacher and the students.

|Model|Flores200-dev|Flores200-devtest|
|---|---|---|
|Teacher   |  41	 | 41   |
|Studemt-base  | 37,7 | 37,2   |
|Student-tiny   | 36,1  | 35,9   |

	
	
