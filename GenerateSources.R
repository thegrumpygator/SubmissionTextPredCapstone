SubCorp <- readRDS("FiftyPercentCutsubcorpbackup.rds")
###########################################

library("RWeka")
library("tm")
library("quanteda")
library("data.table")
library("dplyr")

mycleanqdcorpus <- corpus(SubCorp)
rm(SubCorp)

n1g <- tokenize(mycleanqdcorpus)
n2g <- ngrams(n1g, n=2, concatenator = " ") # 422 MB
n3g <- ngrams(n1g, n=3, concatenator = " ") # 950 MB
n4g <- ngrams(n1g, n=4, concatenator = " ") # 1.3GB

#rm(mycleanqdtokens)
rm(mycleanqdcorpus)

# Process n-grams ditching any that occur only 2 times
my1dfm <- trim(dfm(n1g), minCount = 3) # features of base doc 10 M
my2dfm <- trim(dfm(n2g), minCount = 3) #                      95 MB
my3dfm <- trim(dfm(n3g), minCount = 3) #                      130MB
my4dfm <- trim(dfm(n4g), minCount = 3) #                      77 MB

rm(n1g)
rm(n2g)
rm(n3g)
rm(n4g)

gc()

# ################################################
# saveRDS(my1dfm, "my1dfm.rds")
# saveRDS(my2dfm, "my2dfm.rds")
# saveRDS(my3dfm, "my3dfm.rds")
# saveRDS(my4dfm, "my4dfm.rds")
# #
# #
# #
# my1dfm <- readRDS("my1dfm.rds")
# my2dfm <- readRDS("my2dfm.rds")
# my3dfm <- readRDS("my3dfm.rds")
# my4dfm <- readRDS("my4dfm.rds")
# ################################################

# create ranked n-gram frequencies
my1dfmFeatures <- topfeatures(my1dfm, length(my1dfm))
my2dfmFeatures <- topfeatures(my2dfm, length(my2dfm))
my3dfmFeatures <- topfeatures(my3dfm, length(my3dfm))
my4dfmFeatures <- topfeatures(my4dfm, length(my4dfm))

f1<- data.table(phrase = names(my1dfmFeatures), num = my1dfmFeatures) %>%
     mutate(prob = num/sum(num)) %>%
     arrange(desc(prob), phrase) %>%
     select(phrase, prob)

f2 <- data.table(phrase = names(my2dfmFeatures), num = my2dfmFeatures) %>% 
     mutate(prob = num/sum(num)) %>%
     mutate(lefty = sapply(phrase, Ltoken)) %>%
     mutate(righty= sapply(phrase, Rtoken)) %>%
     arrange(desc(prob), lefty) %>%
     select(lefty, righty, prob)

f3 <- data.table(phrase = names(my3dfmFeatures), num = my3dfmFeatures) %>% 
     mutate(prob = num/sum(num)) %>%
     mutate(lefty = sapply(phrase, Ltoken)) %>%
     mutate(righty= sapply(phrase, Rtoken)) %>%
     arrange(desc(prob), lefty) %>%
     select(lefty, righty, prob)

f4 <- data.table(phrase = names(my4dfmFeatures), num = my4dfmFeatures) %>%
     mutate(prob = num/sum(num)) %>%
     mutate(lefty = sapply(phrase, Ltoken)) %>%
     mutate(righty= sapply(phrase, Rtoken)) %>%
     arrange(desc(prob), lefty) %>%
     select(lefty, righty, prob)

sources <- list(f1, f2, f3, f4)

saveRDS(sources, "FiftyPercentdatasourcesSubmission--.rds")