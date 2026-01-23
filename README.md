<div align="center">

# ⚡ CoEditX — Collaborative Cloud IDE

### CoEditX is a distributed, real-time collaborative coding platform that enables multiple users to write, edit, and execute code simultaneously in a shared environment — directly from the browser.


[![TypeScript](https://img.shields.io/badge/TypeScript-88.3%25-3178C6?style=flat-square&logo=typescript&logoColor=white)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-%3E%3D18-339933?style=flat-square&logo=node.js&logoColor=white)](https://nodejs.org/)
[![React](https://img.shields.io/badge/React-Frontend-61DAFB?style=flat-square&logo=react&logoColor=black)](https://react.dev/)
[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?style=flat-square&logo=docker&logoColor=white)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20ECS-FF9900?style=flat-square&logo=amazonaws&logoColor=white)](https://aws.amazon.com/)

**Perfect for remote interviews, pair programming, and team coding sessions.**

</div>



---

## 🌟 Overview

**CoEditX** is a full-stack, cloud-native collaborative IDE that enables multiple developers to write and run code together in real time — directly from the browser. No local setup required. Code changes propagate instantly across all connected clients, and execution happens inside secure, isolated Docker containers to ensure a safe sandboxed environment.

Whether you're conducting a technical interview, pair programming with a colleague, or running a remote coding workshop, CoEditX provides the infrastructure to collaborate at scale.

---

## 🏛️ System Design

### Cloud IDE Architecture

<img width="1111" height="601" alt="image" src="https://github.com/user-attachments/assets/517bfa0b-995c-47f6-95dc-74a01bc73aec" />


### Collaborative Code Editor Architecture

<img width="940" height="749" alt="image" src="https://github.com/user-attachments/assets/87fd2383-9189-4568-9f48-e667d2e56efd" />


---

## ✨ Features

| Feature | Description |
|---|---|
| 🤝 **Real-Time Collaboration** | Multiple users can write code simultaneously with instant, conflict-free synchronization |
| ☁️ **Browser-Based IDE** | Fully functional IDE accessible from any browser — no local installation needed |
| 🔒 **Secure Code Execution** | Code runs inside isolated Docker containers, preventing any impact on the host system |
| 📡 **WebSocket Communication** | Persistent, low-latency bidirectional connections for seamless real-time updates |
| ⚙️ **Scalable Queue Processing** | Redis-backed job queue ensures reliable, ordered code execution under load |
| 🚀 **Cloud-Native Deployment** | Each service independently deployed on AWS (ECS / EC2) for high availability |

---

## 💻 Tech Stack

### Frontend

| Technology | Purpose |
|---|---|
| **React** | UI component library for building the interactive IDE interface |
| **Recoil** | Atom-based state management for efficient, fine-grained UI updates |
| **TypeScript** | Type-safe development across the entire frontend codebase |

### Backend

| Technology | Purpose |
|---|---|
| **Node.js** | JavaScript runtime powering all backend services |
| **Express.js** | RESTful API server for handling code submission requests |
| **WebSocket (ws)** | Real-time bidirectional communication for collaborative editing |
| **Redis Queue** | Job queue for reliable, ordered submission of code execution tasks |
| **Redis Pub/Sub** | Event-driven messaging between backend services (e.g., worker → websocket notifications) |

### Infrastructure

| Technology | Purpose |
|---|---|
| **Docker** | Containerized, isolated execution environments for running untrusted code |
| **AWS EC2** | Hosts the dedicated WebSocket server |
| **AWS ECS** | Container orchestration for the Express server and Worker services |
| **Vercel** | Frontend hosting with global CDN and zero-config deployments |
| **Turborepo** | Monorepo build system for optimized task orchestration |

---

## 🏗️ Architecture

The project is structured as a **Turborepo monorepo**, with four independently deployable services:

```
┌─────────────────────────────────────────────────────────┐
│                     Browser Client                      │
│              (React + Recoil — Vercel)                  │
└────────────────────┬────────────────┬───────────────────┘
                     │ HTTP           │ WebSocket
                     ▼                ▼
          ┌──────────────┐   ┌─────────────────┐
          │ Express      │   │  WebSocket      │
          │ Server       │   │  Server         │
          │ (AWS ECS)    │   │  (AWS EC2)      │
          └──────┬───────┘   └────────┬────────┘
                 │ Enqueue            │ Subscribe
                 ▼                    ▼
          ┌────────────────────────────────────┐
          │            Redis                   │
          │   Queue (jobs) + Pub/Sub (events)  │
          └───────────────┬────────────────────┘
                          │ Dequeue
                          ▼
                 ┌─────────────────┐
                 │     Worker      │
                 │   (AWS ECS)     │
                 │  Docker Exec    │
                 └─────────────────┘
```

### Service Breakdown

#### `frontend`
The user-facing React application providing the collaborative IDE interface.
- **Hosting:** Vercel
- **URL:** [real-time-code-box-frontend.vercel.app](https://real-time-code-box-frontend.vercel.app)

#### `express-server`
Handles REST API requests and pushes code submission jobs to the Redis queue.
- **Hosting:** AWS ECS

#### `websocket-server`
Manages all real-time WebSocket connections for code synchronization between collaborators. Subscribes to Redis Pub/Sub to relay execution results back to clients.
- **Hosting:** AWS EC2

#### `worker`
Dequeues code execution jobs from Redis, runs code inside isolated Docker containers, and publishes results back via Redis Pub/Sub.
- **Hosting:** AWS ECS

---

## 📁 Project Structure

```
CoEditX-Collaborative-Cloud-IDE/
├── apps/
│   ├── frontend/          # React + Recoil client application
│   ├── express-server/    # REST API server (code submission)
│   ├── websocket-server/  # WebSocket server (real-time sync)
│   └── worker/            # Code execution worker (Docker)
├── .gitignore
├── package.json           # Root workspace config (npm workspaces)
├── turbo.json             # Turborepo pipeline config
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- **Node.js** `>= 18`
- **npm** `>= 10.8.1`
- **Docker** (for the worker service)
- **Redis** instance (local or cloud)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/g-naman07/CoEditX.git
cd CoEditX-Collaborative-Cloud-IDE
```

2. **Install dependencies**

```bash
npm install
```

3. **Set up environment variables**

Create `.env` files in each service directory (see [Environment Variables](#environment-variables)).

4. **Run all services in development mode**

```bash
npm run dev
```

This uses Turborepo to start all apps concurrently with hot-reloading.

5. **Build for production**

```bash
npm run build
```

### Running Individual Services

```bash
# Frontend only
cd apps/frontend && npm run dev

# Express server only
cd apps/express-server && npm run dev

# WebSocket server only
cd apps/websocket-server && npm run dev

# Worker only
cd apps/worker && npm run dev
```

---

## 🔧 Environment Variables

Configure the following environment variables for each service:

### `express-server`

```env
PORT=3001
REDIS_URL=redis://localhost:6379
```

### `websocket-server`

```env
PORT=3002
REDIS_URL=redis://localhost:6379
```

### `worker`

```env
REDIS_URL=redis://localhost:6379
DOCKER_IMAGE=node:18-alpine   # or any supported runtime image
```

### `frontend`

```env
VITE_EXPRESS_SERVER_URL=http://localhost:3001
VITE_WS_SERVER_URL=ws://localhost:3002
```

---

## ☁️ Deployment

| Service | Platform | Notes |
|---|---|---|
| `frontend` | **Vercel** | Connect repo, set env vars, auto-deploys on push |
| `express-server` | **AWS ECS** | Dockerize and push to ECR, deploy as ECS service |
| `websocket-server` | **AWS EC2** | SSH into instance, run with PM2 or systemd |
| `worker` | **AWS ECS** | Requires Docker-in-Docker or privileged container mode |

> **Note:** Ensure your Redis instance is accessible from all deployed services. AWS ElastiCache (Redis) is recommended for production.

---

<div align="center">

Made with ❤️ by **Naman Gupta**

⭐ Star this repo if you found it helpful!

</div>
