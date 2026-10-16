Build the Justin R Style Guide

Objective

Build and maintain a detailed, practical reference describing how I actually write R code, based on systematic analysis of my existing Advent of Code R solutions.

The guide is intended for an AI coding agent to consult when writing new R code in my style.

The primary task is to discover specific patterns, techniques, conventions and implementation choices in my code. Only after identifying those patterns should the agent infer broader preferences and formulate instructions for future coding.

The guide must be grounded in my actual code. Generic programming advice, a restatement of the task instructions, or a general essay about readable code is not an acceptable result.

Scope and constraints

Local material only

Use local project files only.

Do not access GitHub or remote repositories.

Do not use GitHub MCP or other tools to retrieve additional material.

Do not retrieve puzzle descriptions, inputs or solutions from the internet.

Do not modify original solution files.

Source files

Analyse every locally available R solution matching:

AoC_<Year>_<Day>_Code_R

The filenames include their appropriate extensions.

For each solution, look for these corresponding local files:

AoC_<Year>_<Day>_Instructions.txt

AoC_<Year>_<Day>_Input_1.txt

Use the actual year and day to match files. Do not require a corresponding Python solution.

Instructions and inputs are supporting context. If either is unavailable, continue analysing the R solution without attempting to retrieve the missing file.

Procedure

1. Discover and read the source material

Scan the local project for all matching R solution files.

For every solution:

Read the complete R script.

Locate and read its corresponding instructions file if available.

Inspect its input file if available, to understand the data structure and scale.

Record which files were actually inspected.

Do not base conclusions on filenames, short snippets or assumptions about what the code probably does.

Analyse the collection as a whole, but retain enough detail to identify the specific implementation choices made in individual solutions.

2. Extract concrete coding patterns before forming conclusions

First, build an inventory of specific techniques and implementation patterns found in the code.

Look for actual examples of:

Input reading and parsing.

String splitting and manipulation.

Type conversion.

Vector creation and transformation.

Indexing, subsetting and logical conditions.

Matching, lookup and membership operations.

Counting, tabulation and frequency calculations.

Sorting and deduplication.

Matrix, array, list and data-frame usage.

Vectorisation and explicit iteration.

Intermediate variables and multi-step calculations.

Variable and object naming conventions.

Function definitions and helper functions.

Handling of missing values and dimensions.

Random-number generation, where applicable.

Algorithm implementation and state updates.

Comments, validation and output organisation.

Other recurring or distinctive techniques discovered in the solutions.

This is a discovery list, not a checklist that must be filled. Do not claim that a pattern exists merely because it is a common R technique.

For each potentially useful pattern, record:

The specific operation or coding choice.

A representative example from the actual code.

The file and year/day in which it occurs.

Other occurrences, if found.

Any relevant context needed to understand the choice.

Prefer distinctive, reusable patterns over trivial observations such as the use of assignment operators.

3. Examine how techniques are implemented

Do not stop at identifying which functions appear in the code. Examine how and why they are used.

For each significant pattern, investigate questions such as:

What problem does this technique solve?

How is the operation expressed in the code?

Is the calculation broken into several named steps or combined into one expression?

Which intermediate objects are created and why?

How are indices, dimensions and types handled?

What assumptions does the implementation make?

Does the same technique recur in different problems?

Does the implementation appear to favour clarity, compactness, performance or some combination?

Does the surrounding code provide evidence for that interpretation?

Use the instructions and input files to distinguish choices driven by a particular problem from choices that may reflect a general preference.

Do not invent motivations. If the reason for a choice cannot be established from the code and context, describe the choice without claiming to know why it was made.

4. Analyse naming conventions in detail

Naming conventions are an important part of the style guide. Do not treat them as a superficial formatting issue.

My general naming preference is Upper Camel Case. Examine the actual code to establish how consistently this is applied, including variable names, intermediate objects and other identifiers.

Investigate the use of periods (.) and underscores (_) within names.

I do not have a rigid rule for choosing between these separators. Their use is context-dependent, and they can represent different kinds of breaks within an object name. The purpose of the analysis is to discover the conventions reflected in my code, not to invent an arbitrary rule.

Specifically:

Collect representative object names from the available solutions.

Identify recurring uses of periods and underscores.

Examine the role of each separator within the name.

Look for patterns in how names represent concepts, components, stages, categories or relationships.

Compare similar names across different solutions to identify consistent distinctions.

Record exceptions and ambiguous cases.

For example, investigate whether a period tends to separate conceptual components of a name while an underscore separates words within a component. Treat this as a hypothesis to test against the actual code, not as an established rule.

The resulting guide should include concrete examples of both separators and explain the patterns they appear to express.

Where the evidence supports a distinction, turn it into actionable guidance for naming new objects. Where the pattern is ambiguous or inconsistent, state that explicitly and avoid false precision.

The goal is to help a future coding agent make naming choices that resemble mine, including reasonable contextual judgements when no hard-and-fast rule exists.

5. Compare examples across solutions

Look for recurring patterns and meaningful variations across the collection.

Distinguish between:

Repeated practice: The same or similar technique appears in several solutions.

Distinctive practice: A particular implementation choice is notable, even if it appears in only one solution.

Problem-specific choice: A technique appears to be required or especially convenient for one particular problem.

Variation: Similar problems are solved using different techniques.

Potential inconsistency: Different solutions handle a similar task differently, without enough evidence to establish a preferred approach.

Do not force all examples into a single rule. Differences may reflect problem requirements, evolving habits or experimentation.

When a technique appears only once, do not present it as an established general preference. It may still be worth documenting as a useful example.

6. Use input size to assess implementation choices

Where inputs are available, consider their actual size and structure when examining algorithmic choices.

Record relevant observations about:

Number of records or values.

Dimensions of matrices or grids.

Number of iterations or operations.

Computational complexity.

Whether a more elaborate implementation appears warranted for the workload.

Use this evidence to understand how implementation complexity relates to problem scale.

Do not assume that an implementation is good or bad simply because it is optimised or unoptimised. The objective is to identify my actual choices and, where supported by evidence, infer my approach to performance.

In particular, investigate whether my solutions tend to favour straightforward, understandable implementations when the problem is small enough that additional optimisation would provide little practical benefit.

Do not turn this hypothesis into a claimed preference unless the code supports it.

7. Separate observations, inferences and instructions

This separation is mandatory.

For every substantive conclusion, distinguish between three levels.

A. Observed practice

Describe what the code actually does.

Include a concrete example, the exact source filename, and a year/day reference. Where helpful, quote a short expression or show a small code excerpt.

B. Inferred preference

Explain what the observed practice might suggest about my programming preferences.

State how many examples support the inference where practical. Qualify conclusions based on limited evidence.

C. Instruction for the coding agent

Translate a sufficiently supported preference into an actionable instruction for writing future R code.

Do not automatically create an instruction from every observation. Some observations are simply useful examples, and some differences are problem-specific.

Never present an inference as an observed fact.

8. Create or update the style guide

Create or maintain this file in the project root:

Justin_R_Style_Guide.md

The document should be a technical reference for an AI coding agent, grounded in the source analysis.

Organise it around actual patterns discovered in the code. Suitable sections may include:

Core programming philosophy.

Naming conventions, including Upper Camel Case and the contextual use of . and _.

Code organisation and intermediate variables.

Input parsing and data preparation.

Common R operations and idioms.

Indexing, matching and lookup.

Vectorisation and iteration.

Data structures and intermediate objects.

Algorithm implementation.

Performance and problem scale.

Correctness and transparency.

Instructions for writing new R code in my style.

Adapt the organisation to the findings. Do not fill sections with generic advice merely to complete a template.

For each significant pattern, include the relevant material from the following structure where appropriate:

Pattern: A specific coding technique or convention.

Observed example: A short example taken from my code, with a source reference.

Evidence across solutions: Other examples or relevant variations.

Interpretation: What the pattern suggests, with appropriate qualification.

Guidance for new code: A concrete instruction, only where justified.

Exceptions and caveats: Circumstances in which the instruction may not apply.

Not every pattern needs every subsection. Keep the guide useful and avoid unnecessary repetition.

Include specific R function names, idioms, naming examples and coding choices wherever the evidence supports them. Do not replace these with vague statements about writing clean, efficient or maintainable code.

9. Maintain the guide over time

If the guide already exists, read it before updating it.

Preserve useful, evidence-based content.

Add newly discovered patterns.

Consolidate repeated explanations.

Update conclusions when additional examples strengthen, weaken or contradict them.

Remove unsupported claims or clearly qualify them.

Do not turn an isolated example into a universal rule.

Do not silently change an observation into a stronger claim.

Keep source references accurate.

The guide should become more specific and better supported as more solutions are analysed, rather than merely growing longer.

10. Record the source material

At the bottom of the guide, maintain a section titled Source material analysed.

List the actual R solution files inspected, grouped by year and day.

For each solution, list the corresponding instructions and input files that were actually inspected, where available.

Distinguish between files discovered and files read.

The inventory should reflect the current analysis. Do not claim that files were inspected when they were merely found.

Preserve historical, useful coding observations even if a source file is subsequently removed. The inventory records the current evidence base; the guide remains a cumulative reference.

Quality requirements

Before finishing, check that:

The guide contains concrete patterns from the actual R code.

Substantive observations have accurate source references.

Inferences are clearly distinguished from observed practices.

Instructions are derived from evidence rather than supplied assumptions.

Specific R techniques are documented rather than replaced by generic advice.

Upper Camel Case and the contextual use of periods and underscores have been explicitly examined.

Naming guidance reflects observed patterns without inventing rigid rules.

Input size and algorithmic complexity are considered where relevant.

Contradictory examples and uncertainty are acknowledged.

The guide is useful to an agent deciding how to implement a new problem in R.

The source inventory reflects the files actually inspected.

No original solution files have been modified.

A guide that consists mainly of general principles such as readability, simplicity and appropriate optimisation has failed this task, even if those principles are sensible.

Final report

After creating or updating the guide, report:

The number of R solutions inspected.

The year/day range covered.

The main specific coding patterns discovered.

Examples of preferences that are strongly supported by repeated evidence.

The naming conventions discovered, including evidence for the use of . and _.

Any notable variations or conflicting evidence.

Any missing instructions or inputs that limited the analysis.

The location of the updated guide.

Summarise concrete findings, not just broad programming principles. Do not claim that files were inspected or changes were completed unless they actually were.