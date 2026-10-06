# AoC 2025 Day 01 solution summary

The solution tracks the dial's position modulo 100. For each rotation, it computes how many clicks are needed to reach zero in that direction; if the rotation reaches that point, it counts the initial zero crossing plus any additional full 100-click revolutions. It then updates the dial position and counts zero-ending rotations separately for Part 1.

The input is parsed as an `L`/`R` direction and a numeric distance. Each rotation takes constant time, including distances spanning many revolutions, so the run time is linear in the number of rotations and uses constant working space.
