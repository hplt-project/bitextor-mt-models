# Bitextor Vietnamese-English models

Configurations for Vi→En models.

## Possible Teacher Systems

  1. https://object.pouta.csc.fi/Tatoeba-MT-models/aav-eng/opus4m+btTCv20210807-2021-09-30.zip 
  2. https://object.pouta.csc.fi/Tatoeba-MT-models/mkh-eng/opus4m+btTCv20210807-2021-09-30.zip 

## Processing Steps

  0. Set locations of Marian and other tools
  ```
    export MARIAN="/path/to/marian/build"
    export BERGAMOT_STUDENTS="/path/to/repo/clone"  # clone of https://github.com/browsermt/students.git

    # Optional
    export PYTHON_VIRTUALENV="/path/to/virtualenv"  # should contain dependencies for OpusCleaner

  ```

  1. Download teachers
  ```
    $ bash get_teacher.sh

    # (Optional) test teachers
    $ bash test_teachers.sh
  ```

  2. Download and clean corpora (TODO corpora download)
  ```
    $ cd data/v1/clean && bash clean.sh
  ```

  3. Translate corpora using teacher models (knowledge distillation)
  ```
    $ cd data/v1/distilled && bash distill_all.sh
  ```

  4. Combine the original source and distilled target data and split it for training/validation.
  ```
    $ cd data/v1/train && bash make.sh
  ```

  5. Create vocabulary and a lexical shortlist.
  ```
    $ cd vocab/v1 && bash create_vocab.sh && bash create_shortlist.sh
  ```

  6. Train (and test) the student model.
  ```
    $ export model=base  # base, tiny
    $ cd students/v1/$model && bash train.sh && bash test.sh
  ```

  7. Quantize (and test) the model.
  ```
    $ cd students/v1/$model && bash quantise.sh && bash quantise_test.sh
  ```
