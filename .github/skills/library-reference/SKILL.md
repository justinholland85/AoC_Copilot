Build the Justin R Library Reference

Objective

Create and maintain a focused reference that teaches an AI coding agent how to use relevant functions from my personal R library when writing Advent of Code solutions.

The reference is intended primarily for the agent's own use when solving future problems. It should help the agent recognise functions I already use, understand what they do, identify appropriate use cases, and avoid reinventing functionality that already exists.

The central principle is:

Start with functions demonstrated in my existing Advent of Code R solutions. Expand selectively to closely related functions in my library when they offer a clear, relevant alternative. Do not attempt to use my entire library.

Scope and constraints

1. Source material

Use the local project and repository access available through the project instructions.

Identify local Advent of Code R solution files matching AoC_<Year>_<Day>_Code_R, including their file extensions.

Identify and inspect the local R library and its functions.

Use the repository and library locations defined by the project instructions rather than hard-coding unverified paths.

Do not modify original Advent of Code solutions or library source files.

Do not retrieve unrelated material from the internet.

The library contains functions for many different activities. Most are irrelevant to Advent of Code and should not appear in the reference.

2. Scope of function discovery

Use two levels of discovery.

Level 1 — Functions actually used in AoC solutions

Search all locally available R solution files matching the naming convention.

Identify every function call whose name begins with Lib.. Record the exact function names and locate their definitions in the personal library.

These functions form the primary set for analysis.

Level 2 — Closely related library functions

For each relevant function identified at Level 1, inspect the surrounding library and search for other functions that perform similar or analogous tasks.

Include a related function only when there is a clear, plausible Advent of Code use case.

For example, if the AoC solutions use Lib.NA.To.Zero, investigate whether the library also contains Lib.NA.To.Val and whether it provides a related way of replacing missing values with a specified value.

The purpose is to recognise useful alternatives that already exist, not to introduce unfamiliar functions indiscriminately.

Do not catalogue unrelated plotting helpers, reporting utilities, application-specific functions or other library functionality that has no credible relevance to typical AoC problems.

Procedure

1. Discover the AoC R solutions

Scan all available local project files for names matching:

AoC_<Year>_<Day>_Code_R

Use the year and day to identify each solution.

Inspect the actual source code rather than relying on search results alone.

If a solution is unavailable or cannot be read, record the limitation and continue with the remaining files.

2. Identify all Lib. function calls

Search the complete collection of AoC R solutions for function calls beginning with Lib..

Create a deduplicated inventory of the functions used.

For each function, record:

Exact function name.

The AoC solutions in which it appears.

The surrounding code and context of use.

The operation it performs in that context.

The input types, arguments and return value where these can be established.

Any assumptions, edge cases or important behavioural details.

Distinguish between a function's general purpose and the specific way it is used in the AoC solutions.

Do not infer a function's behaviour from its name alone.

3. Locate and inspect function definitions

For every identified function, locate its actual definition in the local library.

Read the implementation and any relevant documentation, examples or tests available locally.

Establish, where possible:

What the function does.

Its formal arguments and defaults.

Accepted input types and expected structure.

Its return value and type.

How it handles missing values and unusual inputs.

Whether it performs validation, conversion or other side effects.

Any important limitations or dependencies.

Whether its behaviour differs from what its name might suggest.

If the definition cannot be located or its behaviour cannot be established, record that uncertainty. Do not invent a definition or claim unsupported behaviour.

4. Determine appropriate use cases

For each function, explain when an AoC-solving agent should consider using it.

Base this explanation on the implementation and actual examples, not merely the function name.

Describe:

The type of problem it helps solve.

The circumstances in which it is appropriate.

The kind of input it expects.

What it returns and how the result can be used.

Any conditions under which it should not be used.

Where useful, include a short example drawn from the existing AoC solutions.

The aim is to help an agent recognise opportunities to use an established function when a similar need arises in a new puzzle.

Do not force a function into a solution simply because it is documented in the reference.

5. Discover closely related functions

After documenting the functions already used in AoC, inspect the library for related functionality.

Search for functions that are analogous in purpose, operate on similar inputs, or provide a useful variation on an established operation.

Examples of relationships worth investigating include:

Replacing missing values with zero versus replacing them with a specified value.

Converting or normalising values using related conversion functions.

Counting or tabulating values using related helpers.

Performing related forms of matching, lookup, indexing or name conversion.

Closely related string or data manipulation helpers.

These are examples of possible relationships, not a requirement to find a function for every category.

For each candidate:

Inspect its actual definition.

Establish how it differs from the function already used.

Determine whether the difference offers a plausible benefit in an AoC context.

Record the relationship to the established function.

Include it only if the relationship and potential use are clear.

Do not include functions simply because their names look similar.

Do not introduce whole new areas of the library without a clear connection to functions already demonstrated in AoC solutions.

6. Distinguish established functions from related alternatives

The reference must clearly distinguish between two categories.

Established AoC functions

Functions actually called in the existing AoC R solutions. These are the strongest evidence of how I use my library.

Related library alternatives

Functions found in the library that have not been observed in the AoC solutions but are sufficiently analogous to warrant consideration.

For related alternatives, explicitly state that they have been identified from their definitions rather than demonstrated in an AoC solution.

Do not present an untested alternative as an established practice.

Where a related function is included, explain its relationship to the established function and the circumstances in which it might be preferable.

The reference should not encourage an agent to prefer a new library function automatically over a straightforward, established implementation.

7. Create or update the library reference

Create or maintain this file in the project root:

Justin_R_Library_Reference.md

Organise it by functional purpose rather than by the order in which functions were discovered.

Use a structure such as:

Missing-value handling.

Type conversion and normalisation.

Counting and tabulation.

Matching, lookup and indexing.

String manipulation.

Other relevant categories discovered during analysis.

Only create categories for functionality that is genuinely relevant.

For each function, include the following where applicable:

Function: Exact name.

Status: Used in AoC solutions, or related alternative not yet observed in AoC.

Purpose: What the function actually does.

Usage evidence: The year/day and context in which it is used, if applicable.

Arguments and return value: Established behaviour based on the definition.

When to use it: Practical guidance for an AoC-solving agent.

Example: A short example based on actual code or, where clearly labelled, a verified illustrative example.

Related functions: Relevant alternatives and their differences.

Limitations: Important assumptions, edge cases or uncertainties.

Avoid repeating the same explanation across multiple entries. Cross-reference related functions where appropriate.

8. Maintain the reference over time

If the reference already exists, read it before making changes.

Preserve useful, verified information.

Add newly discovered functions and use cases.

Update entries when the underlying definitions or evidence warrant it.

Consolidate duplicate explanations.

Recheck claims against the current source code.

Clearly distinguish established functions from newly identified alternatives.

Remove or qualify unsupported claims.

Do not expand the reference simply to increase its function count.

The objective is a compact, trustworthy guide to the subset of the library that an AoC-solving agent is likely to need.

9. Record source coverage

At the bottom of the reference, maintain a section titled Source material analysed.

Record:

The AoC R solution files inspected.

The library source files containing definitions that were inspected.

Any relevant documentation or tests used to establish behaviour.

Distinguish between files discovered and files actually inspected.

Do not claim to have analysed the entire library if only selected files or functions were examined.

Quality requirements

Before finishing, verify that:

All Lib. functions used in the available AoC R solutions have been identified.

Each identified function has been checked against its actual definition where available.

Function behaviour is not inferred from names alone.

Related functions are included selectively and have a clear connection to established functions.

Established usage is distinguished from proposed alternatives.

Examples accurately reflect the function definitions and actual usage.

The reference focuses on credible AoC use cases.

Unrelated library functionality has been excluded.

Source references are accurate.

No original solution or library files have been modified.

Final report

After creating or updating the reference, report:

The number of AoC R solutions inspected.

The number of distinct Lib. functions found in those solutions.

The number of function definitions successfully inspected.

The number of related alternatives identified.

Any functions whose definitions could not be located or verified.

The main functional categories covered.

The location of the updated reference.

Do not claim that a function was inspected, verified or tested unless that actually occurred.