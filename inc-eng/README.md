# Bitextor Indic-English models

Multilingual student model that translates from Bengali, Gujarati, Hindi, Marathi, Nepali and Urdu; into English.

# Teacher
We use an Tatoeba-MT Teacher: [Tatoeba-MT-models/inc-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17](https://object.pouta.csc.fi/Tatoeba-MT-models/inc-eng/opusTCv20230926max50+bt+jhubc_transformer-big_2024-08-17.zip), which has been trained on the [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data) dataset.


# Students
We used the [OpusDistillery](https://github.com/Helsinki-NLP/OpusDistillery) to train a new student with the tiny architecture. For training data, we used [Tatoeba](https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/data). 

[Download the model.](https://object.pouta.csc.fi/hplt_bitextor_models/inc-eng_tiny.zip)

# Evaluation
BLEU scores for the teacher and the student.

### Bengali
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 33.2 BLEU | 239.9M	 | 
|Student-tiny | 25.0 BLEU / 0.8183 COMET | 17M |

### Gujarati
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 37.6 BLEU| 239.9M	 | 
|Student-tiny | 30.7 BLEU / 0.8486 COMET | 17M |

### Hindi
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 40.6 BLEU | 239.9M	 |  
|Student-tiny | 32.7 BLEU / 0.8493 COMET | 17M |

### Marathi
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 33.6 BLEU | 239.9M	 |  
|Student-tiny | 25.2 BLEU / 0.8109 COMET | 17M |

### Nepali
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 19.2 BLEU | 239.9M	 |  
|Student-tiny | 17.4 BLEU | 17M |

### Urdu
|Model|Flores200-devtest| Model Size |
|---|---|---|
|Teacher | 32.8 BLEU | 239.9M	 |  
|Student-tiny | 25.3 BLEU / 0.7907 COMET | 17M |

# How to run
1. Compile [browser-mt/marian-dev](https://github.com/browsermt/marian-dev)
2. Each model comes with a script called `run.sh` and a configuration file `config.yml`, modify them as needed
3. Run `bash run.sh`