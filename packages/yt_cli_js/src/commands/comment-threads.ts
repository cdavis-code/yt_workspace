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
    .command('list-by-video-id')
    .description('List comment threads for a specific video')
    .requiredOption('--video-id <id>', 'Video ID')
    .option('--max-results <n>', 'Maximum number of results')
    .option('--order <order>', 'Sort order (time, relevance)')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--search-terms <terms>', 'Restrict to threads matching search terms')
    .option('--text-format <format>', 'Text format (html, plainText)')
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
          const result = await handle.commentThreadsListByVideoId(
            opts.videoId,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
            opts.order,
            opts.pageToken,
            opts.searchTerms,
            opts.textFormat,
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
    .command('list-by-channel-id')
    .description('List all comment threads related to a channel')
    .requiredOption('--channel-id <id>', 'Channel ID')
    .option('--max-results <n>', 'Maximum number of results')
    .option('--order <order>', 'Sort order (time, relevance)')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--search-terms <terms>', 'Restrict to threads matching search terms')
    .option('--text-format <format>', 'Text format (html, plainText)')
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
          const result = await handle.commentThreadsListByChannelId(
            opts.channelId,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
            opts.order,
            opts.pageToken,
            opts.searchTerms,
            opts.textFormat,
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
    .command('list-by-ids')
    .description('List comment threads by multiple IDs')
    .requiredOption('--ids <ids>', 'Comma-separated comment thread IDs')
    .option('--max-results <n>', 'Maximum number of results')
    .option('--order <order>', 'Sort order (time, relevance)')
    .option('--page-token <token>', 'Page token for pagination')
    .option('--search-terms <terms>', 'Restrict to threads matching search terms')
    .option('--text-format <format>', 'Text format (html, plainText)')
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
          const result = await handle.commentThreadsListByIds(
            opts.ids,
            opts.maxResults ? parseInt(opts.maxResults, 10) : undefined,
            opts.order,
            opts.pageToken,
            opts.searchTerms,
            opts.textFormat,
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

  commentThreads
    .command('add')
    .description('Add a top-level comment thread to a video')
    .requiredOption('--video-id <id>', 'Video ID')
    .requiredOption('--text <text>', 'Comment text (textOriginal)')
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
          const result = await handle.commentThreadsAdd(opts.videoId, opts.text);
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
