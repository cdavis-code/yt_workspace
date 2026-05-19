/**
 * youtube-cli — YouTube Data API CLI powered by yt_cli_js (dart2js).
 *
 * Usage:
 *   youtube-cli search list --q "dart lang"
 *   youtube-cli videos list --id dQw4w9WgXcQ
 *   youtube-cli channels list --for-username Google
 */

import { Command } from 'commander';
import { createRequire } from 'node:module';
import { registerSearchCommand } from './commands/search.js';
import { registerChannelsCommand } from './commands/channels.js';
import { registerVideosCommand } from './commands/videos.js';
import { registerPlaylistsCommand } from './commands/playlists.js';
import { registerActivitiesCommand } from './commands/activities.js';
import { registerBroadcastCommand } from './commands/broadcast.js';
import { registerStreamCommand } from './commands/stream.js';
import { registerCommentsCommand } from './commands/comments.js';
import { registerCommentThreadsCommand } from './commands/comment-threads.js';
import { registerSubscriptionsCommand } from './commands/subscriptions.js';
import { registerThumbnailsCommand } from './commands/thumbnails.js';
import { registerWatermarksCommand } from './commands/watermarks.js';
import { registerMembersCommand } from './commands/members.js';
import { registerMembershipsLevelsCommand } from './commands/memberships-levels.js';
import { registerVideoCategoriesCommand } from './commands/video-categories.js';
import { registerVideoAbuseReportReasonsCommand } from './commands/video-abuse-report-reasons.js';
import { registerCaptionsCommand } from './commands/captions.js';
import { registerChannelBannersCommand } from './commands/channel-banners.js';
import { registerChannelSectionsCommand } from './commands/channel-sections.js';
import { registerI18nLanguagesCommand } from './commands/i18n-languages.js';
import { registerI18nRegionsCommand } from './commands/i18n-regions.js';
import { registerPlaylistImagesCommand } from './commands/playlist-images.js';
import { registerPlaylistItemsCommand } from './commands/playlist-items.js';
import { registerThirdPartyLinksCommand } from './commands/third-party-links.js';
import { registerAnalyticsCommand } from './commands/analytics.js';
import { registerAuthorizeCommand } from './commands/authorize.js';
import { registerVersionCommand } from './commands/version.js';

const require = createRequire(import.meta.url);
const pkg = require('../package.json') as { version: string };

const program = new Command();

program
  .name('youtube-cli')
  .version(pkg.version)
  .description('YouTube Data API CLI tool for Node.js')
  .option('--api-key <key>', 'YouTube Data API key (or set YT_API_KEY env var)')
  .option('--log-level <level>', 'Log level (all, debug, info, warning, error)', 'off');

// Register subcommands
registerSearchCommand(program);
registerChannelsCommand(program);
registerVideosCommand(program);
registerPlaylistsCommand(program);
registerActivitiesCommand(program);
registerBroadcastCommand(program);
registerStreamCommand(program);
registerCommentsCommand(program);
registerCommentThreadsCommand(program);
registerSubscriptionsCommand(program);
registerThumbnailsCommand(program);
registerWatermarksCommand(program);
registerMembersCommand(program);
registerMembershipsLevelsCommand(program);
registerVideoCategoriesCommand(program);
registerVideoAbuseReportReasonsCommand(program);
registerCaptionsCommand(program);
registerChannelBannersCommand(program);
registerChannelSectionsCommand(program);
registerI18nLanguagesCommand(program);
registerI18nRegionsCommand(program);
registerPlaylistImagesCommand(program);
registerPlaylistItemsCommand(program);
registerThirdPartyLinksCommand(program);
registerAnalyticsCommand(program);
registerAuthorizeCommand(program);
registerVersionCommand(program);

program.parseAsync(process.argv).catch((err: any) => {
  console.error(`Error: ${err.message ?? err}`);
  process.exit(1);
});
