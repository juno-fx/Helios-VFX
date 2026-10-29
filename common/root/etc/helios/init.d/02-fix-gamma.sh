#!/bin/bash
# Fix X11 gamma ramp for vgl-free operation
# VirtualGL was previously mediating gamma configuration;
# this script re-establishes proper gamma ramp after X server startup.

set -e

# Find the primary connected output
PRIMARY_OUTPUT=$(xrandr --query | grep " connected primary" | head -1 | cut -d" " -f1)

if [ -n "$PRIMARY_OUTPUT" ]; then
    # Set gamma to 1.0 (linear) for all channels: red, green, blue
    xrandr --output "$PRIMARY_OUTPUT" --gamma 1.0:1.0:1.0
    echo "Gamma fixed for $PRIMARY_OUTPUT"
else
    # Fallback: try xgamma if xrandr doesn't find a primary output
    xgamma -gamma 1.0 2>/dev/null || echo "Gamma fix: no primary output found, continuing anyway"
fi