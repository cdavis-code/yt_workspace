## Automated YouTube Data API Authentication with Dart
This guide explains how to set up an automated, server-side Dart application to read private YouTube data using the official [yt](https://pub.dev/packages/yt) package. Because YouTube does not support service accounts for standard channels, this setup utilizes a one-time OAuth 2.0 web flow to securely capture and store a permanent Refresh Token for unattended server operation.
------------------------------
## Part 1: How to Get your client_secret.json File
Follow these steps to generate and download your application credentials from the Google Cloud Console.
## 1. Create a Google Cloud Project

   1. Open the [Google Cloud Console](https://console.cloud.google.com/).
   2. Click the project dropdown menu in the top left corner next to the logo.
   3. Select New Project, enter a name (e.g., YouTube Backend Integration), and click Create.

## 2. Enable the Required YouTube APIs

   1. Navigate to the API & Services > Library page via the left sidebar menu.
   2. Search for and enable each of the following APIs:
      - **YouTube Data API v3**
      - **YouTube Live Streaming API**
      - **YouTube Analytics API**
   3. After enabling all three, you're ready to create credentials.

## 3. Configure the OAuth Consent Screen
Before creating keys, Google requires you to configure user-facing details.

   1. Go to APIs & Services > OAuth consent screen.
   2. Select External (unless you are an enterprise Google Workspace user) and click Create.
   3. Fill out the mandatory field definitions: App name, User support email, and Developer contact information.
   4. On the **Scopes** page, click Save and Continue without adding scopes.
   5. On the **Test Users** page, click **+ Add Users** and enter the email address
      of the Google account you'll use with YouTube. Then click Save and Continue.

      > **Critical:** If you skip adding yourself as a Test User, Google will block
      > authentication with: *"Access blocked: This app's request is invalid"* and
      > redirect you to their unverified app policy page. You can come back and add
      > more test users later at any time.

## 4. Generate Web Application Credentials

> **Prerequisite:** You must complete [Step 3](#3-configure-the-oauth-consent-screen) (OAuth consent screen) first. Attempting this step without it will show: *"To create an OAuth client ID, you must first configure your consent screen."*

   1. Go to APIs & Services > Credentials.
   2. Click + Create Credentials at the top of the screen and select OAuth client ID.
   3. Set the Application type dropdown to Web application.
   4. Scroll down to Authorized redirect URIs and click + Add URI.
   5. Input exactly: http://localhost:8080/callback
   6. Click Create.

## 5. Download the File

   1. Locate your new credential in the OAuth 2.0 Client IDs list.
   2. Click the Download JSON icon (downward-facing arrow) on the far-right side of the row.
   3. Save or rename the file to client_secret.json.
   4. Place this file directly into the root directory of your Dart application alongside your pubspec.yaml file.

------------------------------
## Part 2: Authenticate with the yt CLI

Once `client_secret.json` is in your working directory, run the CLI's built-in
authorization command:

```sh
yt authorize
```

### What happens

1. The CLI starts a temporary HTTP server on port **8080** (`localhost`) and prints a
   Google OAuth URL to the terminal.
2. Open that URL in your browser, sign in with the YouTube account you want to use,
   and accept the requested permissions.
3. Google redirects your browser back to the local server. The CLI captures the
   authorization code, exchanges it for a permanent **Refresh Token**, and saves
   everything to `youtube_server_tokens.json`.
4. The local server stops. Your CLI is now fully authorized.

### Command options

| Flag | Short | Description |
|------|-------|-------------|
| `--credentials-file <path>` | `-c` | Path to `client_secret.json` if it is not in the working directory. |
| `--tokens-file <path>` | `-t` | Path where OAuth tokens will be stored. |
| `--overwrite-credentials` | `-o` | Delete stored tokens and go through the authorization flow again. |

Examples:

```sh
# Use a secret file stored elsewhere
yt authorize --credentials-file ~/secrets/my_youtube_client_secret.json

# Store tokens in a custom location
yt authorize --tokens-file ~/.yt/tokens_production.json

# Re-authorize with a fresh token
yt authorize --overwrite-credentials
```

### Already authorized

If `youtube_server_tokens.json` already exists in the working directory the
command prints a confirmation and exits without re-authorizing.  Pass
`--overwrite-credentials` to force a new flow.

### After authorization

All other `yt` sub-commands (`list`, `insert`, `update`, etc.) automatically
read the stored credentials and refresh the access token in the background
whenever it expires. No additional configuration is needed.

### Customizing where credentials are stored

By default, `yt authorize` reads `client_secret.json` and writes
`youtube_server_tokens.json` in the **current working directory**. To keep
each file in a different (or shared) location, set one or both of these
environment variables to the **exact file path** you want to use:

| Variable | Purpose |
|----------|---------|
| `YT_CLIENT_SECRETS_FILE` | Full path to the OAuth `client_secret.json` file. |
| `YT_ACCESS_TOKENS_FILE`  | Full path where the refresh-token bundle (`youtube_server_tokens.json`) is read from and written to. |

Each variable is resolved in the following order:

1. The runtime environment, then
2. A `.env` file in the current working directory.

A leading `~` is expanded against your home directory. Either variable may
be set independently — unset variables simply keep their default location.

Example:

```sh
# One-off
YT_CLIENT_SECRETS_FILE=~/.yt/client_secret.json \
YT_ACCESS_TOKENS_FILE=~/.yt/youtube_server_tokens.json \
yt authorize

# Or in a .env file alongside your project
cat >> .env <<'EOF'
YT_CLIENT_SECRETS_FILE=~/.yt/client_secret.json
YT_ACCESS_TOKENS_FILE=~/.yt/youtube_server_tokens.json
EOF
yt authorize
```

An explicit `--credentials-file <path>` argument always takes precedence
over `YT_CLIENT_SECRETS_FILE`. Similarly, `--tokens-file <path>` takes
precedence over `YT_ACCESS_TOKENS_FILE`.
