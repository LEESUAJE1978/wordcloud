#formation of text data
text<-c("Because I could not stop for Death -",
        "He kindly stopped for me -",
        "The Carriage held but just Ourselves-",
        "and Immortality")
class(text)

#turn it into tidy text dataset
library(dplyr)
(text_df<-data_frame(line=1:4, text=text))

#token is a meaningful unit of text, most often a word, that we are interested in using for further analysis,
#and tokenization is the process of splitting text into tokens.

#tokenization "tidytext"
library(tidytext)
text_df %>% 
  unnest_tokens(word, text)

#text data -(unnest_tokens)- tidy text -(dplyr) - summarized text -(ggplot2)-visualization