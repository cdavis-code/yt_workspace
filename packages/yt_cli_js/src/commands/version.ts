import { Command } from 'commander';
import { getRuntime } from '../runtime.js';

export function registerVersionCommand(program: Command): void {
  program
    .command('runtime-version')
    .description('Print the Dart runtime version')
    .action(async () => {
      try {
        const ns = await getRuntime();
        console.log(`youtube-cli runtime version: ${ns.version}`);
      } catch (err: any) {
        console.error(`Error: ${err.message ?? err}`);
        process.exit(1);
      }
    });
}
