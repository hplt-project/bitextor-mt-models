#!/usr/bin/env bash
(
    wget https://object.pouta.csc.fi/OPUS-MT-models/ja-en/opus-2019-12-18.zip
    unzip opus-2019-12-18.zip -d teacher
)
(
    wget https://object.pouta.csc.fi/Tatoeba-MT-models/jpn-eng/opus-2020-06-17.zip
    unzip opus-2020-06-17.zip -d teacher-alt
)
