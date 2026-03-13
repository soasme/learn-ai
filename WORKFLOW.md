# BOOK_WORKFLOW.md

This workflow defines how to build the book as a sequence of small, testable implementation experiments.

The goal is not just to finish chapters.  
The goal is to produce **correct, runnable, minimal implementations** of important ML papers and ideas, written at a level of clarity comparable to `microgpt`.

Each chapter is treated like an experiment loop:
- choose a paper or core idea
- implement it in one small Python file
- verify correctness
- simplify aggressively
- keep only changes that improve clarity without breaking correctness

---

## Core Goal

For each chapter, produce:

1. a **faithful implementation** of the paper or method
2. code that runs **without errors**
3. code that is **small enough to read in one sitting**
4. code that is **polished until unnecessary complexity is removed**
5. accompanying text that explains the idea through the implementation

The final book should feel like a collection of tiny, elegant machines.

---

## Scope

The repository has three parts:

1. **nextjs app**  
   Landing page, Stripe checkout, Resend delivery, customer flow.

2. **cli app**  
   Compiles book content and code into the final ebook.

3. **ebook content**  
   Chapters, explanations, and minimal runnable implementations.

This workflow focuses primarily on the **ebook content** and the **chapter implementation loop**.

---

## Chapter Standard

Each chapter should aim for:

- one idea or paper
- one main Python file
- roughly **100–300 lines**
- minimal dependencies
- direct train and/or inference path
- no pseudo-code
- no hidden helpers
- no framework-like abstractions

Allowed packages should remain very limited, typically:
- `numpy`
- `torch`

A chapter is only considered done when the code is:
- correct
- runnable
- simplified
- readable

---

## What You Can Change

Inside a chapter implementation, you may change:

- model structure
- tensor layout
- naming
- training loop
- inference path
- helper functions
- comments
- organization within the single file

You should simplify freely.

---

## What You Must Not Do

Do not:

- add unnecessary dependencies
- split logic across many files unless absolutely required
- hide core logic in utility layers
- keep code that is clever but hard to read
- include approximations that break the paper’s core method
- leave examples untested

Do not steal code from other repositories.

Reference implementations and paper lists may be used for **choosing what to implement** and for understanding the method, but the code in this project must be written independently.

---

## Success Criteria

A chapter implementation is successful when all of the following are true:

### 1. Correctness

The code implements the method faithfully.

Simplification is allowed, but the core algorithm must still be true to the paper.

### 2. Runnability

The file runs without errors.

Typical commands should work cleanly, for example:

```bash
python chapter_x.py
echo $?
```

The expected exit_code is:

0


### 3. Minimalism

The implementation should be short enough to understand quickly.

Use **LOC as a pressure signal**, not as the only metric:

-   fewer lines is usually better
    
-   but not if readability gets worse
    
-   and not if correctness is damaged
    

### 4. Readability

A reader should be able to:

-   open the file
    
-   read top to bottom
    
-   understand the whole system
    
-   modify it safely
    

### 5. Book Quality

The code should be worthy of publication in a paid ebook.

Not merely working.  
Not merely compact.  
It should feel carefully shaped.

----------

## Metrics

When iterating on a chapter, use these gauges:

### Hard gates

-   `exit_code == 0`
    
-   train path runs
    
-   inference path runs
    
-   no broken imports
    
-   no missing files
    
-   no hidden setup traps
    

### Quality gauges

-   **LOC**: does the file get shorter without becoming worse?
    
-   **surface area**: fewer helpers, fewer branches, fewer concepts
    
-   **dependency count**: lower is better
    
-   **mental load**: how much must a reader hold in their head?
    
-   **paper fidelity**: is the important idea still intact?
    
-   **example quality**: does the output actually demonstrate the method?
    

### Simplification wins

Good simplification includes:

-   deleting glue code
    
-   removing unnecessary abstractions
    
-   merging trivial helpers back into the main flow
    
-   replacing generic patterns with direct code
    
-   reducing configuration that adds no learning value
    
-   shortening variable lifetimes
    
-   making tensor shapes easier to follow
    

A LOC reduction that preserves correctness is usually a win.

A LOC increase is acceptable only if it clearly improves:

-   correctness
    
-   paper fidelity
    
-   readability
    

----------

## Per-Chapter Workflow

For every chapter, follow this loop.

### 1. Choose the target

Select one paper, method, or canonical idea.

Write down:

-   what the reader is supposed to learn
    
-   what the minimal runnable artifact is
    
-   what must be included for the implementation to still be faithful
    

### 2. Write the first complete version

Build a full runnable implementation first.

Do not optimize for elegance too early.  
Get the whole system working end to end:

-   data or toy data
    
-   model
    
-   loss
    
-   optimization if needed
    
-   inference or output demo
    

### 3. Verify the chapter runs

Run the file directly.

Examples:

python chapters/gpt2.py  
echo  $?

Record:

-   whether it ran
    
-   whether training worked
    
-   whether inference worked
    
-   whether the output looks sensible
    

If `exit_code != 0`, fix that first.

### 4. Check paper fidelity

Before simplifying further, verify:

-   the algorithm is still correct
    
-   key equations or mechanics are present
    
-   nothing essential has been replaced by a shortcut that changes the method
    

If the chapter is wrong, simplification does not matter.

### 5. Simplify ruthlessly

Now polish the file.

Ask, line by line:

-   does this line earn its place?
    
-   can two helpers become one?
    
-   can this abstraction be inlined?
    
-   can naming be made more obvious?
    
-   can a generic pattern become direct code?
    
-   can comments replace ceremony?
    
-   can a reader understand this faster?
    

Use LOC as one gauge:

-   count rough total lines
    
-   compare before/after
    
-   prefer smaller code if equally correct and readable
    

### 6. Re-run after every meaningful simplification

Every non-trivial simplification must be followed by a rerun.

Examples:

python chapters/gpt2.py > run.log 2>&1  
echo  $?  
tail -n  20 run.log

If the file crashes, revert or fix.

### 7. Decide: keep or discard

Keep a change if it improves at least one of:

-   clarity
    
-   concision
    
-   correctness
    
-   faithfulness
    
-   ease of reading
    

Discard a change if it:

-   makes the code harder to read
    
-   saves little LOC but increases confusion
    
-   introduces fragile tricks
    
-   weakens the paper implementation
    
-   breaks the runnable guarantee
    

### 8. Write the chapter text

After the implementation stabilizes, write the text around the code:

-   what problem this method solves
    
-   the minimum theory needed
    
-   how the implementation maps to the idea
    
-   what to inspect in the code
    
-   what the reader should try changing
    

The text should support the code, not overshadow it.

### 9. Compile the book

Use the CLI to compile the ebook and verify:

-   code snippets render correctly
    
-   formatting is clean
    
-   typography works
    
-   chapter order makes sense
    
-   references and titles are correct
    

### 10. Final review

Before marking a chapter done, ask:

-   Does it run?
    
-   Is it correct?
    
-   Is it small?
    
-   Is it readable?
    
-   Is it worth paying for?
    

If not, continue polishing.

----------

## Simplification Loop

For code polishing, use this loop repeatedly:

1.  read the file top to bottom
    
2.  identify the ugliest or least necessary part
    
3.  simplify one thing
    
4.  run the file
    
5.  check `exit_code`
    
6.  compare LOC and readability
    
7.  keep or revert
    

This loop is the heart of the project.

----------

## Suggested Chapter Log Format

For each chapter, keep a simple internal log like:

chapter	status	loc	exit_code	description  
gpt2	draft	238	0	first runnable transformer  
gpt2	keep	221	0	inline attention helper  
gpt2	keep	208	0	remove config wrapper  
gpt2	discard	196	1	over-simplified masking logic, broke run

Suggested columns:

-   `chapter`
    
-   `status` (`keep`, `discard`, `crash`, `done`)
    
-   `loc`
    
-   `exit_code`
    
-   `description`
    

This is not for the reader.  
It is for maintaining discipline during polishing.

----------

## Definition of Done

A chapter is done when:

-   the implementation is faithful
    
-   the file runs with `exit_code == 0`
    
-   train and/or inference path works
    
-   the code has been simplified multiple times
    
-   unnecessary lines are removed
    
-   the text clearly explains the implementation
    
-   the chapter compiles cleanly into the ebook
    

----------

## Project Principle

This is not a code golf project.  
This is not a benchmark repo.  
This is not a teaching framework.

This is a book of **small, correct, beautiful implementations**.

The standard is:

-   as small as possible
    
-   as correct as necessary
    
-   as readable as possible
    

When in doubt, remove complexity.  
When in doubt, re-run the file.  
When in doubt, prefer code a reader can fully understand.

  
I can also turn this into a slightly more opinionated version with sections like `Chapter Acceptance Checklist` and `Review Rubric` if you want it to feel more like an actual repo policy doc.
