#!/bin/bash

exec cp /app/templates/stream.liq /app/stream.liq
exec cat /app/templates/stream0.liq | mo > /app/stream0.liq
