######################################################################################################
# AoC 2025 Day 02
######################################################################################################

source("C:/Users/justi/OneDrive/Documents/GitHub/RLibrary/Start.R")

Root          <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/"
Year          <- 2025
Day           <- 2

Ref           <- paste0("AoC_", Year, "_", Lib.LeadingZeros(Day, 2))
Dir           <- paste0(Root, Year, "/", Ref)

Name.Data.0   <- paste0(Ref, "_Input_0.txt")
Name.Data.1   <- paste0(Ref, "_Input_1.txt")

setwd(Dir)

Data.0        <- readLines(Name.Data.0, warn = FALSE)
Data.1        <- readLines(Name.Data.1, warn = FALSE)


F.Parse.Ranges <- function(Data) {

  Range.Text   <- unlist(strsplit(paste(Data, collapse = ""), ",", fixed = TRUE))
  Range.Parts  <- strsplit(Range.Text, "-", fixed = TRUE)

  if (length(Range.Text) == 0 || any(lengths(Range.Parts) != 2)) {
    stop("Input contains a range that is not formatted as start-end.")
  }

  Bounds       <- do.call(rbind, Range.Parts)
  Bounds       <- matrix(as.numeric(Bounds), ncol = 2)

  if (anyNA(Bounds) || any(Bounds[, 1] > Bounds[, 2])) {
    stop("Input contains a range with invalid or reversed bounds.")
  }

  return(Bounds)
}


F.Invalid.IDs <- function(Max.Digits, Part) {

  Invalid.IDs  <- numeric()

  for (Block.Length in seq_len(floor(Max.Digits / 2))) {

    Blocks      <- as.character(seq(10^(Block.Length - 1), 10^Block.Length - 1))

    if (Part == 1) {
      Repeat.Count <- 2
    } else {
      Repeat.Count <- seq(2, floor(Max.Digits / Block.Length))
    }

    for (N.Repeats in Repeat.Count) {
      Invalid.IDs <- c(Invalid.IDs,
                       as.numeric(do.call(paste0, rep(list(Blocks), N.Repeats))))
    }
  }

  return(unique(Invalid.IDs))
}


F.Sum.Invalid.IDs <- function(Data, Part) {

  Ranges       <- F.Parse.Ranges(Data)
  Max.Digits   <- max(nchar(as.character(Ranges)))
  Invalid.IDs  <- F.Invalid.IDs(Max.Digits, Part)
  IDs.In.Ranges <- numeric()

  for (Range.Index in seq_len(nrow(Ranges))) {
    IDs.In.Ranges <- c(IDs.In.Ranges,
                       Invalid.IDs[Invalid.IDs >= Ranges[Range.Index, 1] &
                                     Invalid.IDs <= Ranges[Range.Index, 2]])
  }

  return(sum(unique(IDs.In.Ranges)))
}


F.Part.1 <- function(Data) {

  return(F.Sum.Invalid.IDs(Data, 1))
}


F.Part.2 <- function(Data) {

  return(F.Sum.Invalid.IDs(Data, 2))
}


######################################################################################################
# Part 1
######################################################################################################

Answer.0.p1 <- F.Part.1(Data.0)
stopifnot(Answer.0.p1 == 1227775554)
Answer.1.p1 <- F.Part.1(Data.1)

cat("Part 1 example:", Answer.0.p1, "\n")
cat("Part 1 actual:", Answer.1.p1, "\n")


######################################################################################################
# Part 2
######################################################################################################

Answer.0.p2 <- F.Part.2(Data.0)
stopifnot(Answer.0.p2 == 4174379265)
Answer.1.p2 <- F.Part.2(Data.1)

cat("Part 2 example:", Answer.0.p2, "\n")
cat("Part 2 actual:", Answer.1.p2, "\n")
