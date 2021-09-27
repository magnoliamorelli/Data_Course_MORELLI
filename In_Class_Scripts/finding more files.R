list.files(recursive = TRUE, full.names = False, pattern = "^b")


creatures <- list.files(path = "Data/data-shell/creatures", full.names = TRUE)
basilisk <- readLines(creatures[1])


basilisk[5:10]
stringr::str_flatten(basilisk[5:10])


