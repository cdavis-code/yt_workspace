import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerSearchCommand(program: Command): void {
  const search = program.command('search').description('YouTube search operations');

  search
    .command('list')
    .description('Search for YouTube resources')
    .requiredOption('--q <query>', 'Search query')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--type <type>', 'Resource type filter (video, channel, playlist)')
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
          const result = await handle.searchList(
            opts.q,
            opts.part,
            opts.type,
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
}
