# BOOK.md

## Title

Tiny AI Programs

Subtitle:  
Understand Modern AI with Diagrams and Tiny Python Scripts

---

## Book Philosophy

Modern AI systems often look complicated.

But most breakthroughs hide simple ideas.

This book reveals those ideas through **tiny runnable programs and clear diagrams**.

It does not focus on research papers.  
It does not derive equations.  
It does not teach frameworks.

Instead, each chapter contains:

- a simple diagram explaining the idea
- a tiny runnable Python program
- a walkthrough of how the system works
- experiments the reader can run

Understanding emerges by **seeing the system and running it**.

The guiding principle:

diagram → tiny program → run it → observe behavior

---

## Design Principles

### Code

Every program in this book follows strict rules:

- single file
- small enough to read in one sitting
- minimal dependencies
- fully runnable
- trains or demonstrates a real behavior

The scripts are intentionally tiny so readers can understand the entire system.

### Diagrams

This book is highly visual.

Every chapter contains multiple diagrams that explain:

- data flow
- system architecture
- training loops
- internal representations

Diagrams are used instead of math derivations.

---

## Chapter Structure

Each chapter follows the same structure.

### 1. The Idea

A short explanation of the concept in plain language.

### 2. System Diagram

A visual explanation of how information flows through the system.

### 3. The Tiny Program

A small runnable script implementing the idea.

### 4. Walking Through the System

Explanation of the key parts of the program.

### 5. Run the Experiment

Instructions for running the script and observing the behavior.

### 6. What Emerges

Discussion of what the program learns or produces.

---

## Part I — Learning From Data

### Chapter 1 — Fitting Data

Goal: show how a model can fit simple data.

```mermaid
flowchart LR
data_points --> model
model --> predictions
predictions --> loss
loss --> update
update --> model
```


Concepts introduced:

-   prediction
    
-   loss
    
-   iterative improvement
    

----------

### Chapter 2 — Classification

Goal: separate categories of data.

Diagram

```mermaid
flowchart LR
points --> decision_boundary
decision_boundary --> class_A
decision_boundary --> class_B
```

Concepts introduced:

-   decision boundary
    
-   probability
    
-   classification
    

----------

### Chapter 3 — Similarity

Goal: classify data using similarity.

Diagram

```mermaid
flowchart LR
query_point --> compare
compare --> nearest_neighbors
nearest_neighbors --> prediction
```

Concepts introduced:

-   distance
    
-   similarity
    
-   example-based learning
    

----------

### Chapter 4 — Clustering

Goal: discover structure without labels.

Diagram

```mermaid
flowchart LR
data_points --> clustering
clustering --> cluster_A
clustering --> cluster_B
clustering --> cluster_C
```

Concepts introduced:

-   grouping
    
-   unsupervised learning
    
-   cluster centers
    

----------

## Part II — Neural Networks

### Chapter 5 — The Perceptron

Goal: build the simplest neural unit.

Diagram

```mermaid
flowchart LR
x1 --> sum
x2 --> sum
x3 --> sum
sum --> activation
activation --> output
```

Concepts introduced:

-   weighted inputs
    
-   activation functions
    

----------

### Chapter 6 — Multi-Layer Networks

Goal: stack layers to learn complex patterns.

Diagram

```mermaid
flowchart LR
input --> hidden1
hidden1 --> hidden2
hidden2 --> output
```

Concepts introduced:

-   hidden layers
    
-   nonlinear transformations
    

----------

### Chapter 7 — Representation Learning

Goal: compress information into useful representations.

Diagram

```mermaid
flowchart LR
input --> encoder
encoder --> latent_space
latent_space --> decoder
decoder --> reconstruction
```

Concepts introduced:

-   latent representation
    
-   reconstruction
    

----------

### Chapter 8 — Embeddings

Goal: represent concepts as vectors.

Diagram

```mermaid
flowchart LR
word --> embedding_layer
embedding_layer --> vector_space
vector_space --> similarity
```

Concepts introduced:

-   embedding space
    
-   semantic similarity
    

----------

## Part III — Deep Learning Systems

### Chapter 9 — Convolutions

Goal: detect patterns in images.

Diagram

```mermaid
flowchart LR
image --> sliding_filter
sliding_filter --> feature_map
feature_map --> prediction
```

Concepts introduced:

-   filters
    
-   feature maps
    
-   local patterns
    

----------

### Chapter 10 — Residual Connections

Goal: allow deep networks to train effectively.

Diagram

```mermaid
flowchart LR
input --> layer
layer --> add
input --> add
add --> output
```

Concepts introduced:

-   skip connections
    
-   residual learning
    

----------

### Chapter 11 — Generative Models

Goal: generate realistic samples.

Diagram

```mermaid
flowchart LR
noise --> generator
generator --> fake_sample
fake_sample --> discriminator
real_sample --> discriminator
discriminator --> feedback
feedback --> generator
```

Concepts introduced:

-   adversarial learning
    
-   generative models
    

----------

### Chapter 12 — Latent Spaces

Goal: generate data from compressed representations.

Diagram

```mermaid
flowchart LR
latent_vector --> decoder
decoder --> generated_sample
generated_sample --> evaluation
```

Concepts introduced:

-   latent space
    
-   generative decoding
    

----------

## Part IV — Attention

### Chapter 13 — Attention

Goal: allow elements to focus on relevant information.

Diagram

```mermaid
flowchart LR
token_A --> attention
token_B --> attention
token_C --> attention
attention --> weighted_mix
weighted_mix --> output
```

Concepts introduced:

-   information weighting
    
-   contextual relationships
    

----------

### Chapter 14 — Transformer Blocks

Goal: process sequences using attention layers.

Diagram

```mermaid
flowchart LR
tokens --> embedding
embedding --> attention_block
attention_block --> feedforward
feedforward --> output
```

Concepts introduced:

-   self-attention
    
-   transformer blocks
    

----------

### Chapter 15 — Language Models

Goal: predict the next element in a sequence.

Diagram

```mermaid
flowchart LR
tokens --> model
model --> probability_distribution
probability_distribution --> next_token
```

Concepts introduced:

-   sequence modeling
    
-   next-token prediction
    

----------

### Chapter 16 — Diffusion

Goal: generate data by reversing noise.

Diagram

```mermaid
flowchart LR
image --> noise_step1
noise_step1 --> noise_step2
noise_step2 --> full_noise
full_noise --> denoise
denoise --> generated_image
```

Concepts introduced:

-   noise processes
    
-   iterative denoising
    

----------

## Part V — Modern AI Systems

### Chapter 17 — Retrieval

Goal: combine models with external knowledge.

Diagram

```mermaid
flowchart LR
question --> retrieval
retrieval --> documents
documents --> model
model --> answer
```

Concepts introduced:

-   memory
    
-   retrieval systems
    

----------

### Chapter 18 — Parameter Efficient Training

Goal: adapt models with minimal changes.

Diagram

```mermaid
flowchart LR
base_model --> adapter
adapter --> adapted_model
adapted_model --> prediction
```

Concepts introduced:

-   efficient updates
    
-   lightweight adaptation
    

----------

### Chapter 19 — Learning From Rewards

Goal: learn behavior using feedback.

Diagram

```mermaid
flowchart LR
state --> policy
policy --> action
action --> reward
reward --> update
update --> policy
```

Concepts introduced:

-   reinforcement learning
    
-   reward feedback
    

----------

### Chapter 20 — Alignment

Goal: guide models toward desired behavior.

Diagram

```mermaid
flowchart LR
model_output --> evaluator
evaluator --> preference_signal
preference_signal --> update
update --> improved_model
```

Concepts introduced:

-   preference learning
    
-   alignment
    

----------

## Diagram Density

Each chapter includes multiple diagrams explaining different aspects of the system.

Typical diagrams include:

-   architecture diagrams
    
-   training loops
    
-   information flow
    
-   vector spaces
    
-   interaction systems
    

The goal is to make the mechanisms visible.

----------

## Audience

This book is designed for:

-   engineers curious about how AI works
    
-   students learning machine learning systems
    
-   developers using AI who want to understand the internals
    

It assumes only basic programming knowledge.

----------

## Closing Idea

Modern AI is not magic.

It is a collection of surprisingly simple systems working together.

Once you see the systems clearly and run them yourself, the mystery disappears.