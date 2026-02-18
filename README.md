# Forasity Browser

Chromium-Based Productivity & Intelligence Browser (Patch Layer Architecture)

## 🌍 Vision

Forasity is a Chromium-based desktop browser that integrates contextual productivity and intelligence directly into the browsing experience.

Unlike traditional browsers that separate browsing from task management and knowledge capture, Forasity aims to:

Attach notes directly to specific page content

Create tasks inline while browsing

Classify search results (fact vs opinion vs analysis)

Provide a unified workspace aggregating browsing context, notes, and tasks

Operate local-first with privacy-preserving ML

Forasity is implemented as a Chromium fork, not as an Electron wrapper.

## 🧱 Architecture Overview

Forasity is built as a patch layer on top of upstream Chromium.

We do NOT host Chromium in this repository.

Instead:

Each developer fetches Chromium directly from Google.

This repository contains:

Patch files representing Forasity changes

Scripts to apply those patches

Documentation and coordination materials

This keeps:

Repository size small

Collaboration clean

Upstream updates manageable

CI practical

## 📁 Essential Repo Structure
Forasity-Browser/
├── patches/              # Git patch files representing Forasity changes
├── scripts/
│   ├── apply.sh          # Applies patches to a local Chromium checkout
├── docs/                 # Architecture and design documents
├── README.md

## 👥 Team Collaboration Model

### Each developer maintains:

A local Chromium checkout

A local clone of this repository

### When a new feature is developed:

Developer creates a branch in their Chromium checkout

Developer commits changes

Developer exports patches using git format-patch

Patch files are added to this repo via PR

Team reviews patch files

Once merged, teammates pull and re-apply

### We collaborate through:

Pull Requests in this repository

Patch file review

Clear commit messages

Discord: 

## 🧑‍💻 Developer Setup
### Step 1 — Install depot_tools

Follow Chromium’s official instructions to install:

https://chromium.googlesource.com/chromium/src/+/main/docs/mac_build_instructions.md

Add depot_tools to PATH.

### Step 2 — Fetch Chromium

Example:

mkdir -p ~/work
cd ~/work
fetch --nohooks chromium
cd src
gclient sync
gclient runhooks


Build once to confirm everything works:

gn gen out/Default
autoninja -C out/Default chrome

### Step 3 — Clone This Repository
cd ~/work
git clone https://github.com/YOUR_ORG/Forasity-Browser.git
cd Forasity-Browser

## 🚀 Applying Forasity Changes

From inside this repository:

./scripts/apply.sh ~/work/chromium/src


Then build:

cd ~/work/chromium/src
gn gen out/Default
autoninja -C out/Default chrome


You are now running Forasity-enhanced Chromium.

## ✍️ How To Develop a Feature
### 1️⃣ Create a branch in Chromium
cd ~/work/chromium/src
git fetch origin
git checkout -b forasity/feature-name origin/main

### 2️⃣ Implement your feature

All Forasity code should live under:

chrome/browser/forasity/


Keep Forasity changes logically isolated.

### 3️⃣ Commit your changes
git add .
git commit -m "Forasity: add contextual notes MVP"

### 4️⃣ Export patches
git format-patch origin/main..HEAD -o ~/work/Forasity-Browser/patches


This creates numbered .patch files.

### 5️⃣ Add patches to this repo
cd ~/work/Forasity-Browser
git add patches
git commit -m "Add contextual notes MVP patches"
git push


Open a Pull Request.

## 🧠 Feature Scope (MVP Roadmap)
### 1️⃣ Contextual Notes

Capture selected text

Store with URL + timestamp

Reattach on revisit

Searchable

Stored locally (SQLite)

### 2️⃣ Task & Schedule Hub

Create tasks from highlights/pages

Persistent sidebar

Deadlines (local-first)

### 3️⃣ Search Snippet Classification

Detect SERPs

Extract snippet text

Run local inference

Display fact/opinion/analysis label

Never reorder results

### 4️⃣ Unified Workspace Hub

chrome://forasity

Aggregate notes + tasks

Filter by URL/project/date

Cross-link content

## 🔐 Privacy & Security

tbd

## 📦 Updating to New Chromium Versions

#### When upstream updates:

cd ~/work/chromium/src
git fetch origin
git checkout origin/main
gclient sync


#### Then reapply patches:

cd ~/work/Forasity-Browser
./scripts/apply.sh ~/work/chromium/src


#### If patches fail to apply cleanly:

Rebase feature branch

Regenerate patches

Submit updated PR

## 🎯 Long-Term Goal

Forasity aims to become:

* A research-grade productivity browser that:

* Integrates browsing with knowledge capture

* Preserves local privacy
  
* Augments search transparency

* Eliminates context switching between apps

* Maintains Chromium performance and compatibility

## 🛠 Current Status

- [x] Chromium builds successfully

- [x] Patch-layer collaboration model established

- [ ] MVP feature development beginning

## 📌 Contributing Guidelines

1. Keep patches focused and atomic

2. Do not modify unrelated Chromium files

3. All new Forasity logic lives under chrome/browser/forasity

4. Provide a short test plan in each PR
