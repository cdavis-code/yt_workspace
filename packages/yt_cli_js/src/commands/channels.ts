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
}
