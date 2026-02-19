"""
Financial Forensics Engine – FastAPI application entry point
"""

from __future__ import annotations

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.api.routes import router

# ── Application factory ───────────────────────────────────────────────────────

app = FastAPI(
    title="RIFT 2026 – Graph-Based Financial Forensics Engine",
    description=(
        "Money Muling Detection API using graph theory, temporal analysis, "
        "and intelligent suspicion scoring. "
        "Detects circular fund routing, smurfing, and layered shell networks."
    ),
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
)

# ── CORS (allow the existing frontend dashboard to connect) ───────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],        # tighten in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Register routes ───────────────────────────────────────────────────────────
app.include_router(router)


# ── Health check ──────────────────────────────────────────────────────────────
@app.get("/health", tags=["meta"])
async def health_check() -> dict:
    return {"status": "ok", "service": "fraudai-backend"}
