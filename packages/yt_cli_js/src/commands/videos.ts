import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerVideosCommand(program: Command): void {
  const videos = program.command('videos').description('YouTube video operations');

  videos
    .command('list')
    .description('List YouTube videos')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--id <id>', 'Video ID')
    .option('--chart <chart>', 'Chart to retrieve (e.g. mostPopular)')
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
          const result = await handle.videosList(
            opts.id,
            opts.chart,
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
}
