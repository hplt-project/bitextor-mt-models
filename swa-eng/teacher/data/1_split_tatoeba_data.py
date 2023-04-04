from tqdm import tqdm

clean = ["GlobalVoices-v2018q4","TED2020-v1","wikimedia-v20210402"] # Also includes Sawa and Gourmet corpus
mid = ["EUbookshop-v2","JW300-v1c","QED-v2.0a","ELRC_2922-v1","Tanzil-v1","tico-19-v2020-10-28"]
dirty = ["CCAligned-v1", "CCMatrix-v1","ParaCrawl-v8","WikiMatrix-v1"]
discard = ["GNOME-v1","Mozilla-I10n-v1","Ubuntu-v14.10","XLEnt-v1.1"]

en = open('data/tatoeba/train.src','r').readlines()
sw = open('data/tatoeba/train.trg','r').readlines()
ids = open('data/tatoeba/train.id','r').readlines()

clean_sw = open("data/opustrainer/clean_tatoeba.sw","w")
clean_en = open("data/opustrainer/clean_tatoeba.en","w")

mid_sw = open("data/opustrainer/mid.sw","w")
mid_en = open("data/opustrainer/mid.en","w")

dirty_sw = open("data/opustrainer/dirty.sw","w")
dirty_en = open("data/opustrainer/dirty.en","w")

for sw_line, en_line, ids in tqdm(zip(sw,en,ids)):
    if len(sw_line.split()) > 1 and len(en_line.split()) > 1:
        dataset = ids.split()[0]
        if dataset in clean:
            clean_sw.write(sw_line.strip()+"\n")
            clean_en.write(en_line.strip()+"\n")
        elif dataset in mid:
            mid_sw.write(sw_line.strip()+"\n")
            mid_en.write(en_line.strip()+"\n")
        elif dataset in dirty:
            dirty_sw.write(sw_line.strip()+"\n")
            dirty_en.write(en_line.strip()+"\n")
        else:
            continue
