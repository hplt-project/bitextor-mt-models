# Bitextor Swahili-English models

# Teacher
We trained a new model using Opustrainer and Marian.
For data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data), as well as the [SAWA corpus](https://aclanthology.org/W09-0702.pdf) (shared by the author) and the [Gourmet corpus](https://gourmet-project.eu/data-model-releases/). We also used backtranslated data from English NewsCrawl2021 with a [backward model](https://object.pouta.csc.fi/OPUS-MT-models/en-sw/opus-2020-01-08.zip).

# Students
We used the Firefox pipeline to train new students, with tiny and base architectures. For data, we used Tatoeba, SaWa and Gourmet. We used the translations by the teacher of Flores as development set.

# Evaluation
BLEU scores for the teacher and the students.


|Model|Flores200-dev|Flores200-devtest| Model Size | tokens/s on 1 CPU
|---|---|---|---|---|
|Teacher | 40,7 | 39,8 | 798M |  - |
|Student-base | 37,6 |	36,1| 41M  | 1108,11 |
|Student-tiny | 35,9 |34,3 | 17M | 2337,10 |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`