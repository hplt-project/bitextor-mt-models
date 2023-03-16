#!/usr/bin/env bash
(
  wget https://object.pouta.csc.fi/Tatoeba-MT-models/ara-eng/opus+bt-2021-04-30.zip
  unzip opus+bt-2021-04-30.zip -d teacher
)
(
  wget https://object.pouta.csc.fi/Tatoeba-MT-models/ara-eng/opusTCv20210807+bt_transformer-big_2022-03-09.zip
  unzip opusTCv20210807+bt_transformer-big_2022-03-09.zip -d teacher-alt
)
