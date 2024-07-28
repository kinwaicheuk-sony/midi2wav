# Setup

## Envirnoment
Docker image `11.8.0-cudnn8-runtime-ubuntu22.04`.

To pull the image `docker pull nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04`.


```
Python==3.8.0
tensorflow==2.13.1
```

If ffmpeg is not installed, the following error occurs

> RuntimeWarning: Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work
  warn("Couldn't find ffmpeg or avconv - defaulting to ffmpeg, but may not work", RuntimeWarning)

To install it, try
**Linux**
```
apt install ffmpeg
```

**Windows**
```
pip install ffmpeg-downloader
ffdl install --add-path
```

## Installation

Try `pip install midi-ddsp` first.

If it doesn't work, go inside the `ddsp` and `midi-ddsp` folder and `pip install -e .` them manually.

## Weight download
```
python midi-ddsp/midi_ddsp/download_model_weights.py
```

It will download the models weight to `./midi-ddsp/midi_ddsp/midi_ddsp_model_weights_urmp_9_10`

# Usage

As in the original [repo](https://github.com/magenta/midi-ddsp), you can synthesize audio from midi using the following command:

**Single midi file**

```
python generate_audio.py --midi_path <path-to-midi> --output_dir <path-to-folder>
```

**A folder of midi files**

```
python generate_audio.py --midi_dir <path-to-midi_dir> --output_dir <path-to-folder>
```

e.g.
```
python generate_audio.py --midi_dir ./paired_midi/splits/part_7 --output_dir ./audio_output
```

for i in {8..10};do python generate_audio.py --midi_dir ./paired_midi/splits/part_${i} --output_dir ./audio_output

for 

Notes:
- It requires ~3341MiB of GPU VRAM depending on the midi file size.
- On the RTX 4090, it takes about 30s per audio file, 29:13 minutes to finish 71 midi files.
- On the H100, it takes 48:35 minutes to finish 71 midi files, on average it takes 41s per audio file

# Memory leak
It seems tensorflow is suffering from memory leak issue during inference and training.

One possible solution is

https://dantkz.github.io/How-To-Debug-A-Memory-Leak-In-TensorFlow/

LD_PRELOAD=/usr/lib/libtcmalloc.so.4 python generate_audio_debug_leakage.py --midi_dir ./paired_midi/splits/part_4 --output_dir ./audio_output --output_dir ./audio_output --skip_existing_files