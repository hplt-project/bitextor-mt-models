# Bitextor Malay-English models

Multilingual student model that translates from North Azerbaijani, Kazakh and Uzbek into English.

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/pqw-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30](https://object.pouta.csc.fi/Tatoeba-MT-models/pqw-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). 

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/trk-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 41.3 BLEU / 0.8555 COMET | 237.1M	 | 
|Student-tiny | 38.8 BLEU / 0.8563 COMET | 17M |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`