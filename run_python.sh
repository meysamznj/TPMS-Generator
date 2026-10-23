#!/usr/bin/env bash
echo "========================================================"
echo "  Launching TPMS Generator (Python PyQt6)"
echo "  100% Offline - Zero External Network Required"
echo "========================================================"
echo ""

cd "$(dirname "$0")"

if ! command -v python3 &> /dev/null; then
    echo "[ERROR] Python 3 not found!"
    exit 1
fi

python3 app.py
EXIT_CODE=$?
if [ $EXIT_CODE -ne 0 ]; then
    echo ""
    echo "========================================================"
    echo "[ERROR] Application exited with code $EXIT_CODE"
    if [ -f "crash_log.txt" ]; then
        echo "--- CRASH LOG ---"
        cat crash_log.txt
        echo "-----------------"
    fi
    echo "========================================================"
fi
exit $EXIT_CODE
