import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerChannelSectionsCommand(program: Command): void {
  const channelSections = program
    .command('channel-sections')
    .description('YouTube channel sections operations');

  channelSections
    .command('list')
    .description('List channel sections')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--channel-id <id>', 'YouTube channel ID')
    .option('--id <id>', 'Comma-separated list of channel section IDs')
    .option('--mine', 'Retrieve the authenticated user\'s channel sections')
    .option('--hl <hl>', 'Language for localized text (BCP-47)')
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
          const result = await handle.channelSectionsList(
            opts.part,
            opts.channelId,
            opts.id,
            opts.mine || false,
            opts.hl,
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

  channelSections
    .command('insert')
    .description('Add a channel section (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--body <json>', 'Channel section resource as a JSON string')
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
          const result = await handle.channelSectionsInsert(opts.part, body);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  channelSections
    .command('update')
    .description('Update a channel section (requires OAuth)')
    .requiredOption('--part <parts>', 'Resource parts to update')
    .requiredOption('--body <json>', 'Channel section resource as a JSON string')
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
          const result = await handle.channelSectionsUpdate(opts.part, body);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  channelSections
    .command('delete')
    .description('Delete a channel section (requires OAuth)')
    .requiredOption('--id <id>', 'Channel section ID to delete')
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
          await handle.channelSectionsDelete(opts.id);
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
