import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerActivitiesCommand(program: Command): void {
  const activities = program
    .command('activities')
    .description('YouTube activity operations');

  activities
    .command('list')
    .description('List YouTube activities')
    .option('--part <parts>', 'Resource parts to include', 'snippet,contentDetails')
    .option('--channel-id <id>', 'Channel ID')
    .option('--mine', 'List activities for the authenticated user')
    .option('--max-results <n>', 'Maximum number of results', '5')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--published-after <date>', 'Filter by publish date (RFC 3339)')
    .option('--published-before <date>', 'Filter by publish date (RFC 3339)')
    .option('--region-code <code>', 'Region code (ISO 3166-1 alpha-2)')
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
          const result = await handle.activitiesList(
            opts.channelId,
            opts.mine ?? false,
            opts.part,
            parseInt(opts.maxResults, 10),
            opts.pageToken,
            opts.publishedAfter,
            opts.publishedBefore,
            opts.regionCode,
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
