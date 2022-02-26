#!/bin/bash

ARGS=$(snapctl get args)
DEST=$(snapctl get destination)
PORT=$(snapctl get port)


if [ -z "$DEST" ]; then
    logger --stderr "ERROR: destination not set"
    exit 1
fi

if [ -z "$PORT" ]; then
    logger --stderr "ERROR: destination ssh server port not set"
    exit 1
fi

ssh -v -TNn -o StrictHostKeyChecking=no $ARGS -p $PORT $DEST
