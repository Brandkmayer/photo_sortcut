# You can only do this after youve ID all photos that have subjects for the sub folder
library(lubridate)
library(tidyverse)
library(purrr)
library(zoo)# function()

# load in csv with total photos [photolist]
totalphotocsv <- read.csv('F:/cameratraps/riopenasco/upland/RPU_03262019_05092019/RPU_03262019_05092019.csv', header=TRUE, na.strings=c(""," ","NA"))
photolist <- totalphotocsv$ImageFilename

# ENTER NAME OF SORTING LOG
csv <- "Sorting Log - RPU.csv"

# sets working directory to folder of interest and read from photo file path
working_directory <-setwd("C:/Users/Brandonmayer/Dropbox/photo_proc/sorting_log")
photofilepath <- paste(working_directory, csv, collapse = "", sep = "/")
RAW <- read.csv(photofilepath, header=TRUE, na.strings=c(""," ","NA"))

# subsets by filling in NAs (after manually removing all the extra subfolders)
csvfilled <- na.locf(RAW)


# Drop .JPG and convert to date.time 
totalphotolist <- photolist %>% str_replace_all('\\.JPG', '')

fn <- ymd_hms(totalphotolist)
t1 <- ymd_hms(csvfilled[,4])
t2 <- ymd_hms(csvfilled[,5])

finalsortedphotolist <- map2(t1, t2, ~fn[between(fn, .x, .y)])

finalsortedphotolist <- do.call("c", finalsortedphotolist)
finalsortedphotolist <- finalsortedphotolist[!is.na(finalsortedphotolist)]

# return the list to original file names 
finalsortedphotolist <- finalsortedphotolist %>% str_replace_all(c('\\:'= '-', ' ' = '-'))
list_of_photofiles <- c(paste(finalsortedphotolist, ".JPG", sep=""))


# making a new folder to store photos
# sauce for spliting- https://stackoverflow.com/questions/41336606/accessing-element-of-a-split-string-in-r
x <- strsplit(csv, " " )
x4 <- x[[1]][4]
x4 <- gsub("\\..*", "", x4)
photo_folder <- "F:cameratraps/riopenasco/upland"
csv_sorted <- paste(x4, "2019", "analysis", collapse = "", sep = "_")
finalphotofolderpath <- paste(photo_folder, csv_sorted, collapse = "", sep = "/")
# makes the new folder 
# new_dir <- dir.create(finalphotofolderpath)


#____________________________________________________________________________
# sauce: https://stackoverflow.com/questions/34345062/copy-multiple-files-from-multiple-folders-to-a-single-folder-using-r

my_dirs <- list.files("F:cameratraps/riopenasco/upland", pattern = ".JPG", recursive = TRUE, include.dirs = TRUE)
photosubfolders <- paste(photo_folder,my_dirs, sep = "/")

# sauce: https://stackoverflow.com/questions/26439253/how-can-i-copy-files-from-folders-and-subfolders-to-another-folder-in-r
# sauce: https://stackoverflow.com/questions/44000665/select-files-from-a-list-of-files-with-a-pattern
from.dir <- photo_folder
to.dir   <- finalphotofolderpath

# for loop using pattern to reference list of active photos and collect pathways to eventually copy to a single folder. 
df <- photosubfolders
it  <- 0
res <- c()
for(i in list_of_photofiles){
  it  <- it + 1
  res <- append(res, df[grepl(pattern = i, x = df)])
}
res
#copies active photos over
for (f in res) file.copy(from = f, to = to.dir)


