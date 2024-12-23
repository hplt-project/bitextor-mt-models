# Bitextor Slovak-English models

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/ces+slk-eng/opusTCv20210807+bt_transformer-big_2022-03-17](https://object.pouta.csc.fi/Tatoeba-MT-models/ces+slk-eng/opusTCv20210807+bt_transformer-big_2022-03-17.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). The configuration file fed into OpusDistillery can be found [here](https://github.com/Helsinki-NLP/OpusDistillery/blob/main/configs/hplt/config.hplt.slk-eng.yml).

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/slk-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 40.1 BLEU | 235.M |  - |
|Student-tiny | 34.5 BLEU / 0.8522 COMET | 17M | - |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`