import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerPlaylistImagesCommand(program: Command): void {
  const playlistImages = program
    .command('playlist-images')
    .description('YouTube playlist images operations');

  playlistImages
    .command('list')
    .description('List playlist images')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--parent <playlistId>', 'Playlist ID')
    .option('--max-results <n>', 'Maximum number of results', '5')
    .option('--page-token <token>', 'Page token for pagination')
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
          const result = await handle.playlistImagesList(
            opts.part,
            opts.parent,
            parseInt(opts.maxResults, 10),
            opts.pageToken,
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

  playlistImages
    .command('insert')
    .description('Upload a custom playlist image (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--parent <playlistId>', 'Playlist ID')
    .requiredOption('--file <file>', 'Path to the playlist image file')
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
          const result = await handle.playlistImagesInsert(opts.part, opts.parent, opts.file);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  playlistImages
    .command('update')
    .description('Replace an existing playlist image (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'id,snippet')
    .requiredOption('--file <file>', 'Path to the updated playlist image')
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
          const result = await handle.playlistImagesUpdate(opts.part, opts.file);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  playlistImages
    .command('delete')
    .description('Delete a playlist image (requires OAuth)')
    .requiredOption('--id <id>', 'Playlist image ID to delete')
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
          await handle.playlistImagesDelete(opts.id);
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
