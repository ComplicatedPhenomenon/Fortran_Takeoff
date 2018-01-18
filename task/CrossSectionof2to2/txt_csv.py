import csv
with open('DATAgg4.txt','r') as in_file:
    stripped = (line.strip() for line in in_file)
    lines = (line for line in stripped if line)
    grouped = zip(*[lines] * 3)
    with open('DATAgg4.csv','w') as out_file:
        writer = csv.writer(out_file)
        writer.writerow(('title', 'intro', 'tagline'))
        writer.writerows(grouped)
