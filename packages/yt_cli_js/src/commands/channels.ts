import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerChannelsCommand(program: Command): void {
  const channels = program.command('channels').description('YouTube channel operations');

  channels
    .command('list')
    .description('List YouTube channels')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--id <id>', 'Channel ID')
    .option('--for-username <name>', 'Channel username')
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
          const result = await handle.channelsList(
            opts.part,
            opts.id,
            opts.forUsername,
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

  channels
    .command('update')
    .description('Update a YouTube channel resource (requires OAuth)')
    .option(
      '--part <parts>',
      'Resource parts to update',
      'contentDetails,id,localizations,player,snippet,status',
    )
    .requiredOption('--body <json>', 'Channel resource as a JSON string')
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
          const result = await handle.channelsUpdate(
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
}
