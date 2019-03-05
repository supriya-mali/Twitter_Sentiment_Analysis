#After downloading the hui.lui.pos and hui.lui.neg, mention below the location of the file

pos=readLines("D:/Supriya/R programmimg/Pos_word.txt")
neg=readLines("D:/Supriya/R programmimg/Neg_word.txt")

#Adding words to negative databases
neg=c(neg,'please','request','stop')