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


def maximum_joltage(bank: str, battery_count: int) -> int:
    if battery_count < 1 or battery_count > len(bank):
        raise ValueError(
            f"Cannot select {battery_count} batteries from a bank of {len(bank)}."
        )

    selected = []
    start = 0

    while len(selected) < battery_count:
        remaining = battery_count - len(selected)
        last_start = len(bank) - remaining
        best_index = max(range(start, last_start + 1), key=bank.__getitem__)
        selected.append(bank[best_index])
        start = best_index + 1

    return int("".join(selected))


def total_output_joltage(input_file: Path, battery_count: int) -> int:
    return sum(
        maximum_joltage(bank, battery_count)
        for bank in read_banks(input_file)
    )


def main() -> None:
    expected_example_totals = {
        2: 357,
        12: 3_121_910_778_619,
    }

    for battery_count, expected_total in expected_example_totals.items():
        example_total = total_output_joltage(EXAMPLE_INPUT, battery_count)
        if example_total != expected_total:
            raise AssertionError(
                f"Example with {battery_count} batteries: "
                f"expected {expected_total}, got {example_total}"
            )
        print(f"Part {1 if battery_count == 2 else 2} example: {example_total}")

    for part, battery_count in ((1, 2), (2, 12)):
        actual_total = total_output_joltage(ACTUAL_INPUT, battery_count)
        print(f"Part {part} actual: {actual_total}")


if __name__ == "__main__":
    main()
