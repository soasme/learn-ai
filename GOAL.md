# GOAL.md

## Project Goal

The goal of this project is to create and sell a concise ebook that teaches the fundamentals of modern machine learning—neural networks, deep learning, and transformers—by **implementing important papers and ideas from scratch**.

Instead of long theoretical explanations, each chapter presents a **minimal, fully working implementation** of a core idea from modern ML.

The style follows the spirit of Karpathy’s *microGPT*:
a **single Python file (~200 lines)** containing a complete system that can both train and run inference.

The result is not a framework or tutorial series, but a **collection of elegant, minimal programs** that reveal how modern machine learning actually works.

---

## Learning Philosophy

This project follows strict principles.

### Learn by Implementing

Every concept must be explained through code.

If a concept cannot be implemented clearly in a small program, it should be simplified until it can.

The reader should understand the idea by **reading and running the implementation**.

---

### Minimal Dependencies

Only a very small set of libraries may be used:

* `numpy`
* `pytorch`

No large frameworks, helper libraries, or abstraction layers.

The goal is transparency, not convenience.

---

### Single-File Clarity

Each chapter should ideally contain **one Python file** implementing the full system.

The reader should be able to:

* read the entire implementation in one sitting
* run it immediately
* modify it without friction

---

### Ruthless Simplification

Code must be aggressively simplified while remaining correct.

Every line must justify its existence.

The standard to aim for is **microGPT-level clarity**:
small, elegant, and readable.

Code should be continuously polished until the implementation is:

* concise
* correct
* easy to understand

---

## Implementation Standards

All code in the book must meet strict quality requirements.

### Fully Runnable

Every implementation must run **without errors**.

A reader should be able to:

```bash
python chapter_x.py
```

and immediately see training or inference working.

No broken examples.
No pseudo-code.

---

### Correct Implementations

Every algorithm must **faithfully implement the original paper or method**.

Simplification is allowed, but **the core algorithm must remain correct**.

The goal is not toy approximations, but **faithful minimal implementations**.

---

### Paper-Driven Chapters

Each chapter implements a well-known paper or idea from machine learning.

Examples of suitable references include the set curated in:

https://github.com/pageman/sutskever-30-implementations

These papers serve as **guidance for what ideas to implement**, but **no code may be copied**.

All implementations must be written independently and refined for clarity.

---

### Micro Implementations

Typical chapter implementations should be around:

**100–300 lines of Python**

Small enough to understand quickly, yet complete enough to run.

Examples include implementations of:

* Linear regression with gradient descent
* Backpropagation
* Neural networks
* Word embeddings
* Attention mechanisms
* A minimal **GPT-2 style transformer**

---

## Product

The project delivers a **commercial ebook** sold through a simple website.

The purchasing experience should resemble:

https://felixcraft.ai/

Simple. Direct. One product.

The website provides:

* a landing page explaining the book
* Stripe checkout
* automated ebook delivery via email

Emails are sent using **Resend**.

---

## Repository Structure

The repository contains three main parts.

### 1. Website

A **Next.js application** responsible for:

* marketing pages
* checkout flow
* purchase confirmation
* ebook delivery email

Payments are handled through **Stripe**.
Download emails are sent through **Resend**.

---

### 2. CLI Builder

A small CLI tool responsible for building the ebook.

Responsibilities include:

* assembling chapter content
* validating code examples
* compiling the ebook

---

### 3. Ebook Source

The book content itself.

The ebook is written using:

* **Typst** for typesetting
* **Beautitled** for styling

Each chapter contains:

* explanation text
* a runnable Python implementation
* small experiments or exercises

---

## Design Principles

This project values:

**Clarity over completeness**
**Minimalism over abstraction**
**Understanding over performance**

The goal is not to reproduce production ML systems.

The goal is to **make them understandable**.

Each chapter should feel like opening a carefully crafted machine and seeing exactly how it works.

---

## Outcome

Readers should finish the book able to:

* understand the mechanics behind modern deep learning
* implement core ML algorithms themselves
* read research papers with confidence
* build their own ML systems from scratch

In short:

**From confusion → to clarity → through code.**

