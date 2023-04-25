#!/usr/bin/env bash
(
    wget https://object.pouta.csc.fi/Tatoeba-MT-models/aav-eng/opus4m+btTCv20210807-2021-09-30.zip
    unzip opus4m+btTCv20210807-2021-09-30.zip -d teacher
)
(
    wget https://object.pouta.csc.fi/Tatoeba-MT-models/mkh-eng/opus4m+btTCv20210807-2021-09-30.zip
    unzip opus4m+btTCv20210807-2021-09-30.zip -d teacher-alt
)
