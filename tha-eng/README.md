# Bitextor Thai-English models

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/tai-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17](https://object.pouta.csc.fi/Tatoeba-MT-models/tai-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data).

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/tha-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 27.1 BLEU | 234.5M |  - |
|Student-tiny | 19.7 BLEU / 0.7856 COMET | 17M | - |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`