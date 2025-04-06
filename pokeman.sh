#!/bin/bash
# This script will list the names of all the pokemons
ALL_POKEMON=$(curl -sl https://pokeapi.co/api/v2/pokemon?limit=1400 | jq ".results[].name" -r)
for pokemon in $ALL_POKEMON; do
    echo "The name of pokemon is: $pokemon"
done