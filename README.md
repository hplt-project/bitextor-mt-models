# Bitextor MT Models

This repository contains all you need to train models used for bitextor
training in the HPLT project.

## Structure
Configuration files are stored per language pair, i.e. the top level of this directory is a bunch of language pair directories.

Configuration files could include:

- OPUS-filter configurations
- OPUS-cleaner configurations (per dataset)
- bergamot pipeline configurations
- Just notes about which OPUS model you're distilling, using which datasets.

## Use models with TranslateLocally
[TranslateLocally](https://github.com/XapaJIaMnu/translateLocally) is a fast and secure translation tool that runs on your local machine with a GUI, powered by marian and Bergamot. Compile it as described in their repository README and then add the HPLT repository. You can add a custom repository from the Translator Settings->Repositories menu. Details are below:
- Name: HPLT
- URL: [https://raw.githubusercontent.com/hplt-project/bitextor-mt-models/refs/heads/main/models.json](https://raw.githubusercontent.com/hplt-project/bitextor-mt-models/refs/heads/main/models.json)

## Download models:
### v2
https://object.pouta.csc.fi/hplt_bitextor_models/afr-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/bat-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/dra-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/heb-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/inc-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/kor-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/sin-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/slk-eng_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/tha-eng.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/trk-eng.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zsm-eng.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zle-eng_tiny.zip

### v1
https://object.pouta.csc.fi/hplt_bitextor_models/ara_base.tar.gz \
https://object.pouta.csc.fi/hplt_bitextor_models/ara_tiny.tar.gz \
https://object.pouta.csc.fi/hplt_bitextor_models/ca-en_exported_base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/ca-en_exported_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/eus_base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/eus_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/gl-en_exported_base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/gl-en_exported_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/hin_base.tar.gz \
https://object.pouta.csc.fi/hplt_bitextor_models/hin_tiny.tar.gz \
https://object.pouta.csc.fi/hplt_bitextor_models/jpn-eng.base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/jpn-eng.tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/sw-en_exported_base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/sw-en_exported_tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/vie-eng.base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/vie-eng.tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_hans.base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_hans.tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_hant.base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_hant.tiny.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_joint.base.zip \
https://object.pouta.csc.fi/hplt_bitextor_models/zho_joint.tiny.zip

## Citation

If you use any of these models in a scientific publication, use the following citations:

```
@inproceedings{fastNMT,
    title = "{M}ind the {G}ap: {D}iverse {NMT} {M}odels for {R}esource-{C}onstrained {E}nvironments",
    author = "de Gibert Bonet, Ona  and
      O'Brien, Dayyán and
      Variš, Dušan  and
      Tiedemann, Jörg",
    booktitle = "Proceedings of the Joint 25th Nordic Conference on Computational Linguistics and 11th Baltic Conference on Human Language Technologies (NoDaLiDa/Baltic-HLT 2025)",
    month = "march",
    year = "2025",
    address = "Tallinn, Estonia"
}
```

# Acknowledgements

This project has received funding from the European Union’s Horizon Europe research and innovation programme under grant agreement No 101070350 and from UK Research and Innovation (UKRI) under the UK government’s Horizon Europe funding guarantee [grant number 10052546]
