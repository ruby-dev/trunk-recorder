#!/bin/bash

exec rm /app/stream.liq && cp /app/templates/stream.liq /app/stream.liq
exec rm /app/stream0.liq && cat /app/templates/stream0.liq | mo > /app/stream0.liq
