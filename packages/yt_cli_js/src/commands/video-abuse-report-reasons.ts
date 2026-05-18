import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerVideoAbuseReportReasonsCommand(program: Command): void {
  const videoAbuseReportReasons = program
    .command('video-abuse-report-reasons')
    .description('YouTube video abuse report reasons operations');

  videoAbuseReportReasons
    .command('list')
    .description('List video abuse report reasons')
    .option('--part <parts>', 'Resource parts to include', 'id,snippet')
    .option('--hl <hl>', 'Language for localized text (BCP-47)')
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
          const result = await handle.videoAbuseReportReasonsList(opts.part, opts.hl);
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
