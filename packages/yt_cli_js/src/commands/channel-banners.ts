import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerChannelBannersCommand(program: Command): void {
  const channelBanners = program
    .command('channel-banners')
    .description('YouTube channel banner operations');

  channelBanners
    .command('insert')
    .description('Upload a channel banner image (requires OAuth)')
    .requiredOption('--file <file>', 'Path to the banner image file')
    .option('--channel-id <id>', 'Channel ID to associate the banner with')
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
          const result = await handle.channelBannersInsert(opts.file, opts.channelId);
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
