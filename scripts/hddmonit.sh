#!/bin/bash
echo "$(sensors | tail -n2 | cut -c14-19)"
