# Bitextor Dradivian-English models

Multilingual student model that translates from Kannada, Malayalam, Tamil and Telugu; into English.

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/dra-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17](https://object.pouta.csc.fi/Tatoeba-MT-models/dra-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). 

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/dra-eng_tiny.zip)
 
# Evaluation
BLEU scores for the teacher and the student.

### Kannada
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 32.5 BLEU | 240.4M	 | 
|Student-tiny | 26.3 BLEU / 0.8192 COMET | 17M |

### Malayalam
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 34.8 BLEU| 240.4M	 | 
|Student-tiny | 25.5 BLEU / 0.8120 COMET | 17M |

### Tamil
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 32.4 BLEU | 240.4M	 |  
|Student-tiny | 21.5 BLEU / 0.7750 COMET | 17M |

### Telugu
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 38.4 BLEU | 240.4M	 |  
|Student-tiny | 29.9 BLEU / 0.8236 COMET | 17M |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`