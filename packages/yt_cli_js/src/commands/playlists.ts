import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerPlaylistsCommand(program: Command): void {
  const playlists = program.command('playlists').description('YouTube playlist operations');

  playlists
    .command('list')
    .description('List YouTube playlists')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--channel-id <id>', 'Channel ID to list playlists for')
    .option('--id <id>', 'Playlist ID')
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
          const result = await handle.playlistsList(
            opts.channelId,
            opts.id,
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

  playlists
    .command('insert')
    .description('Create a new playlist (requires OAuth)')
    .option(
      '--part <parts>',
      'Resource parts to include',
      'snippet,status',
    )
    .requiredOption('--body <json>', 'Playlist resource as a JSON string')
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
          const body = JSON.parse(opts.body);
          const result = await handle.playlistsInsert(
            opts.part,
            body,
            opts.onBehalfOfContentOwner,
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

  playlists
    .command('update')
    .description('Update an existing playlist (requires OAuth)')
    .option(
      '--part <parts>',
      'Resource parts to update',
      'contentDetails,id,localizations,player,snippet,status',
    )
    .requiredOption('--body <json>', 'Playlist resource as a JSON string')
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
          const body = JSON.parse(opts.body);
          const result = await handle.playlistsUpdate(
            opts.part,
            body,
            opts.onBehalfOfContentOwner,
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

  playlists
    .command('delete')
    .description('Delete a playlist (requires OAuth)')
    .requiredOption('--id <id>', 'Playlist ID to delete')
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
          await handle.playlistsDelete(opts.id, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify({ deleted: opts.id }, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });
}
