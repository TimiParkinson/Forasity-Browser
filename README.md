# Forasity-Browser (Chromium Patch Repo)

This repo contains Forasity changes as patch files that apply on top of upstream Chromium.

## One-time setup (per developer)
1. Install depot_tools and fetch Chromium (per Chromium docs).
2. Clone this repo somewhere *outside* chromium/.

## Apply Forasity changes
From this repo:
  ./scripts/apply.sh /path/to/chromium/src

Example:
  ./scripts/apply.sh ~/work/chromium/src

Then build Chromium:
  cd ~/work/chromium/src
  gn gen out/Default
  autoninja -C out/Default chrome
