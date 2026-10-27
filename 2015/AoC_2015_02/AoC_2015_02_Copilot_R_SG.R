######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# AoC 2015 Day 02
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

source("C:/Users/justi/OneDrive/Documents/GitHub/RLibrary/Start.R")

Root          <- "C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/"
Year          <- 2015
Day           <- 2

Ref           <- paste0("AoC_", Year, "_", Lib.LeadingZeros(Day, 2))
Dir           <- paste0(Root, Year, "/", Ref)

Name.Data.0   <- paste0(Ref, "_Input_0.txt")
Name.Data.1   <- paste0(Ref, "_Input_1.txt")

#====================================================================================================#
# Data
#====================================================================================================#

setwd(Dir)

Data.0        <- readLines(Name.Data.0, warn = FALSE)
Data.1        <- readLines(Name.Data.1, warn = FALSE)


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# F.Part.1
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

# Data       <-  Data.0
# Data       <-  Data.1

F.Part.1     <-  function(Data){

  Split       <- strsplit(Data, "x", fixed = TRUE)

  if (length(Data) == 0 || any(lengths(Split) != 3)) {
    stop("Input must contain three dimensions per present.")
  }

  Dimensions  <- matrix(as.numeric(unlist(Split)), ncol = 3, byrow = TRUE)

  if (anyNA(Dimensions) || any(!is.finite(Dimensions)) ||
      any(Dimensions <= 0) || any(Dimensions != floor(Dimensions))) {
    stop("Present dimensions must be positive integers.")
  }

  Side.Area   <- cbind(Dimensions[, 1] * Dimensions[, 2],
                       Dimensions[, 2] * Dimensions[, 3],
                       Dimensions[, 3] * Dimensions[, 1])

  Paper       <- 2 * rowSums(Side.Area) + apply(Side.Area, 1, min)

  return(sum(Paper))
}

#====================================================================================================#
# Execution
#====================================================================================================#

Answer.0.p1 <- F.Part.1(Data.0)
stopifnot(Answer.0.p1 == 101)
Answer.1.p1 <- F.Part.1(Data.1)

Answer.0.p1
Answer.1.p1


######################################################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\#
# F.Part.2
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/#
######################################################################################################

# Data       <-  Data.0
# Data       <-  Data.1

F.Part.2     <-  function(Data){

  Split       <- strsplit(Data, "x", fixed = TRUE)

  if (length(Data) == 0 || any(lengths(Split) != 3)) {
    stop("Input must contain three dimensions per present.")
  }

  Dimensions  <- matrix(as.numeric(unlist(Split)), ncol = 3, byrow = TRUE)

  if (anyNA(Dimensions) || any(!is.finite(Dimensions)) ||
      any(Dimensions <= 0) || any(Dimensions != floor(Dimensions))) {
    stop("Present dimensions must be positive integers.")
  }

  Ribbon      <- 2 * (rowSums(Dimensions) - apply(Dimensions, 1, max)) +
                  apply(Dimensions, 1, prod)

  return(sum(Ribbon))
}

#====================================================================================================#
# Execution
#====================================================================================================#

Answer.0.p2 <- F.Part.2(Data.0)
stopifnot(Answer.0.p2 == 48)
Answer.1.p2 <- F.Part.2(Data.1)

Answer.0.p2
Answer.1.p2
