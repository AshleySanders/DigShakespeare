import nltk
from nltk.collocations import *
othello_filter = lambda w: w.lower() in ['moor']
bigram_measures = nltk.collocations.BigramAssocMeasures()
trigram_measures = nltk.collocations.TrigramAssocMeasures()
finder = nltk.collocations.BigramCollocationFinder.from_words(nltk.corpus.genesis.words("othello.txt"))
#BigramCollocationFinder.from_words("abc def abc def eeee rrrr tttt yyyy uuuu iiii ooooo")#nltk.corpus.genesis.words('othello-tags.txt'))
#print(finder)
#print(finder.apply_word_filter(othello_filter))
#print(finder.score_ngrams(bigram_measures.pmi)[0])  # doctest: +NORMALIZE_WHITESPACE
bi_gram = finder.score_ngrams(bigram_measures.pmi)
charactersFile='Oth_char.txt' 
#Error check Characters file
try: 
    rawCharacters=open(charactersFile).read()
except IOError: 
    parser.error("Can't find Oth_char file. Do you have a characters.txt in this directory, or did you specify its location in an option?") 


character_list = rawCharacters.upper().split(',')
print(character_list)

for character in character_list:
    filename = character + '.txt'
    f = open('Othello/' + filename, 'w+')
    f.write("-----------------" + character +"----------------\n")
    for i in bi_gram:
        if character.upper() == (i[0][0]).upper() or character.upper() == (i[0][1]).upper():
            f.write(str(i) +"\n")
    f.close()

# for i in bi_gram:
#     for character in character_list:
#         filename = character + ".txt"
#         if character in i[0]:
#             print(i)
#             f = open('test1/' + filename,'w+')
#             f.write("\n---------------------------"+character+"-----------------------------------\n")
#             # f.write(str(len(output)))
#             # f.write()
#             f.close()
           


"""
text = "I do not like green eggs and ham, I do not like them Sam I am!"
tokens = nltk.wordpunct_tokenize(text)
BigramCollocationFinder.from_words(tokens)
scored = finder.score_ngrams(bigram_measures.raw_freq)
#print(sorted(bigram for bigram, score in scored))  # doctest: +NORMALIZE_WHITESPACE
Emilia
Roderigo
"""
