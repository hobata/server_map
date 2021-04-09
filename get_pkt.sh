#!/bin/bash
rm -rf /tmp/capture*
tshark -i enp4s1 -b files:5 -b interval:10 -w /tmp/capture
