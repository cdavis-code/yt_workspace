import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerSubscriptionsCommand(program: Command): void {
  const subscriptions = program
    .command('subscriptions')
    .description('YouTube subscription operations');

  subscriptions
    .command('list')
    .description('List subscriptions')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--channel-id <channelId>', 'Channel ID')
    .option('--mine', 'List subscriptions for the authenticated user')
    .option('--max-results <n>', 'Maximum number of results')
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
          const result = await handle.subscriptionsList(
            opts.part,
            opts.channelId,
            opts.mine ?? false,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
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

  subscriptions
    .command('insert')
    .description('Create a subscription')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .requiredOption('--body <json>', 'JSON body for the request')
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
          const body = JSON.parse(opts.body);
          const result = await handle.subscriptionsInsert(opts.part, body);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  subscriptions
    .command('delete')
    .description('Delete a subscription')
    .requiredOption('--id <id>', 'Subscription ID to delete')
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
          const result = await handle.subscriptionsDelete(opts.id);
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
