import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerCaptionsCommand(program: Command): void {
  const captions = program
    .command('captions')
    .description('YouTube captions operations');

  captions
    .command('list')
    .description('List caption tracks for a video')
    .option('--part <parts>', 'Resource parts to include', 'id,snippet')
    .requiredOption('--video-id <id>', 'YouTube video ID')
    .option('--id <id>', 'Comma-separated list of caption IDs')
    .action(async (opts) => {
      try {
        const apiKey = program.opts().apiKey || process.env.YT_API_KEY;
        if (!apiKey) {
          console.error('Error: API key required. Use --api-key or set YT_API_KEY.');
          process.exit(1);
        }

        const ns: YtCliJsNamespace = await getRuntime();
        const logLevel = program.opts().logLevel;
        const handle: YtCliJsHandle = await ns.withApiKey(apiKey, logLevel);

        try {
          const result = await handle.captionsList(opts.part, opts.videoId, opts.id);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  captions
    .command('insert')
    .description('Upload a caption track (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--body <json>', 'Caption snippet as a JSON string')
    .requiredOption('--file <file>', 'Path to the caption file (.srt, .vtt, etc.)')
    .option(
      '--access-tokens-file <path>',
      'Path to OAuth access tokens file (or YT_ACCESS_TOKENS_FILE)',
    )
    .option(
      '--client-secrets-file <path>',
      'Path to OAuth client secrets file (or YT_CLIENT_SECRETS_FILE)',
    )
    .action(async (opts) => {
      try {
        const ns: YtCliJsNamespace = await getRuntime();
        const logLevel = program.opts().logLevel;
        const handle: YtCliJsHandle = await ns.withOAuth(
          opts.accessTokensFile,
          opts.clientSecretsFile,
          logLevel,
        );

        try {
          const body = JSON.parse(opts.body);
          const result = await handle.captionsInsert(opts.part, body, opts.file);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  captions
    .command('update')
    .description('Update a caption track (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--body <json>', 'Caption resource (with id and snippet) as a JSON string')
    .requiredOption('--file <file>', 'Path to the updated caption file')
    .option(
      '--access-tokens-file <path>',
      'Path to OAuth access tokens file (or YT_ACCESS_TOKENS_FILE)',
    )
    .option(
      '--client-secrets-file <path>',
      'Path to OAuth client secrets file (or YT_CLIENT_SECRETS_FILE)',
    )
    .action(async (opts) => {
      try {
        const ns: YtCliJsNamespace = await getRuntime();
        const logLevel = program.opts().logLevel;
        const handle: YtCliJsHandle = await ns.withOAuth(
          opts.accessTokensFile,
          opts.clientSecretsFile,
          logLevel,
        );

        try {
          const body = JSON.parse(opts.body);
          const result = await handle.captionsUpdate(opts.part, body, opts.file);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  captions
    .command('delete')
    .description('Delete a caption track (requires OAuth)')
    .requiredOption('--id <id>', 'Caption track ID to delete')
    .option(
      '--access-tokens-file <path>',
      'Path to OAuth access tokens file (or YT_ACCESS_TOKENS_FILE)',
    )
    .option(
      '--client-secrets-file <path>',
      'Path to OAuth client secrets file (or YT_CLIENT_SECRETS_FILE)',
    )
    .action(async (opts) => {
      try {
        const ns: YtCliJsNamespace = await getRuntime();
        const logLevel = program.opts().logLevel;
        const handle: YtCliJsHandle = await ns.withOAuth(
          opts.accessTokensFile,
          opts.clientSecretsFile,
          logLevel,
        );

        try {
          await handle.captionsDelete(opts.id);
          console.log(JSON.stringify({ deleted: opts.id }, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  captions
    .command('download')
    .description('Download a caption track')
    .requiredOption('--id <id>', 'Caption track ID to download')
    .option('--tfmt <format>', 'Caption format (srt, vtt, sbv, etc.)')
    .option('--tlang <lang>', 'BCP-47 language code for auto-translated captions')
    .option('--out <file>', 'Write caption content to a file instead of stdout')
    .action(async (opts) => {
      try {
        const apiKey = program.opts().apiKey || process.env.YT_API_KEY;
        if (!apiKey) {
          console.error('Error: API key required. Use --api-key or set YT_API_KEY.');
          process.exit(1);
        }

        const ns: YtCliJsNamespace = await getRuntime();
        const logLevel = program.opts().logLevel;
        const handle: YtCliJsHandle = await ns.withApiKey(apiKey, logLevel);

        try {
          const result = await handle.captionsDownload(opts.id, opts.tfmt, opts.tlang, opts.out);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });
}
