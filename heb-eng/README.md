# Bitextor Hebrew-English models

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/heb-eng/opusTCv20210807+bt_transformer-big_2022-03-13](https://object.pouta.csc.fi/Tatoeba-MT-models/heb-eng/opusTCv20210807+bt_transformer-big_2022-03-13.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train new a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). The configuration file fed into OpusDistillery can be found [here](https://github.com/Helsinki-NLP/OpusDistillery/blob/main/configs/hplt/config.hplt.heb-eng.yml).

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/heb-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

|Model|Flores200-devtest| Model Size |
|---|---|---|---|
|Teacher | 44 BLEU | 238.1M |  - |
|Student-tiny | 39.2 BLEU / 0.8534 COMET | 17M | - |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`