from tqdm import tqdm

mid = ["OpenSubtitles-v2018","QED-v2.0a","TED2020-v1","ELRC_2922-v1", "wikimedia-v20210402"] # Also CLUVI
ccmatrix = ["CCMatrix-v1"]
wiki = ["WikiMatrix-v1"]
discard = ["GNOME-v1", "KDE4-v2", "Mozilla-I10n-v1", "Ubuntu-v14.10", "XLEnt-v1.1"]

en = open('data/raw/tatoeba/train.src','r').readlines()
gl = open('data/raw/tatoeba/train.trg','r').readlines()
ids = open('data/raw/tatoeba/train.id','r').readlines()

mid_gl = open("data/raw/mid.gl","w")
mid_en = open("data/raw/mid.en","w")

dirty_gl = open("data/raw/ccmatrix.gl","w")
dirty_en = open("data/raw/ccmatrix.en","w")

dirty_gl_2 = open("data/raw/wikimatrix.gl","w")
dirty_en_2 = open("data/raw/wikimatrix.en","w")

for gl_line, en_line, ids in tqdm(zip(gl,en,ids)):
    if len(gl_line.split()) > 1 and len(en_line.split()) > 1:
        dataset = ids.split()[0]
        if dataset in mid:
            mid_gl.write(gl_line.strip()+"\n")
            mid_en.write(en_line.strip()+"\n")
        elif dataset in ccmatrix:
            dirty_gl.write(gl_line.strip()+"\n")
            dirty_en.write(en_line.strip()+"\n")
        elif dataset in wiki:
            dirty_gl_2.write(gl_line.strip()+"\n")
            dirty_en_2.write(en_line.strip()+"\n")
        else:
            continue
