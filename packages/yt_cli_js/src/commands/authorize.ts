import { Command } from 'commander';

export function registerAuthorizeCommand(program: Command): void {
  program
    .command('authorize')
    .description('OAuth authorization information')
    .action(() => {
      console.log('OAuth authorization is handled via environment variables.');
      console.log('');
      console.log('Set the following environment variables:');
      console.log('  YT_API_KEY              - YouTube Data API key');
      console.log('  YT_ACCESS_TOKENS_FILE   - Path to OAuth access tokens file');
      console.log('  YT_CLIENT_SECRETS_FILE  - Path to OAuth client secrets file');
    });
}
