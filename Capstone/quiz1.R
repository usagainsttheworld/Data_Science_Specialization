#Quiz 1
#Question 1
#The en_US.blogs.txt file is how many megabytes?
file.info("/Users/ling/Desktop/Data_Science/Capstone/en_US/en_US.blogs.txt")$size / 1024^2

#Question 2
#The en_US.twitter.txt has how many lines of text?
blogs <- readLines("/Users/ling/Desktop/Data_Science/Capstone/en_US/en_US.blogs.txt")
news <- readLines("/Users/ling/Desktop/Data_Science/Capstone/en_US/en_US.news.txt")
twitter <- readLines("/Users/ling/Desktop/Data_Science/Capstone/en_US/en_US.twitter.txt")
length(twitter)

#Question 3
#What is the length of the longest line seen in any of the three en_US data sets?
max(nchar(blogs))
max(nchar(news))
max(nchar(twitter))

#Question 4
#In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?
love_count <- sum(grepl("love", twitter))
hate_count <- sum(grepl("hate", twitter))
love_count / hate_count

#Question 5
#The one tweet in the en_US twitter data set that matches the word "biostats" says what?
biostats <- grep("biostats", twitter)
twitter[biostats]

#Question 6
#How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)
sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twitter))