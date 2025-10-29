#!/usr/bin/env bash
set -euo pipefail
bundle exec cucumber -p ${CUCUMBER_PROFILE:-default}
