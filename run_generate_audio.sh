#!/bin/bash

# Check if two arguments are passed
# $0 means the name or the path used to invoke the script
# $# is the number of positional parameters
# -ne is a comparison operator in bash that stands for "not equal"
if [ $# -ne 2 ]; then
  echo "Usage: $0 <start_part> <end_part>"
  exit 1
fi

start_part=$1
end_part=$2

# Loop through the specified range
for ((i=start_part; i<=end_part; i++))
do
  python generate_audio.py --midi_dir ./paired_midi/splits/part_$i --output_dir ./audio_output --skip_existing_files
done
