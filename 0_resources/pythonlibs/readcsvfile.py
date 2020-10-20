import csv
def read_csv_file(filename):
    file = open(filename, 'r')
    try:
        csvfile = csv.reader(file)
    finally:
        file.close

    return [row for row in csvfile]