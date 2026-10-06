from pathlib import Path


PROJECT_ROOT = Path("C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot")
PUZZLE_DIRECTORY = PROJECT_ROOT / "2025" / "AoC_2025_03"
EXAMPLE_INPUT = PUZZLE_DIRECTORY / "AoC_2025_03_Input_0.txt"
ACTUAL_INPUT = PUZZLE_DIRECTORY / "AoC_2025_03_Input_1.txt"


def read_banks(input_file: Path) -> list[str]:
    return [
        line.strip()
        for line in input_file.read_text(encoding="utf-8-sig").splitlines()
        if line.strip()
    ]


def maximum_pair_joltage(bank: str) -> int:
    digits = range(9, 0, -1)
    first_positions = {digit: bank.find(str(digit)) for digit in digits}
    last_positions = {digit: bank.rfind(str(digit)) for digit in digits}

    # The first battery must leave at least one battery available after it.
    first_digit = next(
        (
            digit
            for digit in digits
            if first_positions[digit] >= 0
            and first_positions[digit] < len(bank) - 1
        ),
        None,
    )
    if first_digit is None:
        raise ValueError(f"Bank must contain at least two batteries: {bank!r}")

    first_position = first_positions[first_digit]
    second_digit = next(
        (
            digit
            for digit in digits
            if last_positions[digit] > first_position
        ),
        None,
    )
    if second_digit is None:
        raise ValueError(f"Could not select two batteries from bank: {bank!r}")

    return int(f"{first_digit}{second_digit}")


def maximum_joltage_for_count(bank: str, battery_count: int) -> int:
    if battery_count < 1 or battery_count > len(bank):
        raise ValueError(
            f"Cannot select {battery_count} batteries from a bank of {len(bank)}."
        )

    remaining_bank = bank
    selected_digits = []

    for remaining_count in range(battery_count, 0, -1):
        last_start = len(remaining_bank) - remaining_count
        best_digit = max(remaining_bank[: last_start + 1])
        best_position = remaining_bank.index(best_digit)
        selected_digits.append(best_digit)
        remaining_bank = remaining_bank[best_position + 1 :]

    return int("".join(selected_digits))


def part_1(banks: list[str]) -> int:
    return sum(maximum_pair_joltage(bank) for bank in banks)


def part_2(banks: list[str], battery_count: int) -> int:
    return sum(
        maximum_joltage_for_count(bank, battery_count)
        for bank in banks
    )


def main() -> None:
    example_banks = read_banks(EXAMPLE_INPUT)
    actual_banks = read_banks(ACTUAL_INPUT)

    example_part_1 = part_1(example_banks)
    example_part_2 = part_2(example_banks, 12)
    assert example_part_1 == 357, example_part_1
    assert example_part_2 == 3_121_910_778_619, example_part_2

    print(f"Part 1 example: {example_part_1}")
    print(f"Part 1 actual: {part_1(actual_banks)}")
    print(f"Part 2 example: {example_part_2}")
    print(f"Part 2 actual: {part_2(actual_banks, 12)}")


if __name__ == "__main__":
    main()
