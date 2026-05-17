# yt_cli Examples

## Authorize the CLI

```sh
# Download client_secret.json from Google Cloud Console
yt authorize
```

This opens a browser for OAuth 2.0 authorization. After approving, a refresh
token is saved locally so subsequent runs are unattended.

## Common commands

```sh
# Upload a video
yt videos insert \
  --video-file my_video.mp4 \
  --part snippet \
  --notify-subscribers true \
  --body '{"snippet":{"title":"My Video","description":"Hello world!"}}'

# Set a custom thumbnail
yt thumbnails set \
  --video-id YOUR_VIDEO_ID \
  --file thumbnail.jpg

# Search for videos
yt search \
  --q "Dart programming" \
  --part snippet \
  --max-results 5

# List your channels
yt channels list \
  --mine true \
  --part snippet
```

Run `yt --help` or `yt <command> --help` for the full list of available
commands and their options.
