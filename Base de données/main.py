import pandas

df = pandas.read_csv('dictionnaire_donnees_groupe2.csv', sep=';', encoding='ISO-8859-1', header=0)

print(df)