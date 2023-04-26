# Bitextor Chinese-English models

## Data
- Collected from OPUS and Cleaned by Nick 
- zho_Hans: converted with hanzi-convert
- zho_Hant: converted zho_Hans back with hanzi-convert
- zho: concatenation of zho_Hans and zho_Hant

## Teacher models
- zho_Hans-eng: transformer-big and transformer-base trained by Nick
- zho_Hant-eng: transformer-big and transformer-base
- zho-eng: transformer-big and transformer-base

## Student models
```
├── zho-eng 
│   ├── joint.base.base.zip
│   └── joint.base.tiny11.zip
├── zho_Hans-eng
│   ├── dirtycleanmed.tea.big.stu.base.spm0.1.omit.fb.zip
│   └── dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit.fb.zip
└── zho_Hant-eng
    ├── hant.big.base.zip
    └── hant.big.tiny11.zip
```

Joint zho-eng model distilled from transformer-big teacher had poor performance and marian on LUMI refused to train and translate for me. Waiting for the queue to train models distilled from big teachers. But students distilled from base teachers got satisfactory performance.

Student models available at puhti: `/scratch/project_2005815/model_release/zho-eng`

- Better performance on `Hans`, worse performance on `Hant` than opusTC models
- teacher models (`trans_big_zhen`, `trans_base_zhen`) and student models are trained with `Hans`. Therefore, poor performance on `Hant`.
- tatoeba-test contains both simplified and traditional Chinese. Thus, Hans students get worse BLEU scores than opusTC models.

configs:

- `stu.base`: base student model
- spm: `sentencepiece-alphas`
- omit: `output-omit-bias: true`
- fb: `sentencepiece-options: '--byte_fallback true’`

| exp_name | newsdev2017 | newstest2017 | newstest2018 | newstest2019 | newstest2020 | newstest2021 | newstestB2020 | tatoeba-test-v2020-07-28 | tatoeba-test-v2021-03-30 | tatoeba-test-v2021-08-07 | tico19-test | flores200 Hans dev | flores200 Hans devtest | flores200 Hant dev | flores200 Hant devtest | avg |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| trans_big_zhen (teacher) | 26.6 | 29.6 | 29.8 | 33.8 | 32.3 | 26.7 | 25.9 | 29.5 | 29.5 | 29.6 | 33.2 | 29.7 | 29.8 | 10.3 | 9.9 | 29.7 |
| trans_base_zhen (teacher) | 24.6 | 27.2 | 27.2 | 30.5 | 30.5 | 24.9 | 24.3 | 28.2 | 28.2 | 28.3 | 30.8 | 28.0 | 28.3 | 10.1 | 10.0 | 27.7 |
| opusTCv20210807+nopar+ft95-sepvoc_transformer-small-align_2023-03-16 | 18.0 | 19.9 | 18.9 | 21.4 | 21.1 | 18.1 | 17.3 | 33.8 | 33.8 | 33.8 | 24.1 | 21.7 | 21.3 | 19 | 18.5 | 23.7 |
| opusTCv20210807+nopar+ft95-sepvoc_transformer-tiny11-align_2023-03-16 | 17.8 | 19.9 | 18.4 | 21.2 | 20.6 | 17.6 | 16.7 | 33.1 | 33.0 | 33.1 | 23.7 | 21.0 | 20.3 | 18.3 | 17.5 | 23.2 |
| dirtycleanmed.tea.base.stu.base.spm0.1.omit | 23.7 | 26.9 | 26.3 | 29.9 | 29.8 | 24.1 | 23.9 | 27.5 | 27.5 | 27.6 | 29.7 | 27.3 | 27.5 | 9.5 | 9.1 | 27.0 |
| dirtycleanmed.tea.base.stu.base.spm0.1.omit.fb | 23.8 | 26.9 | 26.3 | 30.2 | 29.6 | 24.1 | 23.6 | 27.1 | 27.2 | 27.3 | 29.8 | 27.4 | 27.4 | 9.5 | 9.3 | 26.9 |
| dirtycleanmed.tea.base.stu.base.spm0.omit | 23.9 | 26.9 | 26.3 | 29.9 | 29.6 | 24.1 | 23.5 | 27.3 | 27.3 | 27.4 | 29.6 | 27.7 | 27.5 | 9.4 | 9.3 | 26.9 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.1.omit | 21.8 | 24.4 | 23.8 | 26.9 | 26.7 | 21.5 | 21.5 | 25.4 | 25.5 | 25.6 | 27.0 | 25.8 | 25.4 | 8.4 | 8.2 | 24.6 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.1.omit.fb | 21.7 | 24.6 | 23.8 | 27.1 | 26.7 | 21.5 | 21.5 | 25.5 | 25.6 | 25.7 | 27.2 | 25.7 | 25.7 | 8.3 | 8.3 | 24.6 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.omit | 21.1 | 24.3 | 23.2 | 26.0 | 25.8 | 21.1 | 20.8 | 25.3 | 25.3 | 25.4 | 26.5 | 25.2 | 24.9 | 8.0 | 7.8 | 24.1 |
| dirtycleanmed.tea.big.stu.base.spm0.1.omit | 24.7 | 28.0 | 27.5 | 32.0 | 30.7 | 25.1 | 24.6 | 27.8 | 27.8 | 27.9 | 30.6 | 28.5 | 28.0 | 9.5 | 9.1 | 27.9 |
| dirtycleanmed.tea.big.stu.base.spm0.1.omit.fb | 24.8 | 28.3 | 27.6 | 32.0 | 30.8 | 25.0 | 24.5 | 27.7 | 27.7 | 27.8 | 31.1 | 28.8 | 28.0 | 9.7 | 9.5 | 27.9 |
| dirtycleanmed.tea.big.stu.base.spm0.omit | 24.6 | 27.8 | 27.6 | 31.3 | 30.6 | 24.6 | 24.6 | 27.5 | 27.6 | 27.7 | 30.7 | 28.4 | 28.1 | 9.6 | 9.0 | 27.7 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit | 22.3 | 25.5 | 24.5 | 27.9 | 27.1 | 21.7 | 22.0 | 25.9 | 25.9 | 26.0 | 27.8 | 26.1 | 25.5 | 8.2 | 7.9 | 25.1 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit.fb | 22.1 | 24.9 | 24.4 | 28.0 | 26.8 | 21.4 | 21.8 | 25.8 | 25.8 | 25.9 | 27.4 | 25.8 | 25.4 | 8.2 | 7.7 | 24.9 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.omit | 22.3 | 25.6 | 24.6 | 27.8 | 26.9 | 21.5 | 21.9 | 25.6 | 25.7 | 25.8 | 27.8 | 25.9 | 25.7 | 8.3 | 8.4 | 25.0 |

## Results of Hant with hanzi-convert

Results obtained with hanzi-convert, i.e., Hant dev text are converted to Hans and evaluated with Hans student models. 

| Model | flores200 Hant dev | flores200 Hant devtest |
| --- | --- | --- |
| opusTCv20210807+nopar+ft95-sepvoc_transformer-small-align_2023-03-16 | 19 | 18.5 |
| opusTCv20210807+nopar+ft95-sepvoc_transformer-tiny11-align_2023-03-16 | 18.3 | 17.5 |
| trans_base_zhen | 27.4 | 26.5 |
| dirtycleanmed.tea.base.stu.base.spm0.1.omit | 26.3 | 25.7 |
| dirtycleanmed.tea.base.stu.base.spm0.1.omit.fb | 26.5 | 25.4 |
| dirtycleanmed.tea.base.stu.base.spm0.omit | 26.7 | 25.2 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.1.omit | 24.3 | 23.2 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.1.omit.fb | 24.0 | 23.3 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.omit | 24.1 | 23.1 |
| trans_big_zhen | 28.8 | 28.1 |
| dirtycleanmed.tea.big.stu.base.spm0.1.omit | 27.0 | 26.0 |
| dirtycleanmed.tea.big.stu.base.spm0.1.omit.fb | 27.1 | 26.0 |
| dirtycleanmed.tea.big.stu.base.spm0.omit | 27.2 | 26.0 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit | 24.5 | 23.3 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit.fb | 24.1 | 23.4 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.omit | 24.0 | 23.7 |

## Results of joint models

| exp_name | newsdev2017 | newstest2017 | newstest2018 | newstest2019 | newstest2020 | newstest2021 | newstestB2020 | tatoeba-test-v2020-07-28 | tatoeba-test-v2021-03-30 | tatoeba-test-v2021-08-07 | tico19-test | flores200 Hans dev | flores200 Hans devtest | flores200 Hant dev | flores200 Hant devtest | avg |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| dirtycleanmed.tea.base.stu.base.spm0.1.omit.fb | 23.7 | 27.4 | 26.4 | 31.5 | 30.5 | 24.7 | 24.3 | 36.5 | 36.5 | 36.5 | 30.5 | 27.6 | 27.2 | 25.8 | 24.4 | 28.9 |
| dirtycleanmed.tea.base.stu.tiny11.spm0.1.omit.fb | 21.7 | 24.8 | 23.9 | 27.7 | 27.4 | 21.9 | 21.8 | 34.4 | 34.3 | 34.4 | 27.4 | 25.4 | 25.3 | 23.1 | 22.5 | 26.4 |
| dirtycleanmed.tea.big.stu.base.spm0.1.omit.fb | 12.2 | 14.3 | 12.6 | 13.7 | 14.1 | 11.4 | 11.7 | 24.0 | 23.9 | 24.0 | 15.1 | 15.4 | 14.7 | 13.6 | 13.3 | 15.6 |
| dirtycleanmed.tea.big.stu.tiny11.spm0.1.omit.fb | 7.8 | 8.2 | 7.5 | 7.5 | 7.3 | 6.8 | 6.3 | 17.0 | 17.0 | 17.0 | 7.5 | 8.6 | 8.7 | 8.3 | 7.8 | 9.6 |

# Teacher model

Tatoeba-test contains mixture of simplified and traditional Chinese

| exp_name | newsdev2017 | newstest2017 | newstest2018 | newstest2019 | newstest2020 | newstest2021 | newstestB2020 | tatoeba-test-v2020-07-28 | tatoeba-test-v2021-03-30 | tatoeba-test-v2021-08-07 | tico19-test | flores200 Hans dev | flores200 Hans devtest | flores200 Hant dev | flores200 Hant devtest | avg |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| trans_big_zhen (hans teacher) | 26.6 | 29.6 | 29.8 | 33.8 | 32.3 | 26.7 | 25.9 | 29.5 | 29.5 | 29.6 | 33.2 | 29.7 | 29.8 | 10.3 | 9.9 | 29.7 |
| trans.big.dirtycleanmed.hant/model | 8.8 | 10.5 | 9.6 | 10.8 | 10.0 | 9.3 | 8.4 | 27.2 | 27.0 | 26.9 | 14.0 | 11.1 | 10.9 | 26.6 | 26.3 | 15.8 |
| trans.big.dirtycleanmed.zhen.joint/model | 26.1 | 29.3 | 29.2 | 34.8 | 33.3 | 26.8 | 26.3 | 38.7 | 38.6 | 38.6 | 32.6 | 29.6 | 29.0 | 27.5 | 27.2 | 31.2 |
| trans_base_zhen (hans teacher) | 24.6 | 27.2 | 27.2 | 30.5 | 30.5 | 24.9 | 24.3 | 28.2 | 28.2 | 28.3 | 30.8 | 28.0 | 28.3 | 10.1 | 10.0 | 27.7 |
| trans.base.dirtycleanmed.hant/model | 7.9 | 9.6 | 8.5 | 10.0 | 9.5 | 8.9 | 8.0 | 26.4 | 26.2 | 26.1 | 13.1 | 10.6 | 10.8 | 25.5 | 24.9 | 15.1 |
| trans.base.dirtycleanmed.zhen.joint/model | 24.8 | 28.3 | 27.7 | 33.1 | 32.1 | 26.0 | 25.7 | 37.8 | 37.7 | 37.7 | 31.5 | 28.9 | 28.1 | 26.7 | 26.0 | 30.1 |
