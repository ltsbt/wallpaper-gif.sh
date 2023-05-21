# wallpaper-gif.sh
This repository contains a script (wallpaper-gif.sh) for setting an animated GIF as the desktop wallpaper on Linux. The script converts a GIF into an MP4 video and uses xwinwrap to run mpv in the root window, making your GIF appear as the desktop background.

## Requirements
- `ffmpeg`
- `mpv`
- `xwinwrap`

The script will attempt to install `ffmpeg`, `mpv`, and `xwinwrap` if they are not found on your system.

## Usage
- Download the `wallpaper-gif.sh` script or clone this repository.
- Make the script executable with `chmod +x wallpaper-gif.sh`.
- Run the script with a GIF as the parameter: `./wallpaper-gif.sh /path/to/your/gif`

## Stopping the GIF Wallpaper
To stop the GIF from being your wallpaper, kill the xwinwrap process.

You can do this by running `pkill xwinwrap`.

## Notes
The script automatically stores the converted .mp4 file in the same location as the original .gif. If you prefer a different location for the .mp4 file, you can modify the `video_path` variable in the `wallpaper-gif.sh` script.

I would recommend setting an alias for the commands for ease of use, for example:
```bash
alias wpgif='~/path/to/wallpaper-gif.sh'
alias nowpgif='pkill xwinwrap'
```
