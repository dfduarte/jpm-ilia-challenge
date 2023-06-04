#!/bin/sh

. /appenv/bin/activate && cd /application/ && exec python -m uvicorn main:app --reload --host 0.0.0.0

