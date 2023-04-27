#!/usr/bin/env bash

git pull

sudo nixos-rebuild switch --flake .#NixOS
