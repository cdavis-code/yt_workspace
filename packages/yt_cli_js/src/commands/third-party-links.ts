import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerThirdPartyLinksCommand(program: Command): void {
  const thirdPartyLinks = program
    .command('third-party-links')
    .description('YouTube third-party links operations');

  thirdPartyLinks
    .command('list')
    .description('List third-party links')
    .option('--part <parts>', 'Resource parts to include', 'snippet,status')
    .option('--external-channel-id <id>', 'YouTube channel ID')
    .option('--linking-token <token>', 'Unique linking token')
    .option('--type <type>', 'Type of link being retrieved')
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
          const result = await handle.thirdPartyLinksList(
            opts.part,
            opts.externalChannelId,
            opts.linkingToken,
            opts.type,
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

  thirdPartyLinks
    .command('insert')
    .description('Post a third-party link (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet,status')
    .requiredOption('--body <json>', 'Third-party link resource as a JSON string')
    .option('--external-channel-id <id>', 'YouTube channel ID')
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
          const result = await handle.thirdPartyLinksInsert(
            opts.part,
            body,
            opts.externalChannelId,
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

  thirdPartyLinks
    .command('update')
    .description('Update a third-party link (requires OAuth)')
    .option('--part <parts>', 'Resource parts to include', 'snippet,status')
    .requiredOption('--body <json>', 'Third-party link resource as a JSON string')
    .option('--external-channel-id <id>', 'YouTube channel ID')
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
          const result = await handle.thirdPartyLinksUpdate(
            opts.part,
            body,
            opts.externalChannelId,
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

  thirdPartyLinks
    .command('delete')
    .description('Delete a third-party link (requires OAuth)')
    .requiredOption('--linking-token <token>', 'Unique linking token')
    .requiredOption('--type <type>', 'Type of link being deleted')
    .option('--part <parts>', 'Resource parts to include')
    .option('--external-channel-id <id>', 'YouTube channel ID')
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
          await handle.thirdPartyLinksDelete(
            opts.linkingToken,
            opts.type,
            opts.part,
            opts.externalChannelId,
          );
          console.log(JSON.stringify({ deleted: opts.linkingToken }, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });
}
