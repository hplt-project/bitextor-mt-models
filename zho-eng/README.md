# Bitextor Chinese-English models

## Possible Teacher Systems
### Tatoeba-MT models
https://github.com/Helsinki-NLP/Tatoeba-Challenge/tree/master/models/zho-eng  

1. [opus-2021-02-18.zip](https://object.pouta.csc.fi/Tatoeba-MT-models/zho-eng/opus-2021-02-18.zip)'s BLEU score on `Tatoeba-test.zho.eng`: 36.0  
source language(s): cjy cmn gan hak hsn lzh nan wuu yue


2. [opus-2020-07-17.zip](https://object.pouta.csc.fi/Tatoeba-MT-models/zho-eng/opus-2020-07-17.zip)'s BLEU score on `Tatoeba-test.zho.eng`: 36.1  
source language(s): cjy_Hans cjy_Hant cmn cmn_Hans cmn_Hant gan lzh lzh_Hans nan wuu yue yue_Hans yue_Hant

### Huggingface MarianMT model
https://huggingface.co/Helsinki-NLP/opus-mt-zh-en (original weights [opus-2020-07-17.zip](https://object.pouta.csc.fi/Tatoeba-MT-models/zho-eng/opus-2020-07-17.zip))

### Choices
Tentative teacher model: 
- `opus-2020-07-17.zip` using the original weights or converted Huggingface MarianMT model. 
- [opus-2021-02-18.zip](https://object.pouta.csc.fi/Tatoeba-MT-models/zho-eng/opus-2021-02-18.zip) achieved best averaged BLEU over news, tatoeba, tico19-test testsets.