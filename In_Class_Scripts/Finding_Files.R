csv_files <- list.files(pattern = ".csv", path = "Data",
                        full.names = TRUE, recursive = TRUE)


csv_files

wingspan_data_file <- "Data/wingspan_vs_mass.csv"
csv_files[140]


wingspan <- read.csv(csv_files[140])


list.files(pattern = ".fastq", path = "Data")
fastq_files <- list.files(pattern = ".fastq", path = "Data",full.names = TRUE)

fastq_files[2]
readLines(fastq_files[2])

small.Fungi <- readLines(fastq_files[2])
small.Fungi

read.csv("./Data/Soil_Predators.csv")
read.csv("./Data/Utah_Religions_by_County.csv")
read.csv("./Data/US_Biome_Diversity.tsv")
read.csv("./Data/nyc_license.csv")

Mushroom_files <- list.files(pattern = "*mush.t*", path = "Data",
           full.names = TRUE, recursive = TRUE)

read.csv("./Data/GradSchool_Admissions.csv")
list.files("Data")
list.files(path = "Data", pattern = "txt", full.names = TRUE, recursive = TRUE)
animal_files <- readLines("./Data/data-shell/data/animal-counts/animals.txt")
readLines(animal_files)
read.csv(animal_files)
readLines('animal_files')
animal_files
readLines(animal_files[3])

animal_files

animal_files[3]
fastq_files





list.files(path = "Data", pattern = "csv", full.names = TRUE, recursive = TRUE)
ants <- read.csv("./Data/thatch_ant.csv")
list.dirs(path = "Data", full.names = TRUE, recursive = TRUE)

readLines("./Data/data-shell/writing/thesis")





list.files(recursive = TRUE, full.names = False, pattern = "^b")


creatures <- list.files(path = "Data/data-shell/creatures", full.names = TRUE)
basilisk <- readLines(creatures[1])


basilisk[5:10]
stringr::str_flatten(basilisk[5:10])

