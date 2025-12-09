# Recording demo as GIF for README

Option A: ScreenToGif (Windows)
- Install from https://www.screentogif.com/
- Record the terminal and browser while you: start minikube, build image, apply k8s, show pods, and open app.
- Save GIF as releaseflow.gif in repo root.

Option B: asciinema + svgcast -> gif (terminal-only)
- Install asciinema
- Record: asciinema rec releaseflow.cast
- Run commands, stop with Ctrl+D
- Use asciinema2gif (or asciicast2gif) tool to convert to GIF
