import { Command } from 'commander';
import type { YtCliJsHandle, YtCliJsNamespace } from '../types.js';
import { getRuntime } from '../runtime.js';

export function registerCommentThreadsCommand(program: Command): void {
  const commentThreads = program
    .command('comment-threads')
    .description('YouTube comment thread operations');

  commentThreads
    .command('list')
    .description('List comment threads')
    .option('--part <parts>', 'Resource parts to include', 'id,replies,snippet')
    .option('--video-id <videoId>', 'Video ID')
    .option('--channel-id <channelId>', 'Channel ID')
    .option('--id <id>', 'Comment thread ID')
    .option('--max-results <n>', 'Maximum number of results')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--order <order>', 'Sort order (time, relevance)')
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
          const result = await handle.commentThreadsList(
            opts.part,
            opts.videoId,
            opts.channelId,
            opts.id,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
            opts.pageToken,
            opts.order,
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

  commentThreads
    .command('list-by-id')
    .description('Get a single comment thread by ID')
    .requiredOption('--id <id>', 'Comment thread ID')
    .option('--part <parts>', 'Resource parts to include', 'id,replies,snippet')
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
          const result = await handle.commentThreadsListById(opts.id, opts.part);
          console.log(JSON.stringify(result, null, 2));
        } finally {
          handle.close();
        }
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });

  commentThreads
    .command('insert')
    .description('Create a comment thread')
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
          const result = await handle.commentThreadsInsert(opts.part, body);
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
