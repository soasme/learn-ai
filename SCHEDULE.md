
# Development Task

Continue working on this project.

First read the following files:

-   `GOAL.md`
    
-   `WORKFLOW.md`
    
-   `BOOK.md`
    

Then choose **one of the following tasks**:

1.  Implement a **missing chapter**, or
    
2.  **Simplify an existing chapter** if all chapters are already implemented.
    

----------

# Requirements

All contributions must follow these rules:

-   The code **must run successfully** (`exit_code == 0`) and with one-liner comments per section.
    
-   Prefer **lower LOC** when readability is preserved, while comment lines don't count.
    
-   Maintain **correctness of the original idea/paper**
    
-   Continue the **simplification loop** whenever possible
    
-   Book content must follow the **`examples/microgpt.md` style**
    
-   Training data should be **meaningful and fun**, not synthetic random noise

-   NO math, no latex. It's for engineers who don't read math.

-   Each data showcase, model introduction should come with a mermaid diagram.
    
-   Perform **three rounds of self-review and improvement**
    

----------

# Simplification Loop

For each iteration:

1.  Implement the idea or chapter.
    
2.  Verify the code runs successfully.
    
3.  Reduce LOC while preserving readability.
    
4.  Ensure conceptual correctness.
    
5.  Improve clarity and educational value.
    
6.  Repeat the review process **three times**.
    

----------

# Workflow

When a reasonable iteration is complete:

1.  **Commit your work**
    
2.  **Rebase onto `main`**
    
3.  **Delete the worktree** after the rebase succeeds
    

----------

# Goal

Produce **concise, readable implementations of key ML ideas**, inspired by the style of **microgpt**:

-   Minimal code
    
-   Clear learning signal
    
-   Practical training examples
    
-   Educational clarity
