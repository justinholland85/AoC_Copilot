from pathlib import Path


PROJECT_ROOT = Path("C:/Users/justi/OneDrive/Documents/GitHub/AoC_Copilot")
PUZZLE_DIRECTORY = PROJECT_ROOT / "2025" / "AoC_2025_02"
EXAMPLE_INPUT = PUZZLE_DIRECTORY / "AoC_2025_02_Input_0.txt"
ACTUAL_INPUT = PUZZLE_DIRECTORY / "AoC_2025_02_Input_1.txt"


def parse_ranges(input_file: Path) -> list[tuple[int, int]]:
    text = input_file.read_text(encoding="utf-8-sig").replace("\n", "")
    ranges = []
    for raw_range in text.split(","):
        raw_range = raw_range.strip()
        if not raw_range:
            continue
        start_text, end_text = raw_range.split("-")
        ranges.append((int(start_text), int(end_text)))
    return ranges


def is_invalid_id(value: int, *, require_exactly_two_repeats: bool) -> bool:
    text = str(value)
    if len(text) < 2:
        return False

    limit = len(text) // 2
    for repeat_length in range(1, limit + 1):
        if len(text) % repeat_length != 0:
            continue
        repetition_count = len(text) // repeat_length
        if repetition_count < 2:
            continue
        if require_exactly_two_repeats and repetition_count != 2:
            continue
        if text == text[:repeat_length] * repetition_count:
            return True
    return False


def sum_invalid_ids(input_file: Path, *, require_exactly_two_repeats: bool) -> int:
    total = 0
    for start, end in parse_ranges(input_file):
        for value in range(start, end + 1):
            if is_invalid_id(value, require_exactly_two_repeats=require_exactly_two_repeats):
                total += value
    return total


def main() -> None:
    expected_example_totals = {
        True: 1227775554,
        False: 4174379265,
    }

    for require_exactly_two_repeats, expected_total in expected_example_totals.items():
        example_total = sum_invalid_ids(
            EXAMPLE_INPUT,
            require_exactly_two_repeats=require_exactly_two_repeats,
        )
        if example_total != expected_total:
            raise AssertionError(
                f"Example with require_exactly_two_repeats={require_exactly_two_repeats}: "
                f"expected {expected_total}, got {example_total}"
            )
        part_number = 1 if require_exactly_two_repeats else 2
        print(f"Part {part_number} example: {example_total}")

    for part_number, require_exactly_two_repeats in ((1, True), (2, False)):
        actual_total = sum_invalid_ids(
            ACTUAL_INPUT,
            require_exactly_two_repeats=require_exactly_two_repeats,
        )
        print(f"Part {part_number} actual: {actual_total}")


if __name__ == "__main__":
    main()
