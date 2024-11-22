# Bitextor Belarussian/Russian/Ukrainian-English models

Multilingual student that translates from Belarussian, Ukranian and Russian into English.

# Teacher
We use an Tatoeba-MT Teacher: [zle-eng/opusTCv20210807+bt_transformer-big_2022-03-17](https://object.pouta.csc.fi/Tatoeba-MT-models/zle-eng/opusTCv20210807+bt_transformer-big_2022-03-17.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data).

We do not use Cross-Entropy filtering.

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/zle-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

### Belarussian
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 18.5 BLEU | 238.9M	 |  - |
|Student-tiny | 15.5 BLEU | 17M | - |

### Russian
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 35.2 BLEU | 238.9M	 |  - |
|Student-tiny | 29.9 BLEU / 0.8378 COMET | 17M | - |

### Ukrainian
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 39.2 BLEU | 238.9M	 |  - |
|Student-tiny | 33.4 | 17M | - |
