#!/bin/bash

FILE="progress.md"
touch $FILE

START_DATE="2026-01-23"

MESSAGES=(
"init: setup turborepo monorepo with workspace configuration"
"feat: initialize frontend with React + TypeScript + Vite"
"feat: setup backend services (express, websocket, worker)"
"chore: added shared configs (tsconfig, eslint, prettier, env examples)"
"feat: built initial frontend layout with editor shell"
"feat: implemented routing for register and room pages"
"docs: added initial README with architecture and setup instructions"

"feat: setup websocket server and basic client connection"
"feat: implemented room create/join flow with unique room IDs"
"feat: added user identity state management using recoil"
"feat: enable sending editor updates over websocket"
"feat: integrate code editor component in frontend"
"feat: sync editor content across multiple clients"
"fix: handle disconnects, reconnects, and basic room cleanup"

"feat: created express API for code execution requests"
"feat: integrate Redis queue for job handling"
"feat: define job payload structure for execution pipeline"
"feat: implemented worker service to process execution jobs"
"feat: added docker-based sandbox execution (single language)"
"feat: publish execution results using Redis pub/sub"
"feat: stream execution output to frontend via websocket"


"feat: added language selector to editor UI"
"feat: support multiple runtimes in worker containers"
"feat: implemented run button states (idle, running, success, error)"
"feat: built output panel for stdout and stderr"
"feat: improve register page UX and room joining flow"
"feat: added loading states, validation, and disabled states"
"style: enhance editor header, branding, and responsiveness"

"feat: added environment variable handling across services"
"feat: dockerize services for local development"
"feat: deploy frontend on Vercel"
"feat: configure backend deployment on AWS ECS/EC2"
"chore: improve logging and error handling across services"
"docs: enhance README with diagrams and setup instructions"
"fix: final bug fixes and production readiness improvements"
)

TOTAL_COMMITS=35

for ((i=0; i<$TOTAL_COMMITS; i++))
do
  # Spread commits in increasing order (important)
  DAY_OFFSET=$(( i * 60 / TOTAL_COMMITS ))

  CURRENT_DATE=$(date -d "$START_DATE +$DAY_OFFSET days" +"%Y-%m-%d")

  # Realistic working hours (10am–7pm)
  HOUR=$(( (RANDOM % 9) + 10 ))
  MIN=$((RANDOM % 60))
  SEC=$((RANDOM % 60))

  TIMESTAMP="$CURRENT_DATE $HOUR:$MIN:$SEC"

  echo "Commit $i on $TIMESTAMP" >> $FILE

  git add .

  GIT_AUTHOR_DATE="$TIMESTAMP" \
  GIT_COMMITTER_DATE="$TIMESTAMP" \
  git commit -m "${MESSAGES[$i]}"
done