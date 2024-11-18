# Bitextor Latvian/Lithuanian-English models

Multilingual student that translates from Latvian and Lithuanian into English.

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/bat-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30](https://object.pouta.csc.fi/Tatoeba-MT-models/bat-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data).

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/bat-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

### Latvian
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | ? BLEU | 236.9M	 |  - |
|Student-tiny | 28.1 BLEU / 0.8281 COMET | 17M | - |

### Lithuanian

|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 33.7 BLEU | 236.9M	 |  - |
|Student-tiny | 29.5 BLEU / 0.8378 COMET | 17M | - |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`