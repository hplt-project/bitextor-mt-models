# Bitextor Catalan-English models

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/cat-eng/opus+bt-2021-04-30](https://object.pouta.csc.fi/Tatoeba-MT-models/cat-eng/opus+bt-2021-04-30.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset and backtranslations.


# Students
We used the Firefox pipeline to train new students, with tiny and base architectures. For data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data), as well as the monolingual [Catalan Textual Corpus](https://zenodo.org/record/4519349) and the [Macocu](https://www.clarin.si/repository/xmlui/handle/11356/1837) dataset.

# Evaluation
BLEU scores for the teacher and the students.

|Model|Flores200-devtest| Model Size | tokens/s on 1 CPU
|---|---|---|---|
|Teacher | 41,5 | 798M |  - |
|Student-base | 40,3 | 41M  | 1224,97 |
|Student-tiny | 39,4 | 17M | 2940,61 |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`