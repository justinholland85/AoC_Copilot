setwd("C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot/2025/AoC_2025_01")

arguments <- commandArgs(trailingOnly = TRUE)
script_argument <- grep("^--file=", commandArgs(trailingOnly = FALSE), value = TRUE)
script_directory <- if (length(script_argument) > 0) {
  dirname(normalizePath(sub("^--file=", "", script_argument[1]), mustWork = FALSE))
} else {
  getwd()
}

input_path <- if (length(arguments) > 0) {
  arguments[1]
} else {
  file.path(script_directory, "AoC_Input_2025_01_1.txt")
}

if (!file.exists(input_path)) {
  stop("Input file not found: ", input_path)
}

instructions <- trimws(readLines(input_path, warn = FALSE))
instructions <- instructions[nzchar(instructions)]
parsed_instructions <- regmatches(
  instructions,
  regexec("^([LR])([0-9]+)$", instructions)
)

if (any(lengths(parsed_instructions) != 3L)) {
  stop("Input contains an invalid rotation instruction.")
}

position <- 50
part_one <- 0
part_two <- 0

for (instruction in parsed_instructions) {
  direction <- if (instruction[2] == "R") 1 else -1
  distance <- as.numeric(instruction[3])

  first_zero <- if (direction == 1) {
    (100 - position) %% 100
  } else {
    position %% 100
  }
  if (first_zero == 0) {
    first_zero <- 100
  }

  if (distance >= first_zero) {
    part_two <- part_two + 1 + floor((distance - first_zero) / 100)
  }

  position <- (position + direction * distance) %% 100
  if (position == 0) {
    part_one <- part_one + 1
  }
}

cat("Part 1:", part_one, "\n")
cat("Part 2:", part_two, "\n")