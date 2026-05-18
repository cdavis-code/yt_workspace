import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerMembersCommand(program: Command): void {
  const members = program
    .command('members')
    .description('YouTube channel members operations');

  members
    .command('list')
    .description('List channel members')
    .option('--part <parts>', 'Resource parts to include', 'snippet')
    .option('--mode <mode>', 'Filter mode (list_members, updates)')
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
          const result = await handle.membersList(
            opts.part,
            opts.mode,
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
}
