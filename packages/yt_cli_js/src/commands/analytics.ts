import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerAnalyticsCommand(program: Command): void {
  const analytics = program
    .command('analytics')
    .description('YouTube Analytics operations');

  analytics
    .command('query')
    .description('Query YouTube Analytics data')
    .requiredOption('--ids <ids>', 'Channel or content owner IDs (e.g., channel==MINE)')
    .requiredOption('--start-date <date>', 'Start date (YYYY-MM-DD)')
    .requiredOption('--end-date <date>', 'End date (YYYY-MM-DD)')
    .requiredOption('--metrics <metrics>', 'Comma-separated metrics (e.g., views,likes)')
    .option('--dimensions <dimensions>', 'Comma-separated dimensions')
    .option('--filters <filters>', 'Semicolon-separated filters')
    .option('--sort <sort>', 'Comma-separated sort fields')
    .option('--max-results <n>', 'Maximum number of results')
    .option('--start-index <n>', 'Start index for pagination')
    .option('--currency <currency>', 'Currency code (ISO 4217)')
    .option('--include-historical-channel-data', 'Include historical channel data')
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
          const result = await handle.analyticsQuery(
            opts.ids,
            opts.startDate,
            opts.endDate,
            opts.metrics,
            opts.dimensions,
            opts.filters,
            opts.sort,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
            opts.startIndex ? parseInt(opts.startIndex, 10) : undefined,
            opts.currency,
            opts.includeHistoricalChannelData ?? false,
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

  analytics
    .command('groups-list')
    .description('List analytics groups')
    .option('--id <id>', 'Group ID')
    .option('--mine', 'List groups for the authenticated user')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupsList(
            opts.id,
            opts.mine ?? false,
            opts.pageToken,
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

  analytics
    .command('groups-insert')
    .description('Create an analytics group')
    .requiredOption('--body <json>', 'JSON body for the request')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupsInsert(body, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  analytics
    .command('groups-update')
    .description('Update an analytics group')
    .requiredOption('--body <json>', 'JSON body for the request')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupsUpdate(body, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  analytics
    .command('groups-delete')
    .description('Delete an analytics group')
    .requiredOption('--id <id>', 'Group ID to delete')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupsDelete(opts.id, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  analytics
    .command('group-items-list')
    .description('List items in an analytics group')
    .option('--group-id <groupId>', 'Group ID')
    .option('--id <id>', 'Group item ID')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupItemsList(
            opts.groupId,
            opts.id,
            opts.pageToken,
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

  analytics
    .command('group-items-insert')
    .description('Add an item to an analytics group')
    .requiredOption('--body <json>', 'JSON body for the request')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupItemsInsert(body, opts.onBehalfOfContentOwner);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  analytics
    .command('group-items-delete')
    .description('Remove an item from an analytics group')
    .requiredOption('--id <id>', 'Group item ID to delete')
    .option('--on-behalf-of-content-owner <owner>', 'Content owner ID')
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
          const result = await handle.analyticsGroupItemsDelete(opts.id, opts.onBehalfOfContentOwner);
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
