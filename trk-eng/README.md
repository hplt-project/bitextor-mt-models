# Bitextor Turkic-English models

Multilingual student model that translates from North Azerbaijani, Kazakh and Uzbek into English.

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/trk-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30](https://object.pouta.csc.fi/Tatoeba-MT-models/trk-deu+eng+fra+por+spa/opusTCv20230926max50+bt+jhubc_transformer-big_2024-05-30.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). 

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/trk-eng.zip)

# Evaluation
BLEU scores for the teacher and the student.

### North Azerbaijani
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 20.5 BLEU / 0.8200 | 238.8M	 | 
|Student-tiny | 17.5 BLEU / 0.8020 COMET | 17M |

### Kazakh
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 27.4 BLEU/ 0.8167 COMET | 238.8M	 | 
|Student-tiny | 22.9 BLEU / 0.7847 COMET | 17M |

### Uzbek
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 28.5 BLEU / 0.8168 COMET | 238.8 M	 |  
|Student-tiny | 24.1 BLEU / 0.7894 COMET | 17M |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`