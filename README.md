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
python generate_audio.py --midi_dir ./paired_midi/splits/part_6 --output_dir ./audio_output/part_6
```

Notes:
- It requires ~3341MiB of GPU VRAM depending on the midi file size.
- On the RTX 4090, it takes about 30s per audio file, 29:13 minutes to finished 71 midi files.
