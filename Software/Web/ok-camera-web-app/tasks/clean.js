/**
 * Clean Task
 */
import del from 'del';
import paths from './lib/paths';

/**
 * Delete destination folder
 */
const cleanDestDir = () => {
  return del(paths.destDir);
};

/**
 * Export
 */
export default cleanDestDir
