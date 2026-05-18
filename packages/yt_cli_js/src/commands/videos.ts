import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerVideosCommand(program: Command): void {
  const videos = program.command('videos').description('YouTube video operations');

  videos
    .command('list')
    .description('List YouTube videos')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--id <id>', 'Video ID')
    .option('--chart <chart>', 'Chart to retrieve (e.g. mostPopular)')
    .option('--max-results <n>', 'Maximum number of results', '5')
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
          const result = await handle.videosList(
            opts.id,
            opts.chart,
            opts.part,
            parseInt(opts.maxResults, 10),
          );
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  videos
    .command('insert')
    .description('Upload a new video (requires OAuth)')
    .option(
      '--part <parts>',
      'Resource parts to include',
      'snippet,status,contentDetails',
    )
    .requiredOption('--body <json>', 'Video resource metadata as a JSON string')
    .requiredOption('--video-file <path>', 'Path to the video file to upload')
    .option(
      '--notify-subscribers <bool>',
      'Notify subscribers about the new video (true|false)',
    )
    .option('--on-behalf-of-content-owner <id>', 'Authenticate as content partner')
    .option(
      '--on-behalf-of-content-owner-channel <id>',
      'Channel ID acted on by the content owner',
    )
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
          const notify =
            opts.notifySubscribers === undefined
              ? undefined
              : String(opts.notifySubscribers).toLowerCase() === 'true';
          const result = await handle.videosInsert(
            opts.part,
            body,
            opts.videoFile,
            notify,
            opts.onBehalfOfContentOwner,
            opts.onBehalfOfContentOwnerChannel,
          );
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  videos
    .command('update')
    .description('Update a video resource (requires OAuth)')
    .option(
      '--part <parts>',
      'Resource parts to update',
      'snippet,status,contentDetails',
    )
    .requiredOption('--body <json>', 'Video resource as a JSON string')
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
          const result = await handle.videosUpdate(opts.part, body);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  videos
    .command('delete')
    .description('Delete a video (requires OAuth)')
    .requiredOption('--id <id>', 'Video ID to delete')
    .option(
      '--on-behalf-of-content-owner <id>',
      'Authenticate as a YouTube content partner',
    )
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
          await handle.videosDelete(opts.id, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify({ deleted: opts.id }, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  videos
    .command('rate')
    .description('Add or remove a rating on a video (requires OAuth)')
    .requiredOption('--id <id>', 'Video ID')
    .requiredOption('--rating <rating>', 'Rating value: like, dislike, or none')
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
          await handle.videosRate(opts.id, opts.rating);
          console.log(
            JSON.stringify({ id: opts.id, rating: opts.rating }, null, 2),
          );
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });
}
